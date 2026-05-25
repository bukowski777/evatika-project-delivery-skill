#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_DIR="${ROOT_DIR}/evatika-project-delivery"
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
  "README.md"
  "MAINTENANCE.md"
  "SECURITY.md"
  "CONTRIBUTING.md"
  "CHANGELOG.md"
  "install.sh"
  "scripts/package-skill.sh"
  ".github/workflows/release.yml"
  "evatika-project-delivery/SKILL.md"
  "evatika-project-delivery/agents/openai.yaml"
  "evatika-project-delivery/references/project-discovery.md"
  "evatika-project-delivery/references/integration-contracts.md"
  "evatika-project-delivery/references/production-release.md"
  "evatika-project-delivery/references/diagnosis-and-observability.md"
  "evatika-project-delivery/references/ux-mobile-review.md"
  "evatika-project-delivery/references/documentation-and-handover.md"
  "evatika-project-delivery/references/security-and-data-handling.md"
  "evatika-project-delivery/references/testing-and-quality-gates.md"
  "evatika-project-delivery/templates/delivery-report.md"
  "evatika-project-delivery/templates/incident-write-up.md"
  "evatika-project-delivery/templates/integration-request.md"
  "evatika-project-delivery/templates/release-plan.md"
  "evatika-project-delivery/templates/runbook.md"
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

  grep -Eq '^name: evatika-project-delivery$' "${SKILL_FILE}" || fail "SKILL.md frontmatter must define name: evatika-project-delivery"
  grep -Eq '^description: .{60,}$' "${SKILL_FILE}" || fail "SKILL.md frontmatter description is missing or too short"

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

secret_pattern='(AKIA[0-9A-Z]{16}|-----BEGIN (RSA |EC |OPENSSH |DSA )?PRIVATE KEY-----|ghp_[A-Za-z0-9_]{30,}|github_pat_[A-Za-z0-9_]{30,}|sk-[A-Za-z0-9]{20,}|xox[baprs]-[A-Za-z0-9-]{10,})'
secret_scan_file="$(mktemp "${TMPDIR:-/tmp}/evatika-secret-scan.XXXXXX")"
if grep -RInE "${secret_pattern}" \
  "${ROOT_DIR}/README.md" \
  "${ROOT_DIR}/MAINTENANCE.md" \
  "${ROOT_DIR}/SECURITY.md" \
  "${SKILL_DIR}" >"${secret_scan_file}"; then
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
