#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${ROOT_DIR}/evatika-project-delivery"
DEFAULT_TARGET_DIR="${HOME}/.codex/skills/evatika-project-delivery"
TARGET_DIR="${SKILL_TARGET_DIR:-${DEFAULT_TARGET_DIR}}"
BACKUP_ROOT="${SKILL_BACKUP_DIR:-${HOME}/.codex/skills/.backups}"
DRY_RUN=0

usage() {
  cat <<'EOF'
Install the evatika-project-delivery Codex skill locally.

Usage:
  ./install.sh [--dry-run] [--help]

Environment:
  SKILL_TARGET_DIR   Override install target. Default: ~/.codex/skills/evatika-project-delivery
  SKILL_BACKUP_DIR   Override backup directory. Default: ~/.codex/skills/.backups
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
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

printf 'Source: %s
' "${SOURCE_DIR}"
printf 'Target: %s
' "${TARGET_DIR}"

if [[ "${DRY_RUN}" -eq 1 ]]; then
  if [[ -d "${TARGET_DIR}" ]]; then
    printf 'Dry run: existing target would be backed up under %s
' "${BACKUP_ROOT}"
  fi
  echo 'Dry run: no files changed.'
  exit 0
fi

TARGET_PARENT="$(dirname "${TARGET_DIR}")"
mkdir -p "${TARGET_PARENT}" "${BACKUP_ROOT}"

STAGING_DIR="$(mktemp -d "${TARGET_PARENT}/.evatika-install.XXXXXX")"
cleanup() {
  rm -rf "${STAGING_DIR}"
}
trap cleanup EXIT

cp -R "${SOURCE_DIR}/." "${STAGING_DIR}/"
find "${STAGING_DIR}" -name '.DS_Store' -delete

if [[ -d "${TARGET_DIR}" ]]; then
  BACKUP_DIR="${BACKUP_ROOT}/evatika-project-delivery.$(date +%Y%m%d%H%M%S)"
  mv "${TARGET_DIR}" "${BACKUP_DIR}"
  printf 'Backed up previous install to %s
' "${BACKUP_DIR}"
fi

mv "${STAGING_DIR}" "${TARGET_DIR}"
trap - EXIT

if [[ ! -f "${TARGET_DIR}/SKILL.md" ]]; then
  echo "ERROR: install verification failed: ${TARGET_DIR}/SKILL.md missing" >&2
  exit 1
fi

printf 'Installed evatika-project-delivery skill to %s
' "${TARGET_DIR}"
