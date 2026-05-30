#!/usr/bin/env bash
# deploy_skill.sh — déploie un skill vers les 4 cibles (cf project_skills.md §Emplacements)
# Source de vérité : ~/Developer/projects/skills/<skill>/SKILL.md
# Usage : bash deploy_skill.sh <skill> [<skill2> ...]
#   --no-push  : ne pas git push (commit local seulement)
# Robuste : chaque cible absente/injoignable est SAUTÉE (⊘) sans faire échouer le reste.
set -uo pipefail

SRC_REPO="$HOME/Developer/projects/skills"
CLI_DIR="$HOME/.claude/skills"
# Desktop : UUIDs figés (project_skills.md) + fallback glob dynamique
DESK_BASE="$HOME/Library/Application Support/Claude/local-agent-mode-sessions/skills-plugin"
DESK_FIXED="$DESK_BASE/022610ea-2aef-41e0-8242-dd1ade1aeb38/19115832-a29d-46e4-8c07-3de0af9e1224/skills"
NAS_HOST="${NAS_HOST:-nas}"                       # alias ~/.ssh/config (clé id_ed25519_github)
NAS_DIR="/volume1/docker/redapi/data/skills"

PUSH=1; SKILLS=()
for a in "$@"; do [ "$a" = "--no-push" ] && PUSH=0 || SKILLS+=("$a"); done
[ "${#SKILLS[@]}" -eq 0 ] && { echo "usage: bash deploy_skill.sh <skill> [--no-push]"; exit 2; }

ok(){ printf '  ✓ %s\n' "$1"; }
skip(){ printf '  ⊘ %s\n' "$1"; }

resolve_desktop(){  # echo le dossier skills Desktop s'il existe, sinon vide
  [ -d "$DESK_FIXED" ] && { echo "$DESK_FIXED"; return; }
  local d; d=$(ls -d "$DESK_BASE"/*/*/skills 2>/dev/null | head -1); [ -n "$d" ] && echo "$d"
}

for SKILL in "${SKILLS[@]}"; do
  SRC="$SRC_REPO/$SKILL/SKILL.md"
  echo "▸ $SKILL"
  [ -f "$SRC" ] || { skip "source absente ($SRC) — rien à déployer"; continue; }

  # 1. CLI
  mkdir -p "$CLI_DIR/$SKILL" && cp "$SRC" "$CLI_DIR/$SKILL/SKILL.md" && ok "CLI  $CLI_DIR/$SKILL/" || skip "CLI échec"

  # 2. Desktop (sauté si app non installée)
  DESK=$(resolve_desktop)
  if [ -n "$DESK" ]; then mkdir -p "$DESK/$SKILL" && cp "$SRC" "$DESK/$SKILL/SKILL.md" && ok "Desktop $DESK/$SKILL/"; else skip "Desktop (skills-plugin absent — app non installée ici)"; fi

  # 3. NAS (scp -O legacy ; sauté si injoignable en 5 s)
  if ssh -o BatchMode=yes -o ConnectTimeout=5 "$NAS_HOST" "mkdir -p $NAS_DIR/$SKILL" 2>/dev/null; then
    scp -O -q "$SRC" "$NAS_HOST:$NAS_DIR/$SKILL/SKILL.md" 2>/dev/null && ok "NAS  $NAS_HOST:$NAS_DIR/$SKILL/" || skip "NAS copie échec"
  else skip "NAS ($NAS_HOST injoignable — réseau local requis)"; fi
done

# 4. GitHub (un seul commit pour tous les skills déployés)
cd "$SRC_REPO" || exit 1
if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
  git add -A
  git commit -q -m "deploy: ${SKILLS[*]} ($(date -u +%Y-%m-%d))" && ok "commit local"
  if [ "$PUSH" -eq 1 ]; then git push -q origin HEAD 2>/dev/null && ok "push origin" || skip "push (réseau/remote)"; else skip "push (--no-push)"; fi
else
  skip "GitHub (aucun changement à committer)"
fi
echo "✅ terminé."
