---
name: jury
description: >
  Panel multi-modeles REEL via RedAPI (ai_chat, ai_reason).
  Appelle de vrais modeles NON-Claude (Gemini, GPT, DeepSeek,
  Grok, Qwen) via MCP. Claude = cerveau gratuit, JAMAIS via API.
  RAG-first en SST. Consensus voting INTERDIT en SST/juridique.
  DECLENCHEURS : /jury, panel multi-modeles, avis croise IA,
  compare les modeles, second avis IA, critique croisee,
  cross-check avec Gemini/GPT.
  NE S'ACTIVE PAS : recherche factuelle (RAG), redaction
  standard (Claude seul), tache mono-modele.
  4 panels : A (SST 3 axes : medical/risques pro/interference),
  B (audit code), C (LLM-as-Judge), D (analyse generale).
  SYNERGIE : /oriente, /analyse, /expertise, /document.
---

# /jury — Panel Multi-Modèles Orchestré — v4.1 (Architecture V3)

## Principe fondateur : CLAUDE = CERVEAU, RedAPI = BRAS

Claude Opus 4.6 (via Claude Max, abonnement payant illimité)
est l'orchestrateur. Il a accès aux 3 serveurs MCP (SSTinfo,
MedData, RedAPI) via le protocole MCP. Le RAG EST connecté
programmatiquement à Claude.

RedAPI ne doit JAMAIS appeler Claude via API payante.

---

## Relation /jury (skill) vs ai_consensus (outil MCP)

| | /jury (skill) | ai_consensus (outil MCP) |
|---|---|---|
| Orchestré par | Claude dans le chat | RedAPI côté serveur |
| Chairman | Claude (gratuit, contextuel) | Chairman auto côté serveur |
| RAG pré-appel | Oui (Claude appelle SSTinfo/MedData) | Non (requête brute) |
| Panels spécialisés | A/B/C/D avec prompts adaptés | Générique (même prompt à tous) |
| Peer review | Non (Claude juge) | Oui (automatique, blinding) |
| Quand utiliser | Questions complexes, SST, code | Vérification rapide, test |

**Règle :** SST/médico-juridique → toujours /jury.
Vérification rapide hors domaine critique → ai_consensus.

---

## Cinq invariants

1. **Spécialisation fonctionnelle** — chaque modèle a un rôle unique.
2. **Anti-consensus SST** — le vote est INTERDIT en SST/juridique FR.
3. **RAG-first** — les faits viennent des outils MCP, jamais des modèles.
4. **Provenance tracée** — chaque élément attribué à son modèle source.
5. **Limite prompt 225K tokens en ENTRÉE** — ne pas confondre avec
   max_tokens en sortie. Tronquer si nécessaire.

---

## Convention RedAPI

Voir conventions.md §2 pour le protocole commun (prompt
auto-contenu, max 2 appels par phase, fallback, plafond $2,
policy gate PHI, limite 225K tokens).

---

## Protocole de conflit de sources

Si les sources RAG se contredisent :

1. **Hiérarchie normative** :
   Légifrance (loi/décret) > INRS (recommandation) > Judilibre > MedData
2. **Temporalité** : la source la plus récente prime si modification
3. **Documenter le conflit** dans le livrable avec les 2 sources et dates
4. **Ne jamais masquer une contradiction**

---

## Panel C — Mode light

En plus du mode complet (6 appels), un mode rapide :

```
/jury light : évaluation rapide
1 juge unique (Qwen 3.5), 1 passe, blinding, ~$0.05
Claude complète le jugement (gratuit)
```

Mode complet pour évaluations à enjeu. Mode light pour pré-filtres.

---

## Synergie avec les autres skills

| Skill | Relation | Quand |
|-------|----------|-------|
| `/oriente` | Amont | Si activé, sa carte de sens guide la question. |
| `/analyse` | Intégré | /analyse externalise le Challenger via /jury si score ≥ 8. |
| `/expertise` | Complémentaire | /jury apporte des perspectives IA réelles là où /expertise apporte du RAG. |
| `/document` | Aval | /jury peut challenger un brouillon de document en phase 3. |
| `/brainstorming` | Complémentaire | /brainstorming peut challenger ses top idées via /jury. |

/jury n'est PAS un proxy obligatoire pour RedAPI. Chaque skill
peut appeler RedAPI directement via conventions.md §2.

---

## Anti-sycophantie

Profil MODÉRÉ (conventions.md §1). Vérification à la convergence.
Perspectives divergentes documentées, pas forcées à converger.
Le dissensus est livré au résultat, pas effacé.

---

## Ce que /jury n'est PAS

- Pas un proxy obligatoire pour les appels RedAPI
- Pas un substitut à la recherche factuelle (→ outils MCP)
- Pas un outil de vote en SST/juridique (le consensus est interdit)
- Pas un moyen d'appeler Claude via API (Claude est déjà là)
