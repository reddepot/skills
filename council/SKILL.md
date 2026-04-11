---
name: council
description: >
  Panel multi-modeles REEL via RedAPI (ai_chat, ai_reason).
  Appelle de vrais modeles NON-Claude (Gemini, GPT, DeepSeek,
  Grok, Qwen) via MCP. Claude = cerveau gratuit, JAMAIS via API.
  RAG-first en SST. Consensus voting INTERDIT en SST/juridique.
  DECLENCHEURS : /council, panel multi-modeles, avis croise IA,
  compare les modeles, second avis IA, critique croisee,
  cross-check avec Gemini/GPT.
  NE S'ACTIVE PAS : recherche factuelle (RAG), redaction
  standard (Claude seul), tache mono-modele.
  4 panels : A (SST 3 axes : medical/risques pro/interference),
  B (audit code), C (LLM-as-Judge), D (analyse generale).
  SYNERGIE : /sens, /council, /agent, livrable.
---

# /council -- Panel Multi-Modeles Orchestre -- v4.1 (Architecture V3)

## Principe fondateur : CLAUDE = CERVEAU, RedAPI = BRAS

Claude Opus 4.6 (via Claude Max, abonnement payant illimite)
est l'orchestrateur. Il a acces aux 3 serveurs MCP (SSTinfo,
MedData, RedAPI) via le protocole MCP. Le RAG EST connecte
programmatiquement a Claude.

**Clarification :** Claude Max n'est PAS un tier web gratuit.
C'est un abonnement payant avec acces illimite a Opus, support
MCP natif, et 1M tokens de contexte.

RedAPI ne doit JAMAIS appeler Claude via API payante.

---

## Relation /council (skill) vs ai_consensus (outil MCP)

| | /council (skill) | ai_consensus (outil MCP) |
|---|---|---|
| Orchestre par | Claude dans le chat | RedAPI cote serveur |
| Chairman | Claude (gratuit, contextuel) | Chairman auto cote serveur |
| RAG pre-appel | Oui (Claude appelle SSTinfo/MedData) | Non (requete brute) |
| Panels specialises | A/B/C/D avec prompts adaptes | Generique (meme prompt a tous) |
| Peer review | Non (Claude juge) | Oui (automatique, blinding) |
| Quand utiliser | Questions complexes, SST, code | Verification rapide, test |

**Regle :** SST/medico-juridique → toujours /council.
Verification rapide hors domaine critique → ai_consensus.

---

## Cinq invariants

1. **Specialisation fonctionnelle** -- chaque modele a un role unique.
2. **Anti-consensus SST** -- le vote est INTERDIT en SST/juridique FR.
3. **RAG-first** -- les faits viennent des outils MCP, jamais des modeles.
4. **Provenance tracee** -- chaque element attribue a son modele source.
5. **Limite prompt 225K tokens en ENTREE** -- ne pas confondre avec
   max_tokens en sortie. Tronquer si necessaire.

---

## Gate de declenchement

(identique v4 -- non repete ici pour concision)

---

## Protocole de conflit de sources (NOUVEAU v4.1)

Si les sources RAG se contredisent :

1. **Hierarchie normative** :
   Legifrance (loi/decret) > INRS (recommandation) > Judilibre > MedData
2. **Temporalite** : la source la plus recente prime si modification
3. **Documenter le conflit** dans le livrable avec les 2 sources et dates
4. **Ne jamais masquer une contradiction**

---

## Panel C -- Mode light (NOUVEAU v4.1)

En plus du mode complet (6 appels), un mode rapide :

```
/council light : evaluation rapide
1 juge unique (Qwen 3.5), 1 passe, blinding, ~$0.05
Claude complete le jugement (gratuit)
```

Mode complet pour evaluations a enjeu. Mode light pour pre-filtres.

(le reste du skill est identique a la v4 -- panels A/B/C/D,
construction des prompts, garde-fous, limites, etc.)
