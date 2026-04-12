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
  production de documents, analyse critique (→ /analyse), retex (→ /retex).
  SYNERGIE : /oriente en amont, /analyse en aval, /document pour formaliser.
---

# /brainstorming — Idéation Itérative Orchestrée Multi-IA — v4.1 (Architecture V3)

## Principe V3 : CLAUDE = CERVEAU, RedAPI = BRAS

Claude Opus 4.6 (via Claude Max, abonnement payant illimité)
orchestre tout : cadrage, structuration, convergence, rédaction.
RedAPI fournit les modèles NON-Claude pour la génération
divergente et la critique croisée. **JAMAIS de Claude via API
payante** — Claude est déjà là, gratuitement.

## Ce que fait /brainstorming (en 30 secondes)

Tu poses un problème. Tu tapes `/brainstorming`. Voici ce qui
se passe :

**Cadrage.** Claude analyse le sujet, calibre la profondeur
(2 appels pour un sujet simple, jusqu'à 12 pour un sujet
stratégique), et choisit la méthode.

**Génération divergente.** Claude lance 2-4 appels RedAPI en
parallèle blind — chaque modèle IA reçoit un rôle et des
contraintes de diversification distincts.

**Discussion orchestrée.** Claude structure les idées, identifie
les hypothèses non vérifiées, lance des recherches, puis relance
un tour de développement. Boucle itérative avec fact-checking
dynamique intégré.

**Convergence anti-biais.** COCD Box + NAF scoring, avec
protection des idées radicales et scoring par un modèle
différent du générateur.

---

## Méthodes disponibles

| Méthode | Quand | Commande |
|---------|-------|----------|
| **Brainwriting multi-IA** | Exploration libre (défaut) | `/brainstorming` |
| **SCAMPER** | Améliorer l'existant | `/brainstorming scamper` |
| **6 chapeaux de Bono** | Décision multi-perspectives | `/brainstorming chapeaux` |
| **Inversion / Pré-mortem** | Blocage créatif, risques | `/brainstorming inversion` |
| **Analogie forcée** | Innovation radicale | `/brainstorming analogie` |
| **TRIZ** | Contradiction technique | `/brainstorming triz` |
| **Matrice morphologique** | Combinatoire multi-paramètres | `/brainstorming matrice` |
| **Starbursting** | Cadrer un sujet flou | `/brainstorming starbursting` |
| **CPS** | Problème complexe mal défini | `/brainstorming cps` |
| **Biomimétrie** | Design durable, bio-inspiré | `/brainstorming bio` |

---

## Phase 0 — Cadrage adaptatif (Claude seul)

| Complexité | Budget appels | Phase 1 | Phase 3 | Phase 4 |
|------------|--------------|---------|---------|---------|
| **Simple** | 2-3 | 2 | 0 | 0-1 |
| **Moyen** | 6-8 | 3 | 2-3 | 1-2 |
| **Complexe** | 10-12 | 3-4 | 4-5 | 2-3 |

Règle : ≥40% du budget sur la Phase 3. Plafond $2.00.

---

## Phase 1 — Génération divergente (parallèle blind)

| Rôle | Modèle | Stratégie |
|------|--------|-----------|
| **Éclaireur** | `ai_search` / `deep_research` | État de l'art, signaux faibles |
| **Architecte** | `ai_chat("deepseek-chat")` | Décomposition systémique |
| **Provocateur** | `ai_chat("grok-4.20")` | Rupture, analogies. "Direct, incisif, 200 mots max." |
| **Raisonneur** | `ai_chat("gemini-3.1-pro")` | Analyse structurée |
| **Critique** | `ai_chat("deepseek-chat")` | Failles, pré-mortem |

Convention RedAPI : conventions.md §2.

---

## Phase 2 — Structuration (Claude seul)

Assignation ID, regroupement, déduplication, marquage
convergences (★) et singletons (◆), estimation de novelty.

---

## Phase 3 — Discussion orchestrée + fact-checking

Tour 1 — Critique croisée (1-2 appels)
Tour 2 — Vérification dynamique (1-2 appels)
Tour 3 — Développement (1 appel)
Tour 4 — Pré-mortem conditionnel (0-1 appel)

Heuristique d'arrêt : nouvelles idées substantielles → continuer.
Reformulations > 70% → arrêter. Budget épuisé → arrêter.
≥4 tours → arrêter (plafond absolu).

---

## Phase 4 — Convergence structurée anti-biais

**COCD Box** : 🔵 Now (quick win), 🔴 Wow (PRIORITÉ),
🟡 How (horizon long — JAMAIS éliminées).

**NAF Scoring** (Novelty-Attractiveness-Feasibility, 1-5).
Scoring aveugle par Qwen 3.5. JAMAIS GPT-5.4 comme auto-scoreur.

---

## Phase 5 — Livrable

```
## 🧠 [Titre]
**Méthode** : [m] | **Sources IA** : [m] | **Tours** : [n] | **Coût** : ~$[x]

### 🔴 Idées Wow
### 🔵 Idées Now
### 🟡 Pépites à horizon long
### ⚠️ Angles morts
### ▶️ Prochaine étape

### 🔗 Skill chaining
```

Suggestions de chaînage :
- Idées à développer → `/analyse`
- Vérification SST → `/expertise`
- Formalisation → `/document`
- Challenge multi-modèles → `/jury`

---

## Synergie avec les autres skills

| Combinaison | Comportement |
|---|---|
| `/oriente` + `/brainstorming` | /oriente clarifie → /brainstorming travaille |
| `/brainstorming` + `/analyse` | Diverger → structurer |
| `/brainstorming` + `/document` | Générer → formaliser |
| `/brainstorming` + `/jury` | Générer → challenger |

---

## Anti-sycophantie

Profil CRÉATIF (conventions.md §1). Documentation quel modèle
a produit quelle idée. Injection disruptive si convergence
prématurée. Singletons protégés.

---

## Garde-fous

- JAMAIS de Claude via API payante
- Plafond $2.00 par session
- Policy gate PHI (conventions.md §2)
- Limite 225K tokens en entrée par appel
- System prompt Grok : "Direct, incisif, 200 mots max."
- GPT-5.4 JAMAIS comme auto-scoreur (SPB 1.47)
- Anti-superficialité : idées concrètes, pas de « améliorer la communication »
- Anti-sur-ingénierie : 2 appels pour un sujet simple

---

## Ce que /brainstorming n'est PAS

- Pas une recherche documentaire (→ outils MCP ou /expertise)
- Pas une analyse critique (→ /analyse)
- Pas un outil de décision (il propose, ne décide pas)
- Pas un prompt forwarder (il orchestre, cadre, vérifie, trie)
