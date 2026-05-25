#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_NAME="client-delivery"
LEGACY_SKILL_NAME="${LEGACY_SKILL_NAME:-}"
SOURCE_DIR="${ROOT_DIR}/${SKILL_NAME}"
DRY_RUN=0
TARGETS=()

usage() {
  cat <<'EOF'
Install the client-delivery skill locally.

Usage:
  ./install.sh [--target TARGET] [--dry-run] [--help]

Targets:
  codex        Install to ~/.codex/skills/client-delivery (default)
  claude-code  Install to ~/.claude/skills/client-delivery
  agents       Install to ~/.agents/skills/client-delivery
  all          Install to codex, claude-code, and agents

Environment:
  CODEX_HOME        Override Codex home. Default: ~/.codex
  CLAUDE_HOME       Override Claude Code home. Default: ~/.claude
  AGENTS_HOME       Override shared agents home. Default: ~/.agents
  LEGACY_SKILL_NAME Optional previous local skill directory to back up.
  SKILL_TARGET_DIR  Override install target directory for a single custom install.
  SKILL_BACKUP_DIR  Override backup directory. Default: <target skills root>/.backups
EOF
}

add_target() {
  local target="$1"
  case "${target}" in
    all)
      add_target codex
      add_target claude-code
      add_target agents
      ;;
    codex|claude-code|agents)
      TARGETS+=("${target}")
      ;;
    *)
      echo "ERROR: unknown target: ${target}" >&2
      usage >&2
      exit 2
      ;;
  esac
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      if [[ -z "${2:-}" ]]; then
        echo "ERROR: --target requires a value" >&2
        exit 2
      fi
      add_target "$2"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

if [[ ! -f "${SOURCE_DIR}/SKILL.md" ]]; then
  echo "ERROR: ${SOURCE_DIR}/SKILL.md not found" >&2
  exit 1
fi

if [[ ! -f "${SOURCE_DIR}/agents/openai.yaml" ]]; then
  echo "ERROR: ${SOURCE_DIR}/agents/openai.yaml not found" >&2
  exit 1
fi

if [[ -n "${SKILL_TARGET_DIR:-}" ]]; then
  if [[ "${#TARGETS[@]}" -gt 0 ]]; then
    echo "ERROR: SKILL_TARGET_DIR cannot be combined with --target" >&2
    exit 2
  fi
  TARGETS=(custom)
elif [[ "${#TARGETS[@]}" -eq 0 ]]; then
  TARGETS=(codex)
fi

target_root() {
  case "$1" in
    codex)
      printf '%s/skills' "${CODEX_HOME:-${HOME}/.codex}"
      ;;
    claude-code)
      printf '%s/skills' "${CLAUDE_HOME:-${HOME}/.claude}"
      ;;
    agents)
      printf '%s/skills' "${AGENTS_HOME:-${HOME}/.agents}"
      ;;
    custom)
      dirname "${SKILL_TARGET_DIR}"
      ;;
  esac
}

target_dir() {
  case "$1" in
    custom)
      printf '%s' "${SKILL_TARGET_DIR}"
      ;;
    *)
      printf '%s/%s' "$(target_root "$1")" "${SKILL_NAME}"
      ;;
  esac
}

target_label() {
  case "$1" in
    codex) printf 'Codex' ;;
    claude-code) printf 'Claude Code' ;;
    agents) printf 'Shared agents' ;;
    custom) printf 'Custom' ;;
  esac
}

dedupe_targets() {
  local target
  local deduped_string=""
  for target in "${TARGETS[@]}"; do
    if [[ " ${deduped_string} " != *" ${target} "* ]]; then
      deduped_string="${deduped_string} ${target}"
    fi
  done
  # shellcheck disable=SC2206
  TARGETS=(${deduped_string})
}

prepare_staging() {
  local target="$1"
  local parent="$2"
  local staging_dir

  staging_dir="$(mktemp -d "${parent}/.client-delivery-install.XXXXXX")"
  cp -R "${SOURCE_DIR}/." "${staging_dir}/"
  find "${staging_dir}" -name '.DS_Store' -o -name 'Thumbs.db' -o -name '__MACOSX' | while IFS= read -r metadata_file; do
    rm -rf "${metadata_file}"
  done

  if [[ "${target}" == "claude-code" ]]; then
    rm -f "${staging_dir}/agents/openai.yaml"
    rmdir "${staging_dir}/agents" 2>/dev/null || true
  fi

  printf '%s' "${staging_dir}"
}

backup_existing_dir() {
  local existing_dir="$1"
  local backup_root="$2"
  local backup_name="$3"

  if [[ -d "${existing_dir}" ]]; then
    local backup_dir="${backup_root}/${backup_name}.$(date +%Y%m%d%H%M%S)"
    mv "${existing_dir}" "${backup_dir}"
    printf 'Backed up %s to %s\n' "${existing_dir}" "${backup_dir}"
  fi
}

install_target() {
  local target="$1"
  local root target_path parent backup_root legacy_path staging_dir label

  root="$(target_root "${target}")"
  target_path="$(target_dir "${target}")"
  parent="$(dirname "${target_path}")"
  backup_root="${SKILL_BACKUP_DIR:-${root}/.backups}"
  legacy_path=""
  if [[ -n "${LEGACY_SKILL_NAME}" ]]; then
    legacy_path="${parent}/${LEGACY_SKILL_NAME}"
  fi
  label="$(target_label "${target}")"

  printf '\n[%s]\n' "${label}"
  printf 'Source: %s\n' "${SOURCE_DIR}"
  printf 'Target: %s\n' "${target_path}"

  if [[ "${DRY_RUN}" -eq 1 ]]; then
    if [[ -d "${target_path}" ]]; then
      printf 'Dry run: existing target would be backed up under %s\n' "${backup_root}"
    fi
    if [[ -n "${legacy_path}" && -d "${legacy_path}" && "${legacy_path}" != "${target_path}" ]]; then
      printf 'Dry run: legacy install would be backed up from %s\n' "${legacy_path}"
    fi
    echo 'Dry run: no files changed.'
    return
  fi

  mkdir -p "${parent}" "${backup_root}"
  staging_dir="$(prepare_staging "${target}" "${parent}")"

  cleanup() {
    rm -rf "${staging_dir}"
  }
  trap cleanup EXIT

  backup_existing_dir "${target_path}" "${backup_root}" "${SKILL_NAME}"
  if [[ -n "${legacy_path}" && "${legacy_path}" != "${target_path}" ]]; then
    backup_existing_dir "${legacy_path}" "${backup_root}" "${LEGACY_SKILL_NAME}"
  fi

  mv "${staging_dir}" "${target_path}"
  trap - EXIT

  if [[ ! -f "${target_path}/SKILL.md" ]]; then
    echo "ERROR: install verification failed: ${target_path}/SKILL.md missing" >&2
    exit 1
  fi

  printf 'Installed client-delivery skill to %s\n' "${target_path}"
}

dedupe_targets

for target in "${TARGETS[@]}"; do
  install_target "${target}"
done
