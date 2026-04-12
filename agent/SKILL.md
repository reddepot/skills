---
name: agent
description: >
  Orchestre la production de livrables complexes via une architecture
  multi-agents simulés, orientée qualité compétitive maximale.
  DÉCLENCHEUR EXPLICITE : /agent (toujours activer sans exception).
  DÉCLENCHEURS IMPLICITES : document structuré > 2 pages, analyse
  nécessitant des perspectives croisées, production à forte exigence
  qualité, livrable destiné à être scruté ou contesté,
  « travail approfondi », « travail exigeant », « regard critique »,
  « format expert », « analyse experte », « mode expert »,
  « qualité maximale », « deep work », ou demande explicite
  d'orchestration, d'agents ou d'architecture.
  NE S'ACTIVE PAS pour : questions factuelles, conversations courantes,
  recherches web, résumés courts, traductions, toute tâche réalisable
  en un seul passage.
  SYNERGIE : /sens, /calibre, /document, /council, /expert, /standard.
---

# /agent — Multi-Agent Orchestrator — Quality-First v5

## 1. Synergie avec les autres skills

Les cross-références ci-dessous sont des orientations, pas des
invocations automatiques. Claude décide selon le contexte.

| Skill | Relation | Quand |
|-------|----------|-------|
| `/sens` | Amont | Si activé, sa carte de sens devient l'input de /agent |
| `/calibre` | Gate concurrent | Si /calibre conclut « passage unique » → respecter sauf demande explicite. /agent ne refait PAS le scoring si /calibre l'a déjà fait. |
| `/document` | Aval | Pour les livrables documentaires. /agent orchestre la réflexion, /document gère rédaction + vérification. |
| `/expert` | Contenu | Pour la recherche SST de fond. Un agent peut appliquer le protocole /expert dans son périmètre. |
| `/standard` | Contenu | Pour formater en livrables terrain (4 blocs opérationnels). Pipeline : /agent → /expert → /standard. |
| `/council` | Outil | Voix externes RÉELLES via RedAPI. Remplace les personas simulées quand l'orthogonalité est critique. |
| `/brainstorming` | Amont | Diverger avant d'orchestrer. /agent structure, /brainstorming explore. |

**Ne pas réinventer** ce que les autres skills font déjà.

## 2. Philosophie

Qualité compétitive : chaque livrable doit surpasser ce qu'un expert
produirait seul en temps contraint.

Quatre invariants :
1. **Rigueur** — toute affirmation sourcée ou qualifiée
   (certain / probable / hypothétique / inconnu).
2. **Élévation** — chaque livrable contient un élément de valeur
   au-delà de la commande (voir `references/elevation.md`).
3. **Honnêteté épistémique** — signaler les limites = qualité.
4. **Anti-sycophantie** — le faux consensus est interdit (voir §5).

## 3. Limites structurelles (ne jamais masquer)

L'orchestration multi-agents dans un LLM unique produit de la diversité
**d'angle et de méthode**, pas de vraie diversité cognitive (même modèle
= même espace de probabilités). Pour de la vraie orthogonalité →
utiliser `/council` (modèles non-Claude via RedAPI).

Un seul passage bien prompté peut parfois faire aussi bien.
L'orchestration ne se présume pas — elle se justifie.

## 4. Gate de déclenchement

> Cette tâche serait-elle mieux servie par un seul passage ?

**Si `/calibre` a déjà été activé** → respecter sa décision.
Ne pas refaire le scoring. Passer directement à l'étape 2 (architecture).

**Sinon, score de routage** (évaluer silencieusement) :

| Critère | 0 pt | 1 pt | 2 pts |
|---------|------|------|-------|
| Volume | < 300 mots | 300-1500 mots | > 1500 mots |
| Controverse | Faible | Moyenne | Élevée |
| Domaines croisés | Un seul | Deux | Trois+ |
| Enjeu | Faible | Modéré | Opposable/critique |
| Exemples disponibles | Few-shot clairs | Partiels | Aucun |

| Score | Décision |
|-------|----------|
| 0-3 | **Passage unique** (appliquer rigueur + élévation quand même) |
| 4-5 | **Mode allégé** (1 auteur + 1 critique, 2 tours) |
| 6-7 | **Orchestration complète** |
| 8-10 | **Orchestration complète + Challenger externalisé** via /council |

Annoncer : « Score [X/10] → [décision]. Raison : [1 phrase]. »

## 5. Anti-sycophantie instrumentée

### Constitution (obligatoire pour tous les agents)

1. **Interdiction du faux consensus** — approuver = expliquer POURQUOI
   en termes de contenu.
2. **Méthodes de raisonnement distinctes** — diversité de méthode >
   diversité de persona.
3. **Dissensus documenté** — les désaccords non résolus sont livrés.
4. **Confiance indépendante** — chaque agent forme son jugement AVANT
   de considérer les conclusions des autres.

### Détection active (à chaque tour, pas seulement au 2e)

- Si un agent approuve sans citer de contenu spécifique → rejet.
- Si toutes les critiques disparaissent sans correction substantielle
  → **alerte convergence artificielle**. Documenter dans le log.
- Si le désaccord initial a été résolu sans argument nouveau →
  maintenir le dissensus.

## 6. Architectures

8 patterns, combinables. Chaque agent a un cadre cognitif et une
méthode de raisonnement structurellement différents des autres.
(Charger `references/patterns.md` — voir §10 pour la cascade.)

| # | Pattern | Pour |
|---|---------|------|
| 1 | Pipeline séquentiel | Rapport, guide, tutoriel |
| 2 | Fan-out / Fan-in | Chapitres, comparaisons |
| 3 | Confrontation adversariale | Sujets controversés, stress-test |
| 4 | Boucle auteur-critique | Rédaction à forte valeur, docs opposables |
| 5 | Rôles métier | Regards croisés domaines connus |
| 6 | Squelette + remplissage | Documents longs |
| 7 | Meta-Prompting dynamique | Tâches atypiques |
| 8 | Combinaison adaptative | Enjeux maximaux |

**Max 2 tours par agent.** Au-delà, rendements décroissants.

## 7. Challenger

Intervient avant livraison. Ne produit pas de contenu — il attaque.

**Quote-grounding** — cite le passage exact avant de critiquer.
**Pre-mortem** — « si ce livrable échouait, la raison serait... »

Checklist :
- [ ] Hypothèses non-déclarées identifiées ?
- [ ] Contre-argument le plus fort formulé ?
- [ ] Affirmations non-sourcées repérées ?
- [ ] Dissensus documenté ?
- [ ] Pre-mortem traité ?
- [ ] Convergence artificielle détectée ? (§5)

**Externalisation (score ≥ 8 ou domaine SST/juridique/opposable) :**
Appeler `/council` — `ai_chat` avec DeepSeek ou Gemini.
Prompt auto-contenu : livrable + critères + consigne de critique.
Max 2 appels. Si échec → Challenger interne.
(Charger `references/challenger.md` pour le protocole D3 complet.)

Si le Challenger ne trouve rien → le dire honnêtement.

## 8. État partagé (contexte long)

Pour les orchestrations > 5 agents ou > 10 000 tokens.

**Initialisation** (au démarrage de l'orchestration) :
```
ÉTAT — [titre du livrable]
├─ Objectif : [1 phrase]
├─ Contrainte projet : [1 ligne de la contrainte la plus critique]
├─ Conclusions acquises : [vide]
├─ Questions ouvertes : [issues du diagnostic]
├─ Dissensus : [vide]
└─ Prochain agent : [nom + mission]
```

**Mise à jour** à chaque transition d'agent.
Chaque agent produit un résumé structuré ≤ 500 mots — pas un dump.

Si contexte sature : compacter (verbatim récent > compaction > résumé lossy).

## 9. Processus

### Mode complet (score ≥ 6)

**Étape 1 — Diagnostic**
```
DIAGNOSTIC
├─ Score routage   : [X/10] — Raison : [1 phrase]
├─ Structure       : [linéaire | modulaire | argumentative | mixte]
├─ Qualité         : [standard | élevée | critique]
├─ Controverse     : [faible | moyenne | élevée]
├─ Enjeu clé       : [une phrase]
├─ Orchestration   : [passage unique | allégé | complète | complète+externe]
├─ Skills amont    : [/sens ? /calibre ? → résultats]
└─ Skills aval     : [/document ? /expert ? /standard ?]
```

**Étape 2 — Architecture + plan**
Pour chaque agent :
- Rôle + méthode de raisonnement distincte
- Input → Output (contrat)
- Critères de checkpoint

→ Attendre validation sauf mode express.

**Étape 3 — Exécution**

Mode transparent (défaut) :
```
═══ AGENT : [nom] — [rôle] — [méthode] ═══
> Contrainte projet : [rappel 1 ligne]
[COMPRENDRE] ...
[ÉVALUER] ...
[CONFIANCE] ...
[PRODUIRE] ...
─── CHECKPOINT [confiance: H|M|B] → [✓ | ↻ révision] ───
```

Mode clean (créatif, sur demande) : seul PRODUIRE livré.

**Checkpoints adaptatifs :**
- Confiance haute → checklist binaire (sourcé ? contradictions ? format ?)
- Confiance moyenne/basse → critique complète + sévérité
- Ne pas critiquer ce qui est déjà bon.

**Étape 4 — Challenger** (obligatoire, externalisé si score ≥ 8)

**Étape 5 — Élévation finale**

**Étape 6 — Livraison**
```
LOG D'ORCHESTRATION
├─ Score routage      : [X/10] — [raison]
├─ Architecture       : [pattern(s)]
├─ Agents             : [liste + méthodes + itérations]
├─ Tours totaux       : [n]
├─ Convergence suspecte : [oui/non + détail]
├─ Challenger         : [interne | externe via /council]
├─ Dissensus          : [désaccords non résolus]
├─ Élévation livrée   : [description]
├─ Skills invoqués    : [/expert, /document, /council...]
└─ Fragilités         : [limites honnêtes]
```

Si le livrable est un document formel → proposer `/document` pour
le pipeline de rédaction/vérification.

### Mode allégé (score 4-5)

1 auteur + 1 critique, 2 tours. Challenger maintenu.
`▸ [Nom] : [contribution]`

### Mode express

Quand /agent est appelé sans demande de plan :
- Diagnostic 1 ligne interne
- Architecture choisie directement, exécution format allégé
- Challenger + élévation maintenus, log allégé en fin

## 10. Fichiers de référence (à la demande)

| Référence | Fichier |
|-----------|---------|
| 8 patterns détaillés + contrats I/O | `patterns.md` |
| Challenger renforcé + D3 | `challenger.md` |
| Élévation par type + inner monologue | `elevation.md` |

### Cascade de chargement

1. **Projet Claude** — `project_knowledge_search`
2. **NAS** — `nas_read_file("skills/agent/references/[fichier]")`
3. **GitHub** — `web_fetch` sur
   `https://raw.githubusercontent.com/reddepot/skills/main/agent/references/[fichier]`
4. **Mode dégradé** — SKILL.md seul (toujours fonctionnel).

## 11. Règles transversales

1. **Qualité d'abord** — jamais de compromis qualité/tokens.
2. **Diversité de méthode** — personas seules ≠ diversité cognitive.
3. **Anti-sycophantie** — constitution §5 toujours active.
4. **Transparence** — toute décision visible et justifiée.
5. **Héritage strict** — contraintes projet = loi pour tous les agents.
6. **Anti-sur-ingénierie** — le gate est obligatoire.
7. **Honnêteté** — certain / probable / spéculatif. Limites documentées.
8. **Critique proportionnée** — ne pas critiquer ce qui est déjà bon.
9. **Synergie** — utiliser /expert, /document, /council quand ils
   apportent plus que ce que /agent peut faire seul.
