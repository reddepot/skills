---
name: brainstorming
description: >
  Brainstorming itératif orchestré multi-IA via RedAPI. Génération
  parallèle blind (Perplexity, DeepSeek, Gemini, Grok) avec rôles distincts,
  boucle de discussion avec fact-checking dynamique intra-boucle,
  convergence structurée anti-biais (COCD Box + NAF scoring).
  Sélection auto de méthode (SCAMPER, 6 chapeaux, inversion, analogie,
  TRIZ, matrice morphologique, pré-mortem, starbursting, CPS, biomimétrie)
  ou spécification manuelle. Tous domaines.
  DÉCLENCHEUR : /brainstorming (toujours activer sans exception).
  IMPLICITES : « brainstorme », « idées sur », « trouvons des solutions »,
  « comment pourrait-on », « explore des pistes », « génère des options »,
  « innovation sur », « diverger sur », toute demande d'idéation créative.
  NE S'ACTIVE PAS : questions factuelles, recherches documentaires,
  production de documents, analyse critique (→ /agent), retex (→ /retex).
  SYNERGIE : /sens en amont, /agent en aval, /document pour formaliser.
---

# /brainstorming — Idéation Itérative Orchestrée Multi-IA — v4.1 (Architecture V3)

## Principe V3 : CLAUDE = CERVEAU, RedAPI = BRAS

Claude Opus 4.6 (via Claude Max, abonnement payant illimité)
orchestre tout : cadrage, structuration, convergence, rédaction.
RedAPI fournit les modèles NON-Claude pour la génération
divergente et la critique croisée. **JAMAIS de Claude via API
payante** — Claude est déjà là, gratuitement.

**Clarification :** Claude Max n'est PAS un tier web gratuit.
C'est un abonnement payant avec accès illimité à Opus, support
MCP natif, et 1M tokens de contexte.

## Ce que fait /brainstorming (en 30 secondes)

Tu poses un problème. Tu tapes `/brainstorming`. Voici ce qui
se passe :

**Cadrage.** Claude analyse le sujet, calibre la profondeur
(2 appels pour un sujet simple, jusqu'à 12 pour un sujet
stratégique), et choisit la méthode.

**Génération divergente.** Claude lance 2-4 appels RedAPI en
parallèle blind — chaque modèle IA reçoit un rôle et des
contraintes de diversification distincts. Aucun ne voit les
outputs des autres.

**Discussion orchestrée.** Claude structure les idées, identifie
les hypothèses non vérifiées, lance automatiquement des
recherches pour les vérifier, puis relance un tour de
développement. C'est le cœur de la V2 : une boucle itérative
avec fact-checking dynamique intégré.

**Convergence anti-biais.** Les idées sont catégorisées (COCD Box)
puis scorées (NAF), avec protection explicite des idées radicales
et scoring par un modèle différent du générateur.

---

## Fondements scientifiques (pourquoi cette architecture)

Ce skill est informé par une revue de littérature de 6 rapports
Deep Research couvrant :

- **Artificial Hivemind** (NeurIPS 2025 Best Paper) : les LLMs
  convergent créativement même entre familles architecturales.
  La diversité vient des prompts, pas des modèles.
- **MIDAS** (arXiv 2601.00475) : le scoring de novelty progressif
  surpasse le one-shot.
- **FIRE** (NAACL 2025) : déclenchement conditionnel de recherches
  (confiant → agir, non confiant → chercher) réduit les coûts 7.6×.
- **Tool-MAD** (Jan 2026) : Stability Score comme signal d'arrêt.
- **Paulus (2017)** : le brainstorming hybride (individuel puis
  collectif) surpasse les deux modes séparés.
- **Rietzschel, Nijstad & Stroebe** : corrélation originalité/
  faisabilité = r = −0.42 → les idées radicales sont systématiquement
  éliminées sans protection structurelle.
- **Cambridge Design Science (2025)** : sequential prompting
  (1 prompt par rôle) > collective prompting.

Aucun produit commercial ni framework publié ne combine idéation
multi-LLM + fact-checking intra-boucle + convergence structurée
anti-biais (vérifié par Perplexity Deep Research, avril 2026).

**Outils RedAPI exploités** (quand disponibles) :
- `embed_texts` : génération d'embeddings pour calcul de similarité
  (via Perplexity Embeddings API). Voir Phase 2 pour l'usage exact.
- `session_state` : persistance inter-skills pour skill chaining
- `metrics` : observabilité des appels et coûts
- Policy gate PHI (gate/policy.py) : détection automatique NIRPP,
  dates de naissance, noms avant envoi vers providers externes

---

## Méthodes disponibles

Claude choisit automatiquement, ou l'utilisateur spécifie.

| Méthode | Quand | Commande |
|---------|-------|----------|
| **Brainwriting multi-IA** | Exploration libre (défaut) | `/brainstorming` |
| **SCAMPER** | Améliorer l'existant | `/brainstorming scamper` |
| **6 chapeaux de Bono** | Décision multi-perspectives | `/brainstorming chapeaux` |
| **Inversion / Pré-mortem** | Blocage créatif, risques | `/brainstorming inversion` |
| **Analogie forcée** | Innovation radicale, inter-domaines | `/brainstorming analogie` |
| **TRIZ** | Contradiction technique | `/brainstorming triz` |
| **Matrice morphologique** | Combinatoire multi-paramètres | `/brainstorming matrice` |
| **Starbursting** | Cadrer un sujet flou | `/brainstorming starbursting` |
| **CPS** | Problème complexe mal défini | `/brainstorming cps` |
| **Biomimétrie** | Design durable, bio-inspiré | `/brainstorming bio` |

**Arbre de sélection automatique :**
- Contradiction technique identifiable → TRIZ
- Solution existante à améliorer → SCAMPER
- Problème mal défini / exploratoire → Starbursting → puis CPS
- Multi-paramètres quantifiables → Matrice Morphologique
- Besoin d'analogie distante → Analogie forcée / Biomimétrie
- Risques à identifier → Pré-mortem / Inversion
- Perspectives contradictoires → 6 Chapeaux
- Défaut → Brainwriting multi-IA

---

## Phase 0 — Cadrage adaptatif (Claude seul, pas d'appel)

Dans l'extended thinking, analyser sur 4 dimensions :

**1. Nature** : exploration / amélioration / contradiction /
   décision / risques
**2. Complexité** → calibrage du budget d'appels :

| Complexité | Budget appels | Phase 1 | Phase 3 | Phase 4 |
|------------|--------------|---------|---------|---------|
| **Simple** (nom, choix binaire) | 2-3 | 2 | 0 | 0-1 |
| **Moyen** (problème cadré) | 6-8 | 3 | 2-3 | 1-2 |
| **Complexe** (stratégique, multi-dimensionnel) | 10-12 | 3-4 | 4-5 | 2-3 |

Règle absolue : **≥40% du budget sur la Phase 3** (discussion +
vérification). Jamais moins.

**Plafond de coût (NOUVEAU v4.1) :** $2.00 maximum par
brainstorming, tous appels confondus. Si le budget estimé
dépasse ce plafond, réduire le nombre de tours Phase 3
ou passer à des modèles moins chers (DeepSeek slot 1).

**3. Domaine** : SST, technique, organisationnel, clinique, personnel
**4. Méthode** : sélection auto ou respect du choix explicite

Annoncer le cadrage en 2 lignes max. Si ambigu, poser UNE
question avant de lancer.

---

## Phase 1 — Génération divergente (parallèle blind)

Lancer 2-4 appels RedAPI. Chaque modèle reçoit le même
contexte-problème + un rôle unique + des contraintes de
diversification. **Aucun modèle ne voit les outputs des autres.**

### Rôles et modèles

| Rôle | Modèle | Stratégie prompt |
|------|--------|------------------|
| **Éclaireur** | `ai_search("...", "sonar-pro")` pour sujet simple. `deep_research("...", reasoning_effort="medium")` pour sujet complexe (MODIFIÉ v4.1) | État de l'art, signaux faibles, tendances, ce qui existe |
| **Architecte** | `ai_chat("deepseek-chat", ...)` | Décomposition systémique, leviers, contradictions |
| **Provocateur** | `ai_chat("openrouter/x-ai/grok-4.20", ...)` | Rupture, analogies improbables, Denial Prompting. System prompt : "Sois direct, incisif, concret. Maximum 200 mots." |
| **Raisonneur** | `ai_chat("openrouter/google/gemini-3.1-pro-preview", ...)` | Analyse structurée, GPQA 94.3%, fiabilité factuelle #1 |
| **Critique** | `ai_chat("deepseek-chat", ...)` | Failles, risques, pré-mortem, angles morts |

### Escalade Éclaireur par complexité (NOUVEAU v4.1)

| Complexité | Outil Éclaireur | Coût | Justification |
|-----------|----------------|------|---------------|
| Simple | `ai_search(query, "sonar-pro")` | ~$0.01 | Question factuelle rapide |
| Moyen | `ai_search(query, "sonar-pro")` | ~$0.01 | Suffisant pour état de l'art cadré |
| Complexe | `deep_research(query, reasoning_effort="medium")` | ~$0.41 | Rapport multi-sources nécessaire |
| SST complexe | `hybrid_research(query, sources=["web","meddata","sstinfo"])` | Variable | Croisement web + bases internes. ATTENTION : l'ordre des sources n'est pas garanti par l'agent |

### Règles de sélection

- Sujet simple : Éclaireur + Architecte (2 appels)
- Sujet créatif ou bloqué : + Provocateur Grok (3 appels)
- Décision à enjeu : + Raisonneur Gemini ou Critique (4 appels)
- Stratégique/complexe : les 5 (ou 4 en fusionnant Architecte+Critique)

### Contraintes de diversification forcée

Appliquer systématiquement dans les prompts envoyés :

**Semantic Tabu** (Provocateur) : « Ta réponse NE DOIT PAS
mentionner les solutions suivantes : [liste des solutions
évidentes identifiées au cadrage] »

**Cross-domain forcing** (Provocateur, Analogie forcée) :
« En t'inspirant des mécanismes de [domaine distant imposé par
Claude], propose des solutions au problème suivant... »

**Constraint bracketing** : « La solution ne doit PAS utiliser
[contrainte d'exclusion]. Elle doit fonctionner sans [ressource
habituelle]. »

**Zéro few-shot** pour les rôles créatifs — le few-shot ancre
sur des exemples existants et réduit la divergence.

### Construction des prompts envoyés

- Contexte complet du sujet dans chaque prompt
- Rôle assigné explicitement
- Contraintes de diversification ci-dessus
- Format structuré demandé (liste numérotée avec ID)
- Langue : français sauf sujet anglophone
- Max 300 mots de prompt par appel

### Adaptation par méthode

- **SCAMPER** → chaque IA reçoit des opérateurs SCAMPER différents
  (ex : Éclaireur = Substitute+Adapt, Provocateur = Reverse+Eliminate)
- **6 chapeaux** → chaque IA incarne un chapeau
  (Éclaireur = Blanc, Provocateur Grok = Vert, Critique = Noir,
  Raisonneur Gemini = Jaune)
- **TRIZ** → Éclaireur cherche les contradictions, Architecte
  identifie les principes inventifs applicables
- **Inversion** → tous génèrent « comment aggraver le problème »

---

## Phase 2 — Structuration (Claude seul, pas d'appel)

Claude agrège tous les outputs et effectue :

1. **Assignation d'ID unique** à chaque idée (I01, I02...)
2. **Regroupement thématique** par catégories (max 7)
3. **Déduplication** : fusionner les variantes proches
4. **Marquage des convergences** : idées produites indépendamment
   par 2+ modèles → signal fort (★)
5. **Marquage des singletons** : idées d'un seul modèle → potentiel
   de novelty (◆)
6. **Identification des gaps** : zones de l'espace-problème non
   couvertes par les IA
7. **Estimation de novelty** (MODIFIÉ v4.1) :
   - **Méthode principale** : jugement Claude sur l'originalité
     relative de chaque idée par rapport aux autres et au contexte.
     C'est une évaluation qualitative, pas un score calculé.
   - **Si `embed_texts` disponible** (enrichissement optionnel) :
     Générer les embeddings de chaque idée via
     `embed_texts(texts=[idée1, idée2, ...])` puis calculer
     la matrice de similarité cosinus. Les idées à faible
     similarité avec toutes les autres sont marquées ◆ (novel).
     ATTENTION : `embed_texts` génère des vecteurs bruts — il
     n'y a PAS de base vectorielle ni de fonction search intégrée.
     Le calcul de similarité est fait par Claude sur les vecteurs
     retournés.
   - **Si `embed_texts` indisponible** → jugement Claude seul
     (suffisant dans la majorité des cas).

Appliquer ensuite le traitement spécifique à la méthode :

- **Brainwriting** : regrouper par thème
- **SCAMPER** : mapper sur les 7 opérateurs, compléter les manquants
- **6 chapeaux** : répartir par chapeau, compléter
- **Inversion** : inverser chaque proposition en solution
- **Analogie** : extraire les mécanismes, transposer au domaine cible
- **TRIZ** : identifier la contradiction, mapper les principes
- **Matrice** : construire paramètres × variantes, identifier les
  combinaisons non-évidentes
- **Pré-mortem** : lister scénarios d'échec, prioriser par probabilité × impact
- **Starbursting** : classer les questions (Qui/Quoi/Où/Quand/Comment/Pourquoi)

---

## Phase 3 — Discussion orchestrée avec fact-checking dynamique

C'est le cœur de /brainstorming V2. Cette phase n'existe que
pour les sujets de complexité **moyenne ou complexe** (≥6 appels).
Les sujets simples passent directement à la Phase 4.

### Tour 1 — Critique croisée (1-2 appels)

Envoyer les idées structurées (avec IDs) à un agent Critique
via RedAPI (`ai_chat("openrouter/x-ai/grok-4.20", ...)` —
challenger naturel, famille différente des générateurs).
System prompt additionnel : "Sois direct, incisif, concret.
Maximum 200 mots. Pas de listes à puces."
Le Critique reçoit un **template imposé** :

```
Pour chaque idée (citer l'ID) :
1. FORCES (1-2 phrases)
2. FAILLES (1-2 phrases)
3. HYPOTHÈSES IMPLICITES (max 3) :
   H1: [Énoncé vérifiable] | Type: Assomption / Présupposé / Donnée non sourcée
4. QUESTION DE VÉRIFICATION :
   Q1: [Question fermée nécessitant recherche web]
```

Ce format force la production d'hypothèses vérifiables plutôt
que de critiques génériques.

### Tour 2 — Vérification dynamique (1-2 appels)

Claude parse les hypothèses H et questions Q du Critique.
Pour chaque hypothèse vérifiable et importante :
- Lancer `ai_search(Q, "sonar-pro")` ou `ai_chat("sonar-pro", Q)`
- Réinjecter le résultat dans le contexte

Ne vérifier que les hypothèses **critiques** (celles dont la
véracité changerait fondamentalement la viabilité de l'idée).
Maximum 2 vérifications par tour.

### Tour 3 — Développement (1 appel)

Un agent Développeur reçoit :
- Les idées survivantes + résultats de vérification
- Consigne : « Propose des variantes, des combinaisons inter-idées,
  des approfondissements. Intègre les résultats de vérification.
  Interdit de répéter les idées existantes. »

### Tour 4 — Pré-mortem conditionnel (0-1 appel)

Uniquement pour les sujets stratégiques ou à enjeu.
Pour les top 3-5 idées : « Imagine que cette idée a été
implémentée et a échoué. Quelle est la cause la plus probable ? »

### Heuristique d'arrêt (MODIFIÉ v4.1)

Après chaque tour, Claude évalue qualitativement :

```
L'orchestrateur se pose 3 questions :
1. Est-ce que ce tour a apporté des idées substantiellement
   nouvelles ? (pas des variantes de l'existant)
2. Est-ce que les modèles commencent à se répéter ou à
   reformuler les mêmes concepts ?
3. Est-ce que le budget d'appels restant justifie un tour
   supplémentaire ?

Décisions :
- Nouvelles idées substantielles → CONTINUER
- Reformulations / redondance > 70% → ARRÊTER ou INJECTION DISRUPTIVE
- Budget épuisé ou plafond $2 atteint → ARRÊTER
- ≥4 tours → ARRÊTER (plafond absolu)
```

C'est une heuristique qualitative, pas une métrique calculée.
Claude utilise son jugement sur le contexte complet de la
conversation — ce qu'aucune formule ne peut remplacer.

**Injection disruptive** (si détection de convergence
prématurée au tour 3) : relancer un appel Provocateur avec
« Génère une perspective radicalement différente. Interdit
d'utiliser les arguments ou concepts déjà mentionnés :
[liste des concepts récurrents]. Adopte le point de vue de
[persona inattendu]. »

---

## Phase 4 — Convergence structurée anti-biais

### Couche 1 — COCD Box (How-Now-Wow)

Catégoriser chaque idée survivante :

- 🔵 **Now** — conventionnelle + faisable → quick win
- 🔴 **Wow** — originale + faisable → PRIORITÉ
- 🟡 **How** — originale + pas encore faisable → garder à horizon long

**Protection explicite** : les idées 🟡 ne sont JAMAIS éliminées.
Elles sont conservées dans « Pépites à horizon long ».
(Fondement : biais de faisabilité documenté par Mueller et al. 2012,
r = −0.42 entre originalité et faisabilité.)

### Couche 2 — NAF Scoring (Novelty-Attractiveness-Feasibility)

Pour chaque idée 🔴 Wow et 🔵 Now, scorer sur 3 axes (1-5) :

- **N** (Novelty) — originalité relative dans le contexte
- **A** (Attractiveness) — bénéfice perçu, impact potentiel
- **F** (Feasibility) — réalisme d'implémentation

**Scoring Aveugle à Double Couche** (anti-biais de confirmation) :

Pour les sujets complexes, le scoring est fait par un modèle
**différent** du générateur :
1. Claude anonymise les idées (supprime indicateurs d'origine)
2. Envoyer les idées anonymes à Qwen 3.5 (meilleur juge FR,
   Pearson 44.77, arXiv:2603.04033) via
   `ai_chat("openrouter/qwen/qwen3.5-397b-a17b", ...)`
   avec grille NAF. Alternativement Gemini 3.1 Pro.
   **JAMAIS GPT-5.4 comme scoreur de ses propres idées**
   (SPB 1.47 — HSPP-Ratio mesuré sur IFEval, arXiv:2604.06996).
3. Réconciliation : si écart > 2 points avec l'évaluation
   interne de Claude → justification obligatoire.
   Pondération : 70% scoring externe, 30% scoring interne.

Pour les sujets simples, Claude fait le scoring seul
(le surcoût d'un appel supplémentaire n'est pas justifié).

### Couche 3 — Shortlist finale

Top 3-7 idées classées par score NAF pondéré.
Pour chaque idée : origine (quel modèle), convergence
(combien de modèles l'ont produite), résultats de vérification
le cas échéant.

---

## Phase 5 — Livrable

Format dans le chat (pas d'artifact, pas de panneau latéral) :

```
## 🧠 [Titre du brainstorming]
**Méthode** : [méthode] | **Sources IA** : [modèles] | **Tours** : [n] | **Appels** : [n] | **Coût** : ~$[total]

### 🔴 Idées Wow (originales + faisables)
1. **[Nom]** — Description 1-2 phrases
   Origine : [modèle/convergence ★]. NAF : N_/A_/F_ = total
   [Vérifié : résultat fact-check si applicable]

### 🔵 Idées Now (quick wins)
...

### 🟡 Pépites à horizon long
Idées radicales pas encore faisables mais à garder.

### ⚠️ Angles morts
Ce que le brainstorming n'a PAS couvert.

### ▶️ Prochaine étape
Action concrète ou question à creuser.

### 🔗 Skill chaining
[suggestion contextuelle du skill suivant]
```

**Skill chaining** : en fin de livrable, suggérer le skill
suivant le plus pertinent :
- Idées Wow à développer → « ▶️ `/agent` pour développer I03 et I07 »
- Vérification SST nécessaire → « ▶️ `/expert` pour qualifier I03 »
- Formalisation → « ▶️ `/document` pour produire un référentiel »
- Vérification multi-modèle → « ▶️ `/council` pour challenger I05 »

**Persistance** : après convergence, sauvegarder via
`session_state("set", "brainstorm_result", {
  wow_ideas: [...], now_ideas: [...], how_ideas: [...],
  method: "...", domain: "...", turns: n
})`
Le skill suivant peut récupérer cet état automatiquement.

**Calibration du livrable :**
- Simple → top 3-5, format court, pas de COCD explicite
- Moyen → top 5-7, COCD + NAF
- Complexe → livrable complet + suggestion `/agent` pour
  développer les meilleures pistes

---

## Adaptation par domaine

| Domaine | Critères de faisabilité | Angle particulier |
|---------|----------------------|-------------------|
| SST / médecine du travail | Réglementaire, acceptabilité, SPSTI | Croiser avec SSTinfo si pertinent |
| Technique / dev | Complexité, dette, maintenance | ai_search état de l'art |
| Organisationnel | Résistance au changement, coût, délai | Perspective RH |
| Clinique | Evidence-based, bénéfice/risque | Croiser MedData |
| Personnel / créatif | Motivation, plaisir, alignement | Moins de contraintes, plus de divergence |

---

## Garde-fous

**JAMAIS de Claude via API** : Claude = cerveau GRATUIT dans le
chat (Architecture V3 §0). Toute orchestration, structuration,
convergence et rédaction = Claude directement. Seuls les modèles
non-Claude passent par RedAPI.

**Plafond de coût** : $2.00 maximum par brainstorming. Si le
budget estimé dépasse ce plafond au cadrage, réduire la
complexité (moins de tours Phase 3, modèles moins chers).

**Policy gate PHI** : avant chaque appel `ai_chat` vers un
provider externe, vérifier qu'aucune donnée nominative (NIRPP,
date de naissance, noms) n'est envoyée. Si PHI détecté :
dépersonnaliser ou bloquer. (gate/policy.py, V3 §3.0)

**Limite prompt 225K tokens en entrée** : chaque appel ai_chat
ne doit PAS dépasser 225 000 tokens en entrée (sécurité :
Qwen 262K, Grok 256K). Tronquer le contexte si nécessaire.

**System prompt Grok** : tout appel à Grok 4.20 DOIT inclure :
"Sois direct, incisif, concret. Maximum 200 mots. Pas de listes
à puces." (validé dans cette conversation : 300 tokens au lieu
de 1150, qualité identique).

**GPT-5.4 SPB** : JAMAIS utilisé comme juge/scoreur de ses
propres outputs (SPB 1.47, HSPP-Ratio arXiv:2604.06996).
Utiliser Qwen 3.5 ou Gemini.

**Anti-superficialité** : les idées doivent être concrètes.
« Améliorer la communication » est interdit — dire COMMENT.

**Anti-complaisance** : le tri est honnête. Les idées médiocres
sont écartées ou reléguées, pas validées.

**Anti-sur-ingénierie** : le cadrage Phase 0 calibre agressivement.
2 appels pour « trouve un nom de projet ». Ne pas dérouler la
machinerie complète quand elle n'est pas justifiée.

**Anti-sycophantie** : pas de « Excellent sujet ! ». Pas de
faux consensus entre les tours de discussion. Le désaccord
entre modèles est documenté, pas effacé.

**Transparence** : indiquer quel modèle a produit quelle idée.
Documenter les convergences multi-modèles (★) et les singletons (◆).

**Pas de machinerie visible** : l'utilisateur voit le cadrage bref,
attend les appels, puis reçoit le livrable. Pas de « Phase 2 en
cours... ».

**Héritage contextuel** : le skill hérite des contraintes du
projet actif, des memory edits, et des préférences utilisateur.

---

## Interaction avec les autres skills

| Combinaison | Comportement |
|---|---|
| `/sens` + `/brainstorming` | /sens clarifie → /brainstorming travaille sur l'input structuré |
| `/brainstorming` + `/agent` | /brainstorming génère → /agent développe en profondeur |
| `/brainstorming` + `/document` | /brainstorming génère → /document formalise |
| `/brainstorming` + `/council` | /brainstorming génère → /council challenge les top idées |
| `/brainstorming` seul | Pipeline complet dans le chat |

---

## Ce que /brainstorming n'est PAS

- Pas une recherche documentaire (→ outils MCP directs ou /expert)
- Pas une analyse critique d'un existant (→ /agent)
- Pas un outil de décision (il génère des options, ne décide pas)
- Pas un prompt forwarder (il orchestre, cadre, vérifie, synthétise
  et trie — il ne relaie pas une question aux IA)
- Pas un substitut à la réflexion humaine (l'utilisateur tranche,
  le skill propose)
- Pas un moyen de contourner V3 §0 (Claude n'est JAMAIS appelé
  via API payante — il orchestre gratuitement)
