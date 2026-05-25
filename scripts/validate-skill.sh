#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_DIR="${ROOT_DIR}/client-delivery-guardrails"
SKILL_FILE="${SKILL_DIR}/SKILL.md"
AGENT_FILE="${SKILL_DIR}/agents/openai.yaml"
failures=0

fail() {
  echo "ERROR: $*" >&2
  failures=$((failures + 1))
}

require_file() {
  local file="$1"
  [[ -f "${ROOT_DIR}/${file}" ]] || fail "missing required file: ${file}"
}

required_files=(
  ".editorconfig"
  ".gitattributes"
  ".gitignore"
  "AGENTS.md"
  "LICENSE"
  "README.md"
  "MAINTENANCE.md"
  "SECURITY.md"
  "CONTRIBUTING.md"
  "CHANGELOG.md"
  "install.sh"
  "scripts/package-skill.sh"
  "scripts/test-install.sh"
  ".github/workflows/release.yml"
  ".github/workflows/validate.yml"
  "client-delivery-guardrails/SKILL.md"
  "client-delivery-guardrails/agents/openai.yaml"
  "client-delivery-guardrails/references/project-discovery.md"
  "client-delivery-guardrails/references/integration-contracts.md"
  "client-delivery-guardrails/references/production-release.md"
  "client-delivery-guardrails/references/diagnosis-and-observability.md"
  "client-delivery-guardrails/references/ux-mobile-review.md"
  "client-delivery-guardrails/references/documentation-and-handover.md"
  "client-delivery-guardrails/references/security-and-data-handling.md"
  "client-delivery-guardrails/references/testing-and-quality-gates.md"
  "client-delivery-guardrails/templates/delivery-report.md"
  "client-delivery-guardrails/templates/incident-write-up.md"
  "client-delivery-guardrails/templates/integration-request.md"
  "client-delivery-guardrails/templates/release-plan.md"
  "client-delivery-guardrails/templates/runbook.md"
)

for file in "${required_files[@]}"; do
  require_file "${file}"
done

if [[ -f "${SKILL_FILE}" ]]; then
  frontmatter_lines="$(grep -n '^---$' "${SKILL_FILE}" | cut -d: -f1 || true)"
  first_frontmatter_line="$(printf '%s\n' "${frontmatter_lines}" | sed -n '1p')"
  second_frontmatter_line="$(printf '%s\n' "${frontmatter_lines}" | sed -n '2p')"
  if [[ -z "${second_frontmatter_line}" || "${first_frontmatter_line}" != "1" ]]; then
    fail "SKILL.md must start with YAML frontmatter delimited by ---"
  fi

  grep -Eq '^name: [a-z0-9-]{1,64}$' "${SKILL_FILE}" || fail "invalid skill name format"
  grep -Eq '^name: client-delivery-guardrails$' "${SKILL_FILE}" || fail "SKILL.md frontmatter must define name: client-delivery-guardrails"
  grep -Eq '^description: .{60,}$' "${SKILL_FILE}" || fail "SKILL.md frontmatter description is missing or too short"
  description_line="$(grep -E '^description: ' "${SKILL_FILE}" | sed 's/^description: //')"
  description_length="${#description_line}"
  if [[ "${description_length}" -gt 700 ]]; then
    fail "SKILL.md description is too long: ${description_length} chars; keep it under 700"
  fi

  while IFS= read -r ref; do
    [[ -f "${SKILL_DIR}/${ref}" ]] || fail "router reference missing: ${ref}"
  done < <(grep -Eo '`(references|templates)/[^`]+\.md`' "${SKILL_FILE}" | tr -d '`' | sort -u)
fi

if [[ -f "${AGENT_FILE}" ]]; then
  grep -Eq '^interface:' "${AGENT_FILE}" || fail "openai.yaml must contain interface section"
  grep -Eq '^policy:' "${AGENT_FILE}" || fail "openai.yaml must contain policy section"
fi

bash -n "${ROOT_DIR}/install.sh" || fail "install.sh has shell syntax errors"
bash -n "${ROOT_DIR}/scripts/validate-skill.sh" || fail "scripts/validate-skill.sh has shell syntax errors"
if [[ -f "${ROOT_DIR}/scripts/package-skill.sh" ]]; then
  bash -n "${ROOT_DIR}/scripts/package-skill.sh" || fail "scripts/package-skill.sh has shell syntax errors"
fi
if [[ -f "${ROOT_DIR}/scripts/test-install.sh" ]]; then
  bash -n "${ROOT_DIR}/scripts/test-install.sh" || fail "scripts/test-install.sh has shell syntax errors"
fi

if command -v shellcheck >/dev/null 2>&1; then
  shellcheck "${ROOT_DIR}/install.sh" "${ROOT_DIR}"/scripts/*.sh || fail "shellcheck failed"
else
  echo "WARN: shellcheck not installed; skipping shell lint" >&2
fi

api_token_pattern='(AKIA[0-9A-Z]{16}|-----BEGIN (RSA |EC |OPENSSH |DSA )?PRIVATE KEY-----|ghp_[A-Za-z0-9_]{30,}|github_pat_[A-Za-z0-9_]{30,}|sk-[A-Za-z0-9]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}|[B]earer [A-Za-z0-9._~+/=-]{20,}|[e]yJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+)'
database_url_pattern='([p]ostgres|[m]ysql)://[^[:space:]]+'
connection_string_pattern='[S]erver=.*[P]assword='
secret_pattern="(${api_token_pattern}|${database_url_pattern}|${connection_string_pattern})"
secret_scan_file="$(mktemp "${TMPDIR:-/tmp}/client-delivery-guardrails-secret-scan.XXXXXX")"
if git -C "${ROOT_DIR}" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  while IFS= read -r -d '' file; do
    grep -IInE "${secret_pattern}" "${ROOT_DIR}/${file}" || true
  done < <(git -C "${ROOT_DIR}" ls-files -z) >"${secret_scan_file}"
else
  grep -RInIE "${secret_pattern}" \
    --exclude-dir=.git \
    --exclude-dir=dist \
    --exclude-dir=tmp \
    "${ROOT_DIR}" >"${secret_scan_file}" || true
fi

if [[ -s "${secret_scan_file}" ]]; then
  cat "${secret_scan_file}" >&2
  fail "possible secret-like value detected"
fi
rm -f "${secret_scan_file}"

metadata_files="$(find "${SKILL_DIR}" -name '.DS_Store' -o -name 'Thumbs.db' -o -name '__MACOSX' || true)"
if [[ -n "${metadata_files}" ]]; then
  printf '%s\n' "${metadata_files}" >&2
  fail "metadata files must not be included in the skill package"
fi

# Keep package size intentional. Skills should remain lightweight and readable.
file_count=$(find "${SKILL_DIR}" -type f | wc -l | tr -d ' ')
if [[ "${file_count}" -gt 40 ]]; then
  fail "skill package has ${file_count} files; expected 40 or fewer"
fi

if [[ "${failures}" -gt 0 ]]; then
  echo "Validation failed with ${failures} error(s)." >&2
  exit 1
fi

echo "Skill validation passed."
