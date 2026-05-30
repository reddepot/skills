---
name: decision
description: >
  Aide à la prise de décision structurée pour choix non-triviaux
  (techniques, méthodologiques, stratégiques). Encapsule la méthode
  DEVCODE-Vote v1 issue de la consultation multi-LLM 2026-05-04
  (Schulze pondéré bayésien Glicko-2 + anti-collusion familiale +
  preuves exécutables + arbitre).
  Auto-graduation P0/P1/P2/P3 selon enjeux : trivial → décision Claude
  directe ; standard → 2-3 voix ; important → Pool A complet ; P0
  critique → Pool A + Pool B cross-cultural.
  DÉCLENCHEUR EXPLICITE : /decision. IMPLICITES : « comment décider
  entre », « quelle approche choisir », « X vs Y vs Z », « quel
  choix faire », « stratégie », « cap à prendre », « trancher »,
  « arbitrer », décision méthodologique avec ≥2 options non-triviales,
  choix avec coût d'erreur >30min ou impact ≥1 jour de travail.
  NE S'ACTIVE PAS : choix trivial à conséquences faibles, exécution
  d'une décision déjà prise, questions factuelles, recherche
  documentaire (→ /expertise). BYPASS si user a déjà tranché.
  SYNERGIE : /avis (brainstorming amont si options floues),
  /expertise (RAG documentaire amont), /polylens (audit P0 aval),
  /document (formalisation ADR aval).
  Référence canonique : ~/Developer/projects/devcode/docs/DEVCODE_METHODOLOGY.md.
---

# /decision — Aide à la décision multi-LLM structurée — v1

## Acronyme

**DECISION** = Délibération Encadrée Cross-culturelle Indépendante Schulze Itérative Opposable Notable.

## Mantra

> Pas de décision sans options claires, critères explicites, voix indépendantes. La méthode prime sur l'intuition. La trace prime sur la mémoire.

---

## 1. Quand /decision se déclenche-t-il ?

### Auto-détection (signaux explicites)

L'agent détecte une **situation décisionnelle** quand l'input combine :
- ≥2 options/alternatives présentées
- Tradeoffs visibles (coût, qualité, vitesse, risque)
- Choix engageant (pas révocable en 30 secondes)
- Verbes/expressions : « décider », « choisir », « trancher », « arbitrer », « comment faire entre », « stratégie », « cap »

### Auto-détection (signaux implicites — engagement)

- Question ≥ 80 mots décrivant un choix sans le poser frontalement
- Postulat contestable suggérant que le user est entre deux mondes
- Mention d'enjeux non-triviaux (perte de temps, dette technique, blast radius)

### Bypass (NE S'ACTIVE PAS)

- Choix trivial : « bleu ou vert pour le bouton ? » → réponse directe
- Décision déjà prise : « j'ai choisi X, implémente-le » → exécution
- Question factuelle : « X est-il deprecated ? » → recherche
- Recherche documentaire pure → `/expertise`
- Brainstorming d'idées floues sans options arrêtées → `/avis --brainstorming` d'abord

---

## 2. Pipeline de la décision (5 phases)

### Phase 0 — Cadrage (qualification du problème)

L'agent vérifie qu'il a **les 5 informations canoniques** pour décider sainement :

| # | Info | Si absente, l'agent demande |
|---|------|------------------------------|
| 1 | **Options claires** (≥2 alternatives nommées) | « Quelles options as-tu déjà identifiées ? Si tu n'as qu'une option, c'est de l'exécution, pas de la décision. » |
| 2 | **Critères de succès** (qu'est-ce qu'une bonne décision ?) | « À quoi reconnaîtras-tu que tu as bien décidé dans 6 mois ? » |
| 3 | **Contraintes** (coût, temps, réversibilité, dépendances) | « Quelles contraintes dures ? (budget, deadline, irréversibilité, dépendances tierces) » |
| 4 | **Stakeholders / impact** (qui/quoi est affecté) | « Qui ou quoi est impacté par cette décision ? Combien de personnes/systèmes ? » |
| 5 | **Réversibilité** (peut-on revenir en arrière, à quel coût ?) | « Peut-on revenir en arrière facilement, à coût modéré, ou jamais ? » |

**Règle** : si ≥2 infos manquent, l'agent **pose les questions ciblées en une seule passe** avant de continuer. Pas de boucle multi-tours d'interrogatoire.

### Phase 1 — Graduation P0/P1/P2/P3

L'agent classe la décision par enjeu. Les modalités diffèrent en coût et profondeur.

| Niveau | Critères | Modalité | Coût indicatif | Voix mobilisées |
|--------|----------|----------|-----------------|-----------------|
| **P3 — Trivial** | Coût erreur <30min, totalement réversible, impact ≤1 dev | Claude direct | 0 (forfait) | Claude seul |
| **P2 — Standard** | Coût erreur 30min-2h, réversible, impact équipe | Mini-vote 2-3 voix | ~$0 (CLI) | Claude + Codex CLI ou /avis --challenge |
| **P1 — Important** | Coût erreur >2h, semi-réversible, impact projet | DEVCODE-Vote v1 Pool A | ~$0-0.10 | Claude + Codex CLI + Gemini OR + Kimi CLI + Qwen Max OR |
| **P0 — Critique** | Irréversible OU impact ≥1 jour OU sécurité/data/médical | DEVCODE-Vote v1 Pool A + Pool B cross-cultural | ~$0.30-1.00 | 10 voix complètes |

### Phase 2 — Élaboration des options (si nécessaire)

Si le user a fourni les options frontalement, on passe direct à Phase 3.

Si user en a 1 ou 2 mais semble bloqué, **délégation amont** :
- → `/avis --brainstorming` pour générer 3-5 options orthogonales
- → `/expertise` pour cadrage documentaire en SST/médical

### Phase 3 — Vote (DEVCODE-Vote v1)

#### A. Soumission indépendante (vote aveugle)

Chaque voix mobilisée reçoit la spec complète et produit :
```json
{
  "voice": "<modèle>",
  "ranked_options": [<option_id>, ...],  // classement 1=préféré
  "top_1_justification": "<3-5 lignes>",
  "evidence": ["<test|citation|repro>"],
  "confidence": 0.0-1.0,
  "risks_top_choice": ["<risque 1>", ...]
}
```

#### B. Agrégation Schulze pondéré bayésien

```
Poids w_i = Glicko2_rating(modèle, domaine_decision)
            × (1 - corrélation_familiale_pénalité)

Pénalité familiale :
  pour chaque paire (a, b) avec same_family(a, b) :
    sim = cosine(embed(output_a), embed(output_b))
    if sim > 0.85: appliquer pénalité_familiale(sim)

Agrégation : Schulze pondéré sur les classements
Cycle ? → Schulze fallback déterministe
```

#### C. Validation supermajorité

Si top-1 a ≥4/5 voix (P1) ou ≥7/10 (P0) **ET** ≥1 voix non-occidentale dans la majorité (anti-monoculture POLYLENS v3) → adopté.

#### D. Si split — Evidence pack durci

Voix dissidentes doivent fournir contre-preuves exécutables. Voix majoritaires doivent fournir preuves exécutables. Re-vote sur evidence pack.

#### E. Tie-breaking final (déterministe)

```
1. Tests verts / preuve exécutable la plus forte
2. Patch minimal / réversibilité maximale
3. Score de risque (CVE, blast radius, données sensibles)
4. Réputation locale (Glicko-2 historique sur ce domaine)
5. Arbitre Claude : raisonnement signé publié dans ADR
```

### Phase 4 — Trace ADR (5 champs minimum)

Chaque décision /decision produit un fichier markdown daté :

```markdown
# ADR-DECISION-<UUID>

**Date** : <ISO 8601>
**Niveau** : P0/P1/P2/P3
**Contexte** : <résumé spec>
**Options** : [...]
**Voix mobilisées** : [(model, role, vote, confidence, evidence)]
**Méthode d'agrégation** : DEVCODE-Vote v1 / Schulze pondéré bayésien Glicko-2
**Pénalités anti-collusion** : [...]
**Décision finale** : <option choisie>
**Arbitre si split** : <Claude / null>
**Evidence pack** : tests / repro / citations
**Critères de succès dans 6 mois** : [...]
**Réversibilité** : [...]
```

Stockage : `~/Developer/projects/<project>/docs/ADR/<date>_<topic>.md` ou `~/.claude/projects/-Users-radu/memory/decision_<topic>.md`.

---

## 3. Voix mobilisées par niveau (matrice canonique)

### P3 — Claude seul

Réponse directe + raisonnement bref (3-5 lignes max).

### P2 — 2-3 voix occidentales

- **Claude Opus 4.7** (orchestrateur + voix)
- **Codex GPT-5.5** via CLI (`codex exec -m gpt-5.5 -c model_reasoning_effort=high`)
- (optionnel) **Gemini 3.1 Pro** via CLI ou OpenRouter fallback

### P1 — Pool A complet (5 voix)

Pool A : Claude + Codex (CLI) + Gemini 3.1 Pro (CLI ou OR fallback) + Kimi K2.6 (CLI) + Qwen 3.6 Max (OR via `ai_chat` ou curl direct).

### P0 — Pool A + Pool B cross-cultural (10 voix)

Pool A (5) + Pool B (5 voix chinoises) :
- GLM 5.1 (`z-ai/glm-5.1`)
- MiniMax M2.7 (`minimax/minimax-m2.7`)
- MiMo V2.5-Pro (`xiaomi/mimo-v2.5-pro`)
- Qwen 3.6 Plus (`qwen/qwen3.6-plus`)
- Qwen 3 Coder Plus (`qwen/qwen3-coder-plus`)

Convergence cross-culturelle obligatoire : ≥1 voix non-occidentale dans la majorité finale.

---

## 4. Cascade fallback (règle durable)

Quand une voix CLI tombe (quota, panne) :
1. RedAPI MCP `ai_chat` avec même modèle (route OpenRouter)
2. Si RedAPI MCP offline (502) : `curl` direct OpenRouter avec `OPENROUTER_API_KEY` lue depuis `~/Developer/projects/mcp_redapi/.env`

Cette cascade est documentée dans `feedback_gemini_quota_fallback.md` (memory).

---

## 5. Anti-patterns à éviter

| Anti-pattern | Pourquoi c'est mauvais | Mitigation |
|--------------|------------------------|------------|
| **Décider sans options** | « Que faire ? » sans alternatives = exécution déguisée | Phase 0.1 : forcer ≥2 options |
| **Sur-grader la décision** | Mobiliser Pool B pour un choix de couleur de bouton = waste | Phase 1 : graduation honnête |
| **Sous-grader la décision** | Décider seul sur archi base de données = risque dette | Phase 1 : critères P1/P0 stricts |
| **Vote suiviste (effet Asch)** | 4 voix copient la 1ʳᵉ par contagion | Phase 3.A : vote aveugle indépendant |
| **Faux consensus famille** | 3 voix Anthropic ne comptent que comme 1 | Phase 3.B : pénalité corrélation cosine |
| **Décision sans trace** | « Pourquoi a-t-on choisi X ? » 6 mois plus tard | Phase 4 : ADR obligatoire P1+ |
| **Arbitre Claude non-neutre** | Claude orchestrateur favorise inconsciemment Anthropic | Phase 3.E : arbitrage signé + audit POLYLENS suivant |
| **Boucle d'interrogatoire** | 4 questions clarification successives | Phase 0 : grouper en 1 passe |

---

## 6. Exemple d'utilisation

### Cas P0 — choisir entre 3 architectures pour un nouveau service

```
User : /decision je dois choisir entre microservices Kafka, monolithe modulaire, ou serverless pour notre nouveau service de matching médical. C'est critique, 100k utilisateurs prévus, données PII.

Agent (/decision) :
[Phase 0 — Cadrage]
- 3 options ✅
- Critères de succès → demande user : « définis ton seuil de latence acceptable et ta tolérance ops ? »
- Contraintes : 100k users + PII (sécurité forte) ✅
- Stakeholders : médical, donc utilisateurs sensibles + obligation RGPD ✅
- Réversibilité : monolithe → micro = couteux, serverless → autre = très couteux

[Phase 1 — Graduation]
P0 : irréversibilité moyenne, impact ≥jour, données médicales sensibles, scaling 100k
→ Mobilisation Pool A + Pool B (10 voix)

[Phase 2 — Options claires]
Pas de brainstorming nécessaire (3 options nettes).

[Phase 3 — Vote DEVCODE-Vote v1]
... (parallèle 10 voix, Schulze pondéré, evidence pack, supermajorité)

[Phase 4 — ADR généré]
~/Developer/projects/<projet>/docs/ADR/2026-05-04_archi_matching_medical.md
```

### Cas P2 — choisir entre 2 librairies HTTP

```
User : Bah je sais pas si je prends httpx ou requests pour ce script Python.

Agent (/decision) :
[Phase 0]
- 2 options ✅
- Contraintes : script Python (pas critique implicitement)
- Réversibilité : haute (find/replace)
[Phase 1]
P2 : coût erreur <2h, totalement réversible
→ Mini-vote 2 voix (Claude + Codex CLI)
[Phase 3]
Codex tranche : « httpx pour async natif, requests si sync simple. Tâche est ___ ? »
[Phase 4]
Pas d'ADR, juste recommandation directe.
```

---

## 7. Matrice d'invocation rapide

| Tu hésites entre... | Niveau probable | Voix probables |
|--------------------|------------------|-----------------|
| 2 libs équivalentes pour une fonction | P3-P2 | Claude ou Claude+Codex |
| 2 architectures monolithe vs micro | P1-P0 | Pool A ou Pool A+B |
| 3 stratégies de déploiement | P1 | Pool A |
| 2 méthodologies de tests | P2-P1 | 3 voix occidentales |
| 1 choix RGPD/médical/légal | **P0 obligatoire** | Pool A+B cross-cultural |
| 1 choix de naming | P3 | Claude direct |

---

## 8. Synergies avec autres skills

- **/avis --brainstorming** : si tu as 1 seule option, /decision te renvoie d'abord vers /avis pour générer 3-5 alternatives.
- **/expertise** : si décision SST/médicale et tu manques de RAG, /decision te renvoie vers /expertise en amont.
- **/polylens** : pour les décisions P0 médico-juridiques, /polylens auditera ensuite l'implémentation. /decision passe le ADR à /polylens comme input.
- **/document** : si la décision doit produire un livrable formel (avis, rapport, courrier), /document s'enchaîne avec l'ADR comme spec.
- **/oriente** : si /decision est invoqué sur une demande encore floue, il peut renvoyer la balle à /oriente pour structurer.

---

## 9. Auto-amélioration

Après chaque invocation, mettre à jour `~/Developer/projects/devcode/data/decision_history.jsonl` (1 ligne par décision) avec :
- `decision_id`, `niveau`, `voix_mobilisées`, `méthode`, `final`, `outcome` (à mettre à jour 30j-6mois plus tard si possible)

Cet historique alimente :
- Réputation Glicko-2 par voix×domaine
- Calibration des seuils de graduation
- Détection de drift modèles (Phase 2 DEVCODE)

---

## 10. Implémentation pratique — CLI `devcode-decide` (Phase 2.0+)

### Installation

```bash
cd ~/Developer/projects/devcode
python3 -m venv .venv && source .venv/bin/activate
pip install -e ".[dev]"
# Entry-point disponible : devcode-decide
```

### Format de spec YAML

```yaml
decision_id: my-decision-001
domain: archi               # ex: archi, secu, code, data
task_type: bugfix           # ex: bugfix, feature, refactor, migration
priority: P1                # P0 | P1 | P2 | P3
options: [0, 1, 2]
seed: 42
votes:
  - voice_id: claude
    family: anthropic
    ranked_options: [0, 1, 2]   # 0=préféré
    confidences: {0: 0.9, 1: 0.5, 2: 0.1}
  - voice_id: codex
    family: openai
    ranked_options: [0, 2, 1]
    confidences: {0: 0.85, 1: 0.3, 2: 0.6}
  - voice_id: kimi
    family: moonshot
    ranked_options: [1, 0, 2]
    confidences: {1: 0.85, 0: 0.6, 2: 0.2}
  # ... ≥1 voix non-occidentale obligatoire pour P0/P1/P2
```

### Invocation

```bash
# Décision simple, output JSON sur stdout
devcode-decide --spec spec.yaml

# Avec persistance + ADR run JSON
devcode-decide --spec spec.yaml --persist --adr docs/adr/runs/

# Pipeline (lecture stdin)
cat spec.json | devcode-decide --spec - --quiet | jq .winner
```

### Pipeline /decision typique

1. **Phase 0 (Cadrage)** : agent (Claude) clarifie options + critères avec user
2. **Phase 1 (Graduation)** : auto-détection P0/P1/P2/P3 selon §2 et §7
3. **Phase 2 (Génération votes)** :
   - P3 : Claude seul → réponse directe (skip CLI)
   - P2-P1-P0 : agent collecte les votes via CLI/curl en parallèle background
4. **Phase 3 (Agrégation)** : agent appelle `devcode-decide --spec <spec>.yaml --persist --adr docs/adr/runs/`
5. **Phase 4 (Lecture résultat)** : agent lit le JSON, traduit en français pour user, propose suite (commit, /document, /polylens)

### Persistance Glicko-2 longitudinale (Sprint 2.1+)

Pour activer SQLiteReputationStore (au lieu de InMemoryReputationStore par défaut), passer un store au CLI :

```python
# Phase 2.4+ : exposer --reputation-store sqlite://path.db
# Pour l'instant, les ratings restent in-memory pour chaque run CLI
```

Phase 2.4 ajoutera l'option CLI `--reputation-store sqlite:///path/to/rep.db` pour brancher la persistance.

---

## 11. Statut & versions

- **v1** (2026-05-04) : version initiale, issue de DEVCODE Step 6.
- **v1.1** (2026-05-05) : intégration CLI `devcode-decide` (Phase 2.0), SQLiteReputationStore (2.1), self-application gate via `scripts/recursive_phaseN_decision.py` (ADR-003 récursion).
- Roadmap v1.2 : exposer `--reputation-store` au CLI + Glicko-2 réel (Phase 3, après calibration empirique 2.4).
- Roadmap v2 : routeur ML appris sur historique (cf §10 spec DEVCODE).

---

**Référence canonique** : `~/Developer/projects/devcode/docs/DEVCODE_METHODOLOGY.md` (méthodologie DEVCODE complète).
**Référence implémentation** : `~/Developer/projects/devcode/src/devcode/cli.py` + `tests/test_cli.py`.
