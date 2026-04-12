---
name: analyse
description: >
  Orchestre la production de livrables complexes via une architecture
  multi-agents simulés, orientée qualité compétitive maximale.
  DÉCLENCHEUR EXPLICITE : /analyse (toujours activer sans exception).
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
  SYNERGIE : /oriente, /document, /jury, /expertise, /fiche.
---

# /analyse — Multi-Perspective Deliberation Engine — v5

## 1. Synergie avec les autres skills

Les cross-références sont des orientations, pas des invocations automatiques.

| Skill | Relation | Quand |
|-------|----------|-------|
| `/oriente` | Amont | Si activé, sa carte de sens devient l'input. /analyse ne refait PAS le routing. |
| `/document` | Aval | /analyse orchestre la réflexion, /document gère rédaction + vérification. |
| `/expertise` | Contenu | Pour la recherche SST de fond. Un agent peut appliquer le protocole /expertise. |
| `/fiche` | Contenu | Pour formater en outils terrain. Pipeline : /analyse → /expertise → /fiche. |
| `/jury` | Outil | Voix externes RÉELLES via RedAPI. Remplace les personas simulées quand l'orthogonalité est critique. |
| `/brainstorming` | Amont | Diverger avant d'orchestrer. |

Ne pas réinventer ce que les autres skills font déjà.

## 2. Philosophie

Qualité compétitive : chaque livrable doit surpasser ce qu'un expert
produirait seul en temps contraint.

4 invariants :
1. **Rigueur** — affirmations sourcées ou qualifiées.
2. **Élévation** — valeur au-delà de la commande (voir `references/elevation.md`).
3. **Honnêteté épistémique** — signaler les limites = qualité.
4. **Anti-sycophantie** — profil CRITIQUE (conventions.md §1).

## 3. Limites structurelles (ne jamais masquer)

Même modèle = même espace de probabilités. Pour de la vraie orthogonalité
→ utiliser `/jury`. L'orchestration ne se présume pas.

## 4. Gate de déclenchement

Si `/oriente` a déjà routé → ne pas refaire le scoring.

Sinon, score de routage (évaluer silencieusement) :

| Critère | 0 pt | 1 pt | 2 pts |
|---------|------|------|-------|
| Volume | < 300 mots | 300-1500 | > 1500 |
| Controverse | Faible | Moyenne | Élevée |
| Domaines croisés | Un seul | Deux | Trois+ |
| Enjeu | Faible | Modéré | Opposable/critique |
| Exemples dispo | Few-shot clairs | Partiels | Aucun |

| Score | Décision |
|-------|----------|
| 0-3 | Passage unique (rigueur + élévation quand même) |
| 4-5 | Mode allégé (1 auteur + 1 critique, 2 tours) |
| 6-7 | Orchestration complète |
| 8-10 | Complète + Challenger externalisé via /jury |

Annoncer : « Score [X/10] → [décision]. Raison : [1 phrase]. »

## 5. Anti-sycophantie instrumentée

Constitution et détection : voir conventions.md §1, profil CRITIQUE.
Détection active à CHAQUE tour, pas seulement au 2e.

## 6. Architectures

8 patterns (charger `references/patterns.md` — voir §10).

| # | Pattern | Pour |
|---|---------|------|
| 1 | Pipeline séquentiel | Rapport, guide |
| 2 | Fan-out / Fan-in | Chapitres, comparaisons |
| 3 | Confrontation adversariale | Sujets controversés |
| 4 | Boucle auteur-critique | Docs opposables |
| 5 | Rôles métier | Regards croisés |
| 6 | Squelette + remplissage | Documents longs |
| 7 | Meta-Prompting dynamique | Tâches atypiques |
| 8 | Combinaison adaptative | Enjeux maximaux |

Max 2 tours par agent.

## 7. Challenger

Quote-grounding + pre-mortem. Voir `references/challenger.md`.
Externalisé via `/jury` si score ≥ 8 ou SST/juridique.

Checklist :
- [ ] Hypothèses non-déclarées ? Contre-argument le plus fort ?
- [ ] Affirmations non-sourcées ? Dissensus documenté ?
- [ ] Pre-mortem traité ? Convergence artificielle détectée ?

Si rien trouvé → le dire honnêtement.

## 8. État partagé (contexte long)

Pour orchestrations > 5 agents ou > 10K tokens.

```
ÉTAT — [titre]
├─ Objectif : [1 phrase]
├─ Contrainte projet : [1 ligne]
├─ Conclusions acquises : [...]
├─ Questions ouvertes : [...]
├─ Dissensus : [...]
└─ Prochain agent : [nom + mission]
```

Résumé structuré ≤500 mots par agent. Si saturation : compacter.

## 9. Processus

### Mode complet (score ≥ 6)

Étape 1 — Diagnostic (score, structure, enjeu, skills amont/aval)
Étape 2 — Architecture + plan (attendre validation sauf mode express)
Étape 3 — Exécution (transparent ou clean)
Étape 4 — Challenger (externalisé si score ≥ 8)
Étape 5 — Élévation finale
Étape 6 — Livraison + log

```
LOG D'ORCHESTRATION
├─ Score routage      : [X/10] — [raison]
├─ Architecture       : [pattern(s)]
├─ Agents             : [liste + méthodes + itérations]
├─ Convergence suspecte : [oui/non]
├─ Challenger         : [interne | externe via /jury]
├─ Dissensus          : [...]
├─ Élévation livrée   : [description]
├─ Skills invoqués    : [/expertise, /document, /jury...]
└─ Fragilités         : [limites honnêtes]
```

Si livrable = document formel → proposer `/document`.

### Mode allégé (score 4-5)
1 auteur + 1 critique, 2 tours. Challenger maintenu.

### Mode express
/analyse sans demande de plan → architecture directe, format allégé.

## 10. Fichiers de référence

| Référence | Fichier |
|-----------|---------|
| 8 patterns + contrats I/O | `patterns.md` |
| Challenger renforcé + D3 | `challenger.md` |
| Élévation + inner monologue | `elevation.md` |

### Cascade
1. `project_knowledge_search`
2. `nas_read_file("skills/analyse/references/[fichier]")`
3. `web_fetch` GitHub `reddepot/skills/main/analyse/references/[fichier]`
4. Mode dégradé.

## 11. Règles transversales

1. Qualité d'abord. 2. Diversité de méthode.
3. Anti-sycophantie (conventions.md §1). 4. Transparence.
5. Héritage projet = loi. 6. Gate obligatoire.
7. Honnêteté. 8. Critique proportionnée.
9. Synergie — utiliser /expertise, /document, /jury quand pertinent.
