---
name: polylens
description: >
  Audit/debugging multi-modèles orthogonaux. 7 axes (sécurité,
  qualité, tests, performance, architecture, documentation,
  adversarial) déclarés via audit_scope.yaml. Panel base 4 voix
  occidentales IMMUABLE (Claude+Codex+Gemini+Kimi) + voix chinoises
  AJOUTÉES par axe (GLM 5.1, MiniMax M2.7, MiMo V2.5-Pro, Qwen 3.6,
  qwen3-coder). Substitution interdite. Convergence cross-culturelle
  obligatoire pour P0. 5 phases gated, falsification PoC, méta-audit.
  DÉCLENCHEUR : /polylens. IMPLICITES : « audit complet », « audit
  multi-modèles », « peer review code », « pre-prod gate », « audit
  RGPD », « refonte sécu », « audit annuel », « stress test
  méthodique », « médico-juridique opposable ». NE S'ACTIVE PAS :
  bug fix simple <30min, ruff/format suffit, génération créative pure,
  questions conversationnelles. SYNERGIE : /jury pour challenge
  externe RedAPI, /expertise pour cadrage SST amont, /document pour
  formalisation aval. Référence canonique : v3 (2026-05-03),
  ~/.claude/projects/-Users-radu/memory/feedback_polylens_method.md.
---

# /polylens — Audit Multi-Modèles Orthogonaux — v3

## Acronyme

**POLYLENS** = Parallel Orthogonal Lens-based Yielding Empirical Network of Sentinels.

## Mantra

> Sept axes lus en parallèle. Le mécanisme causal arbitre. La régression scelle.

---

## Ce que fait /polylens (en 30 secondes)

Tu tapes `/polylens` suivi du périmètre (projet, module, PR, ou
audit annuel). Claude lance un audit multi-modèles orchestré sur
**7 axes** au choix, avec **panel cross-culturel** obligatoire,
falsification par PoC pour les findings critiques, et matrice de
consolidation déterministe. Output : findings hiérarchisés P0/P1
avec preuves reproductibles.

C'est le mode « rigueur médico-juridique » — pas un audit ad-hoc.

---

## Public et cas d'usage

- Médecin du travail / SPSTI : audits opposables sur outils maison
- Pre-prod gate avant ouverture publique
- Refonte sécu critique post-incident
- Audit annuel multi-projets

**Ce n'est PAS** un linter, un fixer auto, ni un brainstorming. Pour bug fix simple → fix direct. Pour controverses méthodologiques → `/jury`.

---

## Phase 0 obligatoire — déclaration du scope

Avant tout LLM, produire `audit_scope.yaml` :

```yaml
audit_scope:
  name: nom_du_run
  date: "YYYY-MM-DD"
  axes_actives: [A_security, B_quality, C_tests, D_performance, E_architecture, F_documentation, G_adversarial]
  axes_exclus: []
  raison_exclusion: ""
  cible: [mcp_meddata, mcp_redapi, ...]
  contexte: "Audit annuel pré-prod"
  voix_par_axe:
    A: [kimi, codex, qwen36]
    B: [kimi, codex, minimax]
    C: [codex, gemini, qwen3coder]
    D: [codex, gemini, mimov2]
    E: [gemini, kimi, glm51, qwen36]
    F: [claude, gemini, glm51]
    G: [kimi, codex, minimax]
```

**Run sans `audit_scope.yaml` = REJET** (anti-pattern 19).

### Quand activer quel axe

| Contexte | Axes |
|---|---|
| Pré-prod gate | A + C + G |
| Médico-juridique opposable | A + E + F |
| Audit annuel complet | A + B + C + D + E + F + G |
| Refactor archi | B + E + C |
| Performance prod | D + E + C |
| Onboarding | F + B + E |
| Publication scientifique (HELIA) | A + E + F |

---

## Les voix — règle d'or

**4 voix occidentales = panel base IMMUABLE.** Voix chinoises **ajoutées** selon axes, jamais en substitution.

### Panel base (toujours présent)
| Voix | CLI | Force |
|---|---|---|
| Claude Opus 4.7 | Claude Code | Médiation, archi, doc |
| Codex GPT-5.5 | Codex CLI | PoC, tests, sécu |
| Gemini 3.1 Pro | Gemini CLI | Cross-tests, graphe 1M |
| Kimi K2.6 | Kimi CLI | Adversarial, archéologue 2M |

### Voix chinoises (ajoutées par axe)
| Voix | OR Slug | Axes |
|---|---|---|
| GLM 5.1 | zai/glm-5.1 | E, F |
| MiniMax M2.7 | minimax/m2.7 | B, G |
| MiMo V2.5-Pro | xiaomi/mimo-v2.5-pro | D |
| Qwen 3.6 Plus | qwen/qwen3.6-plus | A, E |
| qwen3-coder-plus | qwen/qwen3-coder-plus | C, D |

### Règles dures
- **Panel min 5 voix** : 4 base + 1 chinoise
- **Substitution interdite** (anti-pattern 23)
- **Monoculture interdite** : 0 voix chinoise sur axe activé = REJET (anti-pattern 20)
- **MiniMax appairé GLM 5.1** sur axes B/E (anti-pattern 22)

---

## Pipeline 5 phases gated

### Phase 0 — Inventaire + SAST baseline (zéro coût IA)
- `rg -i 'api[_-]?key|secret|password|token'`
- ruff --select=ALL, mypy --strict, bandit, semgrep, pip-audit, trivy, detect-secrets
- Output : `inventory.json` + `sast_findings.jsonl`

### Phase 1 — audit_scope.yaml + threat model + models par axe
- Threat model bloquant si axe A activé
- Models additionnels par axe (quality_model.yaml, test_model.yaml, …)
- Validation par 1 voix ortho (Codex preferred)

### Phase 2 — Audit aveugle parallèle multi-axes
- **Blind strict** : aucun modèle ne voit la sortie d'un autre
- Output JSON-Lines avec `evidence.command_or_test` obligatoire
- **Interdiction de citer SAST** (SAST Shadowing)
- **Convergence cross-culturelle** :
  - P0 : ≥1 occidental + ≥1 chinois sur même `(file, line, mécanisme)`
  - P1 : ≥2 voix de cultures différentes
  - P2/P3 : ≥2 voix (culture indifférente)

### Phase 3 — Falsification par PoC
- Pour chaque finding ≥ P1
- **Défenseur = culture opposée** au finder
- Mission : "défends que ce N'EST PAS un bug, OU prouve par test pytest"
- ≤2 échanges max

### Phase 4 — Consolidation déterministe + méta-audit Qwen+Codex
- Sortie = matrice JSON déterministe (pas synthèse rédigée)
- Cultural Diversity Score (CDS) par finding
- Convergence valide = ≥2 voix de cultures différentes citant même `(file, line, mécanisme)`

### Phase 5 — Triage humain + correction par défenseur + régression
- Triage humain bloquant P0/P1
- **Correction par défenseur** (≠ finder, anti biais de confirmation)
- Test PoC Phase 3 ajouté à suite tests permanents

---

## Métriques cibles

| Indicateur | Cible |
|---|---|
| Précision | ≥75% |
| Specificity Score | ≥0.8 |
| Vagueness Index | <0.4 |
| Recall vs SAST | ≥20% |
| PoC Rate (P0/P1) | ≥80% |
| Human Triage Tax | <1.0 |
| Reproductibilité | ≥70% |
| **Cultural Diversity Score moyen** | ≥0.5 (P0 doivent avoir CDS=1.0) |

---

## Anti-patterns critiques (23 formalisés, voir doc canonique)

| # | Anti-pattern | Solution |
|---|---|---|
| 11 | Threat-model-less convergence | Phase 1 bloquant |
| 12 | Echo Chamber Claude | Matrice = script déterministe |
| 13 | SAST Shadowing | Interdiction de citer SAST |
| 17 | CLI Mode Write Bypass | sandbox readonly, --plan obligatoire |
| 19 | Mono-axe Bias Non Déclaré | audit_scope.yaml obligatoire |
| 20 | Panel monoculture | 0 voix chinoise sur axe activé = REJET |
| 21 | P0 sans CDS cross-culturel | ≥1 occidental + ≥1 chinois |
| 23 | Substitution occidentale par chinoise | Panel base 4 voix IMMUABLE |

---

## Tests Honeypot (validation anti-corrélation)

Avant de faire confiance à "convergence ≥2 voix" :
1. **Anti-bugs plausibles** : 3 motifs ressemblant à des vulns mais sécurisés
2. **Bugs métier subtils** : 5 vrais bugs invisibles SAST
3. **Perturbation sémantique** : renommer variables sans changer comportement

Diagnostic :
- C_anti <10% & C_real >60% → convergence fiable ✅
- C_anti >25% → pattern-matching, reset prompts

---

## Combinatoires (sous-ensembles)

| Cas | Voix | Coût |
|---|---|---|
| Module isolé <15 fichiers | Codex + Qwen 3.6 + qwen3-coder | ~25% |
| Architecture inter-projets | Gemini + Claude + Codex + GLM 5.1 | ~60% |
| Surface adversariale MCP/LLM | Kimi + Codex + Qwen 3.6 + MiniMax | ~50% |
| Audit infra | Kimi + Claude + MiniMax | ~35% |
| PR review <200 lignes | Solo Qwen 3.6 | ~10% |
| Audit efficience patterns | MiniMax + qwen3-coder + MiMo | ~$0.05 |
| Audit annuel complet 7 axes | Panel complet 7-8 voix | 100% |

---

## Mémoire collective

Après chaque run, alimenter `lessons_polylens_audits.md` :
- Patterns gagnants (quel modèle a trouvé quel type de bug)
- Faux positifs récurrents (par modèle, par surface)
- Métriques observées vs cibles
- Résultats Honeypot

---

## Référence canonique

- **Méthodologie complète** : `~/.claude/projects/-Users-radu/memory/feedback_polylens_method.md`
- **Master spec doc** : `~/Developer/projects/POLYLENS.md`
- **Lessons cumulées** : `~/.claude/projects/-Users-radu/memory/lessons_polylens_audits.md`
- **Run #1 rapport** : `~/Developer/projects/POLYLENS_RUN_2026-05-03_RAPPORT.md`
- **Run CHINA** : `~/Developer/projects/_audit_polylens_china_20260503/`

---

## Synergie avec autres skills

- **Amont** : `/expertise` (cadrage SST), `/oriente` (décomposition)
- **Aval** : `/document` (formalisation), `/jury` (challenge externe RedAPI)
- **Pas synergie** : `/avis` (idéation), `/brainstorming` (créatif)

---

## Référence rapide

POLYLENS = 7 axes (A-G) + 4 occidentales base + 5 chinoises ajoutées + 5 phases gated + convergence cross-culturelle obligatoire + PoC obligatoire P0/P1 + matrice déterministe + méta-audit Qwen+Codex.

**P0 requiert** ≥1 voix occidentale + ≥1 voix chinoise sur même `(file, line, mécanisme_causal)`.
