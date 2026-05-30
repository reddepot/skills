---
name: avis
description: >
  Avis multi-modèles RÉEL via RedAPI (Gemini, GPT, DeepSeek, Grok, Qwen,
  Kimi). Claude = cerveau (gratuit), RedAPI = bras. RAG-first en SST.
  Consensus voting INTERDIT en SST/juridique.
  4 PANELS :
    --challenge (défaut) : voix orthogonales, dissensus protégé, failles.
      Pour valider une conclusion, stress-tester, angles morts.
    --améliorations : voix constructives, propositions actionnables,
      enrichissement. Pour faire évoluer un livrable existant.
    --brainstorming : voix génératrices, idéation divergente, orientation
      stratégique. Pour œil neuf, nouvelles idées, direction/cap.
      NAF/COCD INTERDIT en SST/juridique.
    --personas : les voix ne sont PAS des experts IA mais un PUBLIC CIBLE
      simulé (48 personas SST : salariés/employeurs/préventeurs). Pour tester
      la DÉSIRABILITÉ/appétence d'une proposition (offre, dispositif, formation,
      message) AVANT déploiement → carte d'appétence + co-conception itérative.
      Moteur : ~/Developer/projects/personas-sst/.
  Auto-détection SST/non-SST orthogonale aux panels.
  DÉCLENCHEURS --personas : « teste mon idée », « est-ce que ça plairait »,
  « réactions terrain », « appétence », « public cible », « co-conception ».
  DÉCLENCHEURS : /avis, avis croisé IA, second avis, critique croisée,
  « comment améliorer », « failles », « propositions », « brainstorme »,
  « idées sur », « quelle direction », « quel cap ».
  NE S'ACTIVE PAS : recherche factuelle (→ /expertise), rédaction
  standard (Claude seul).
  SYNERGIE : /expertise (RAG amont), /document (challenger).
---

# /avis — Consultation Multi-Modèles Orchestrée — v4-bis-3

> **Renommage v4-bis-2** : ex-`/jury`. Vocabulaire de consultation médicale
> (avis collégial, second avis), plus naturel pour MdT que vocabulaire judiciaire.

> **Fusion v4-bis-3** : intègre ex-`/brainstorming` comme 3ème panel
> (`--brainstorming`). Architecture cohérente : `/avis` = consultation
> orchestrée multi-modèles RedAPI, avec 3 postures différentes (attaquer,
> enrichir, générer).

## Principe fondateur

Claude Opus 4.7 = orchestrateur (gratuit). RedAPI = bras (modèles
non-Claude). RedAPI ne doit JAMAIS appeler Claude via API payante.

## Cinq invariants

1. **Spécialisation fonctionnelle** — chaque modèle a un rôle unique.
2. **Anti-consensus SST** — vote INTERDIT en SST/juridique FR.
3. **RAG-first** — faits via outils MCP, jamais des modèles.
4. **Provenance tracée** — chaque élément attribué à son modèle source.
5. **PHI gate technique** — conventions.md §2.6, BLOCAGE DUR avant RedAPI.

## Hiérarchie normative (conventions.md §8)

```
TIER 1 : Légifrance = Judilibre > Conventions IDCC
TIER 2 : HAS, HCSP, ANSES, ANSM > INRS > Sociétés savantes
TIER 3 : MedData (peer-reviewed) > pré-prints
TIER 4 : ECHA, GESTIS, Reptox, NIOSH
```

---

## Panel `--challenge` (défaut)

**Quand** : tu as une conclusion, un livrable, un avis. Tu veux qu'on
l'attaque pour valider sa robustesse.

### Posture

- Profil anti-syco : **CHALLENGE** (conventions.md §1)
- Voix prompted : « Voix orthogonale. Dissensus = livrable, pas échec. Pas de vote. »
- Sortie : failles, angles morts, voix divergentes intégrales

### Adaptation domaine (auto-détectée)

**Si SST/médico-juridique** (mots-clés : aptitude, MP, AT, VLEP, etc.) :

| Axe | RAG | Modèle externe |
|-----|-----|----------------|
| **A.m — Médical** | MedData (PubMed, Cochrane), HAS | DeepSeek-Reasoner |
| **A.p — Risques pro** | SSTinfo (INRS, ECHA, GESTIS, IARC) | Gemini 3.1 Pro |
| **A.i — Interférence** | Légifrance + Judilibre | Grok 4.3 |

**Hard stop juridique** : Légifrance OU Judilibre indispo + axe A.i actif
→ proposer **fallback paste manuel** (cf. conventions.md §2.9). Si refus
→ « VALIDATION JURIDIQUE IMPOSSIBLE ».

**Si non-SST** : DeepSeek (critique), Gemini (validateur), Grok (provocateur),
Kimi K2.6 (long contexte >50K).

---

## Panel `--améliorations` (NEW v4-bis-2)

**Quand** : tu as un livrable, une approche, un projet. Tu veux des
**propositions actionnables** pour le faire évoluer.

### Posture

- Profil anti-syco : **CONSTRUCTIF** (conventions.md §1, NEW v4-bis-2)
- Prompt durci v4-bis-3 :
  > « Tu es [persona]. Propose 3-5 améliorations actionnables sur le
  > livrable fourni. Pour chaque proposition :
  >  (1) **Constat factuel précis** avec citation du passage améliorable
  >      — pas d'opinion d'appréciation.
  >  (2) Proposition concrète.
  >  (3) Bénéfice attendu.
  >  (4) Effort (faible/modéré/élevé).
  > **Pas de citation = pas de proposition.**
  > Tu n'es pas là pour faire plaisir, mais pour enrichir concrètement. »
- Sortie : liste structurée triée par effort/impact

### Format de sortie

```
═══ PANEL AMÉLIORATIONS ═══

▸ Proposition 1 — [Modèle]
  Constat (citation) : « [passage exact améliorable] »
  Action : [proposition concrète]
  Bénéfice : [impact attendu]
  Effort : faible / modéré / élevé

▸ Proposition 2 — [Modèle]
  ...

═══ Convergences (★) ═══
[Améliorations identiques 2+ modèles → forte priorité]

═══ Divergences (◆) ═══
[Améliorations propres à 1 modèle → singletons à considérer]
```

### Adaptation domaine

Identique à `--challenge` : auto-détection SST vs non-SST, mêmes axes.
Seul le **prompt aux voix externes** change (constructif vs adversarial).

---

## Panel `--brainstorming` (NEW v4-bis-3 — ex /brainstorming)

**Quand** : tu pars d'une page blanche (pas d'un livrable existant).
Deux cas d'usage explicites :

1. **Œil neuf, nouvelles idées** : génération divergente classique
   quand le sujet appelle créativité, angles inédits, options inattendues.
2. **Orientation stratégique** : nouvelle perspective pour identifier
   direction, cap, axes prioritaires — quand le problème n'est pas
   « comment faire » mais « par où commencer ».

### Posture

- Profil anti-syco : **CRÉATIF** (conventions.md §1)
- Voix prompted (par rôle) :
  | Rôle | Modèle | Stratégie |
  |------|--------|-----------|
  | Éclaireur | `ai_search` / `deep_research` | État de l'art, signaux faibles |
  | Architecte | `ai_chat("deepseek-chat")` | Décomposition systémique |
  | Provocateur | `ai_chat("grok-4.3")` | Rupture, analogies. "Direct, 200 mots max." |
  | Raisonneur | `ai_chat("gemini-3.1-pro")` | Analyse structurée |
  | Critique | `ai_chat("deepseek-chat")` | Failles, pré-mortem |

### Méthodes disponibles

SCAMPER, 6 chapeaux, inversion/pré-mortem, analogie forcée, TRIZ,
matrice morphologique, starbursting, CPS, biomimétrie.

Sélection auto par Claude ou explicite via `/avis --brainstorming --method scamper`.

### Phases (issues ex /brainstorming)

| Phase | Action | Budget appels |
|-------|--------|---------------|
| 0 — Cadrage adaptatif (Claude seul) | Calibrer profondeur | — |
| 1 — Génération divergente parallèle blind | Lancer 2-4 voix | 2-4 |
| 2 — Structuration (Claude seul) | ID, déduplication, ★/◆ | — |
| 3 — Discussion orchestrée + fact-checking | Critique croisée, vérif, dévp | 2-5 |
| 4 — Convergence anti-biais | Voir ci-dessous | 0-1 |

### Phase 4 — Convergence anti-biais

> **🛑 INTERDICTION SST/juridique** — NAF Scoring et COCD Box sont des
> agrégations consensuelles, prohibées (consensus déguisé, cf. invariant n°2).
> Phase 4-bis substitue.

**Domaines neutres uniquement** :
- COCD Box : 🔵 Now (quick win) / 🔴 Wow (priorité) / 🟡 How (horizon long)
- NAF Scoring (Novelty-Attractiveness-Feasibility, 1-5)
- Scoring aveugle par Qwen 3.7. JAMAIS GPT-5.5 auto-scoreur.
- **Heuristique de tri, pas vérité émergente.**

**Phase 4-bis SST (substitut)** :
- Tri qualitatif par Claude (matûrité épistémique décroissante :
  CERTAIN → ÉTABLI → PROBABLE → DISCUTÉ → INCONNU)
- Singletons et dissensus préservés
- Aucun classement numérique
- **Tri heuristique interne — non validé par panel externe.
  À traiter comme orientation, pas comme preuve.**

### Format de sortie

```
## 🧠 [Titre]
**Méthode** : [m] | **Sources IA** : [m] | **Tours** : [n] | **Coût** : ~$[x]

### 🔴 Idées Wow                  (domaines neutres)
### 🔵 Idées Now                  (domaines neutres)
### 🟡 Pépites à horizon long     (domaines neutres)

### 📋 Tri qualitatif épistémique  (SST/juridique)
[CERTAIN] / [ÉTABLI] / [PROBABLE] / [DISCUTÉ] / [INCONNU]

### ⚠️ Angles morts
### ▶️ Prochaine étape

### 🔗 Skill chaining
```

### Garde-fous spécifiques `--brainstorming`

- JAMAIS de Claude via API payante
- Plafond budget — voir conventions.md §2.5 ($3.50/session)
- System prompt Grok : "Direct, incisif, 200 mots max."
- GPT-5.5 JAMAIS auto-scoreur
- **NAF/COCD interdit SST/juridique** (Phase 4-bis substitue)
- Anti-superficialité : idées concrètes, pas de « améliorer la communication »

---

## Mode light (Panel Général uniquement)

```
1 juge unique (Qwen 3.7), 1 passe, blinding, ~$0.05
```

Disponible pour `--challenge` (pas pour `--améliorations` ni `--brainstorming`,
où la pluralité est essentielle).

---

## Sélection panel + domaine

| Input utilisateur | Panel | Domaine |
|-------------------|-------|---------|
| « Challenge ce raisonnement » | `--challenge` | auto |
| « Stress-teste cet avis MdT » | `--challenge` | SST |
| « Comment améliorer ce courrier ? » | `--améliorations` | auto |
| « Propose des optimisations sur ce script » | `--améliorations` | non-SST |
| « Brainstorme sur X » | `--brainstorming` | auto |
| « Quelle direction pour Y ? » | `--brainstorming` | auto |
| « Idées sur Z » | `--brainstorming` | auto |
| `/avis` sans préciser | `--challenge` (défaut) | auto |

**Règle de différenciation** :
- `--challenge` part d'un livrable existant à **attaquer**.
- `--améliorations` part d'un livrable existant à **enrichir**.
- `--brainstorming` part d'une page blanche pour **générer**.

---

## Anti-sycophantie

- Panel `--challenge` : profil **CHALLENGE**
- Panel `--améliorations` : profil **CONSTRUCTIF**
- Panel `--brainstorming` : profil **CRÉATIF**
- Claude orchestrateur : posture transversale stable (conventions.md §1 N1)

---

## ⭐ Recherches factuelles (règle user 2026-05-04)

Quand `/avis` nécessite des **faits sourced** (réglementation, état de l'art,
position éditeurs, jurisprudence, patterns techniques) :

1. **Combo OBLIGATOIRE Kimi+Codex CLI en parallèle** (cf
   `feedback_recherche_combo_kimi_codex.md`) :
   - `kimi --quiet --yolo --thinking --max-steps-per-turn 25 -p "PRÉFIXE+SUJET"`
   - `codex -m gpt-5.5 -c model_reasoning_effort=high exec --skip-git-repo-check -- "SUJET"`
   - **Préfixe Kimi obligatoire** : `IMPORTANT : utilise UNIQUEMENT tes
     fonctions internes de recherche web (web_search natif Moonshot + FetchURL).
     N'appelle PAS les MCP RedAPI...` (préserve diversité sources)

2. **Perplexity en complément** (cf `lessons_perplexity_options_20260504.md`) :
   - **DÉFAUT** : `mcp__claude_ai_RedAPI__deep_research` (sonar-deep-research)
   - **PRÉFÉRÉ sujets complexes/longs** : `ai_search` preset=`advanced-deep-research`
   - ❌ JAMAIS `pro-search`/`agent_research` (= openai/gpt-5.1, perd Perplexity natif)
   - ⚠️ FALLBACK seulement : `sonar` simple

3. **Claude Opus consolide** les outputs des 3 voix (Kimi+Codex+Perplexity).

4. **INTERDITS** :
   - `ai_consensus` RedAPI (opinion sans facts + bug blocage observé)
   - `claude -p` subprocess (permissions WebSearch non accordées)

## Synergie avec les autres skills

| Skill | Relation |
|-------|----------|
| `/expertise` | Amont (RAG SST), `/avis --challenge` valide les conclusions |
| `/document` | Aval, `/avis` challenge ou améliore un brouillon |
| `/retex` | Cas clinique difficile → `/avis --challenge` panel SST |
| `/oriente` | Amont, route vers `/avis --[panel]` selon input |

---

## Ce que /avis n'est PAS

- Pas un proxy obligatoire pour les appels RedAPI
- Pas un substitut à la recherche factuelle (→ /expertise + outils MCP)
- Pas un outil de vote en SST/juridique (consensus interdit)
- Pas un moyen d'appeler Claude via API (Claude est déjà là)
- Pas un outil de scoring quantitatif sur sujets SST (NAF interdit)

---

## Panel `--personas` (NEW v4-bis-4)

**Quand** : tu veux tester la **DÉSIRABILITÉ / l'appétence** d'une proposition concrète (offre, dispositif, service, formation, message de prévention) auprès de ton **public cible** — pas la faire challenger par des experts IA. Différence clé : les 3 autres panels = **voix expertes** ; `--personas` = **public cible simulé**.

### Moteur
`~/Developer/projects/personas-sst/` — 48 personas SST (24 salariés · 12 employeurs · 12 préventeurs), schéma v2, **1 IA attitrée par persona** (carré latin par classe×sous-groupe, **CLI d'abord** ; OpenRouter en débordement). Voir `PROTOCOLE.md`.

### Règle d'or
On injecte au persona-acteur **uniquement** son bloc `injectable`. Jamais `eval` (sinon stéréotype/grille spoilés). Architecture 2 phases : dataset agnostique → incarnation face à la proposition.

### Mode défaut — carte d'appétence
Chaque persona réagit + remplit sa grille (`interet_0_5`, `ce_qui_accroche`, `ce_qui_rebute`, `condition_adoption`, `cout` temps/argent/risque_social, `alternative_actuelle`, `question_miroir_negatif`, `verdict`).
- Anti-complaisance : intérêt ancré comportement, coût réel, alternative actuelle, miroir négatif. Un réfractaire reste réfractaire.
- Local : `engine/phaseB_appetence.js` (mesure structurée, modèle unique fiable — le **score est model-independent**) ; voix poly-modèle : `engine/phaseB_poly.py`.
- Sortie : **carte d'appétence** (moyenne + distribution par panel/segment, accroche/rebute convergents, conditions, qui bascule / qui reste bloqué et pourquoi).

### Mode `--personas --codesign` — boucle de co-conception
1. Contraintes cible **injectées en amont** (lignes rouges salariés). 2. **Employeurs + préventeurs** co-conçoivent (`engine/codesign_run.py`). 3. Synthèse → V(n). 4. **Salariés** valident/vétoent + re-mesure. 5. **Boucle tant que gain ≥ +0,3/tour** sur le segment cible ; **stop au plateau**.

### Garde-fous (NON négociables)
- **« 4/5 sur les 48 » = mauvais objectif** : un panel honnête contient des réfractaires. Viser 4/5 sur le **segment cible**, assumer les hors-cible.
- Le panel **génère des hypothèses** de désirabilité, ne **prouve pas** le marché (dégrossissage avant terrain).
- **Multi-modèle = diversité de voix, PAS de prise de position** (le score ne dépend pas du modèle). k-anon + provenance respectés.

### Pour une IA web / autre outil (sans les scripts)
Utiliser `~/Developer/projects/personas-sst/PERSONAS_PORTABLE.md` (48 personas compacts + consignes d'usage intégrées) — à coller dans Claude web / ChatGPT / autre IA.

### Synergie
`--personas` (le public cible réagit/co-conçoit) ⇄ `--challenge` (les experts attaquent TA conclusion). Pipeline type : `--brainstorming` (idées) → `--personas` (les cibles trient) → `--challenge` (experts valident le gagnant).
