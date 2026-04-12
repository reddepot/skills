# Architectures détaillées — 8 patterns

## Pattern 1 — Pipeline séquentiel enrichi

Chaîne linéaire + checkpoints + agent élévateur final.
3-5 agents. Traçabilité maximale, debug simple.

Quand : rapport, guide, tutoriel, livrable linéaire.
Synergie : si le livrable est un document formel → enchaîner avec /document.

```
Agent 1 (recherche) → checkpoint → Agent 2 (structuration)
→ checkpoint → Agent 3 (rédaction) → checkpoint
→ Agent 4 (élévation) → Challenger → livraison
```

Contrats I/O :
- Agent recherche : input=brief → output=corpus sourcé
- Agent structuration : input=corpus → output=plan validé
- Agent rédaction : input=plan+corpus → output=brouillon
- Agent élévation : input=brouillon → output=brouillon enrichi

## Pattern 2 — Fan-out / Fan-in avec harmonisation

Sous-tâches parallèles → synthèse → harmonisation.
3-8 spécialistes + 1 synthétiseur.

Quand : chapitres indépendants, comparaisons multi-angles.
Attention : "Fan-out is easy, fan-in is the work."
Prévoir des règles de merge explicites pour les conflits.

Contrats I/O :
- Chaque spécialiste : input=sous-question → output=analyse ≤500 mots
- Synthétiseur : input=toutes les analyses → output=synthèse harmonisée
  avec signalement des contradictions inter-agents

## Pattern 3 — Confrontation adversariale

Agents à thèses divergentes → critique croisée → arbitrage.
2-3 débatteurs + 1 juge.

Quand : sujets controversés, stress-test, décision à enjeu.
Synergie : pour enjeux élevés, externaliser le juge via /council.

Architectures de référence (2025-2026) :
- D3 (Debate, Deliberate, Decide) : advocate / judge / jury optionnel
- DREAM : positions initiales opposées + critique réciproque itérative

Règles :
- Max 2-3 rounds. Au-delà, rendements décroissants.
- Pas de vote/consensus en SST/juridique.
- Le juge arbitre sur la qualité des arguments, pas sur la majorité.
- Détecter la convergence artificielle (§5 du SKILL.md).

## Pattern 4 — Boucle auteur-critique intensive

Auteur → critique (grille) → révision → itération.
1 auteur + 1 critique + 1 superviseur. 2 tours par défaut.

Quand : rédaction à forte valeur, documents opposables.
Synergie : si document formel → passer à /document après la boucle.

Variantes (Google ADK) :
- Generator-Critic : exit condition binaire (pass/fail) — pour correction
- Iterative Refinement : amélioration qualitative — pour rédaction

Règle critique : ne pas critiquer ce qui est déjà bon.
La sur-critique dégrade les outputs de haute qualité initiale
(Table-Critic : 9.6% erreurs corrigées, 0.7% bonnes réponses dégradées).

## Pattern 5 — Rôles métier (agents fixes)

Équipe simulée à expertises nommées et complémentaires.
4-7 spécialistes + 1 chef de projet.

Quand : projets exigeant des regards croisés dans des domaines connus.
Synergie : en SST, les agents peuvent appliquer /expert (recherche)
et /standard (format terrain) dans leur périmètre.

Exemple SST :
- Agent toxicologue (méthode : données quantitatives, VLEP, dose-réponse)
- Agent juriste du travail (méthode : déductive, texte → obligation)
- Agent ergonome (méthode : analyse de l'activité réelle)
- Agent épidémiologiste (méthode : population, prévalence, biais)
- Chef de projet (synthèse, état partagé, arbitrage)

## Pattern 6 — Squelette puis remplissage de précision

Architecte (plan) → validation → rédacteurs → intégrateur.

Quand : documents longs, cohérence architecturale critique.
Synergie : l'architecte produit le plan, /document gère la rédaction
section par section avec vérification.

Contrats I/O :
- Architecte : input=brief → output=plan détaillé (sections + questions guides)
- Rédacteurs : input=1 section du plan → output=section rédigée + sources
- Intégrateur : input=toutes sections → output=document cohérent

## Pattern 7 — Meta-Prompting dynamique

Le chef de projet identifie dynamiquement les expertises nécessaires,
crée les agents ad hoc, les invoque séquentiellement.
Pas de plan figé.

Quand : tâches atypiques, domaines non anticipés.
Synergie : si une expertise SST est nécessaire, le meta-prompter
peut décider d'appeler /expert plutôt que de simuler un agent SST.

Techniques clés :
- Constraint Hardening (ajout de contraintes négatives)
- Few-Shot Injection (exemples de trajectoires réussies)
- Strategy Refactoring (changement de paradigme si convergence échoue)

## Pattern 8 — Combinaison adaptative

Hybride composé par le chef de projet.
Ex : Squelette → Fan-out → Adversarial → Boucle critique.

Quand : enjeux maximaux.
Synergie : peut enchaîner plusieurs skills — ex :
/brainstorming (diverger) → /agent P8 (orchestrer) → /document (produire).
