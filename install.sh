#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${ROOT_DIR}/evatika-project-delivery"
TARGET_DIR="${HOME}/.codex/skills/evatika-project-delivery"

if [[ ! -f "${SOURCE_DIR}/SKILL.md" ]]; then
  echo "ERROR: ${SOURCE_DIR}/SKILL.md not found"
  exit 1
fi

mkdir -p "$(dirname "${TARGET_DIR}")"
rm -rf "${TARGET_DIR}"
cp -R "${SOURCE_DIR}" "${TARGET_DIR}"

echo "Installed evatika-project-delivery skill to ${TARGET_DIR}"

