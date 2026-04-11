---
name: calibre
description: >
  Calibre automatiquement la profondeur et la stratégie de réponse
  selon la nature de la tâche, en exploitant le raisonnement natif
  de Claude plutôt qu'en le contraignant. Empêche le sur-prompting
  et l'over-engineering tout en garantissant la qualité maximale
  quand elle est justifiée.
  DÉCLENCHEUR EXPLICITE : /calibre (toujours activer sans exception).
  DÉCLENCHEURS IMPLICITES : « qualité maximale », « performance
  maximale », « deep work », « travail approfondi », « mode expert »,
  « analyse experte », ou quand l'utilisateur semble forcer un
  niveau d'effort disproportionné par rapport à la tâche.
  SYNERGIE : se combine avec /agent quand la tâche relève de la
  production de livrables complexes.
  NE S'ACTIVE PAS pour : questions factuelles simples, conversations
  courantes, tâches dont le format est déjà défini par un memory
  edit ou un template de document.
---

# /calibre — Context Calibrator — v1

## Philosophie

Claude Opus 4.6 intègre un routeur de raisonnement adaptatif natif
(adaptive thinking) qui calibre automatiquement sa profondeur de
réflexion. Superposer des frameworks de raisonnement externes
(CoT, ToT, GoT) sur un modèle frontière **dégrade la performance**
dans la majorité des cas documentés (Wharton 2025, ICML 2025,
Wu et al. 2025).

Ce skill ne prescrit pas comment penser — il optimise **ce que
Claude reçoit** pour penser au mieux. La valeur est dans le
contexte, pas dans le scaffolding.

Principe directeur : **signal maximum, tokens minimum**.
Chaque token consomme du budget d'attention. Le context rot fait
chuter la précision. La bonne stratégie est de trouver le plus
petit ensemble de tokens à haute valeur informationnelle qui
maximise la probabilité du résultat souhaité.

---

## Gate : cette tâche a-t-elle besoin de calibration ?

Avant toute intervention, évaluer silencieusement :

> Le raisonnement natif de Claude suffit-il tel quel,
> ou le contexte fourni est-il insuffisant / mal calibré
> pour la qualité attendue ?

**Pas de calibration nécessaire** (répondre directement) :
- Question factuelle avec réponse connue
- Tâche dont le format est déjà défini (memory edits, templates)
- Demande simple avec contexte suffisant
- L'utilisateur a fourni des exemples clairs (few-shot)

**Calibration utile** :
- Tâche complexe avec contexte ambigu ou incomplet
- Enjeux élevés (document opposable, décision critique)
- L'utilisateur force l'effort (« qualité maximale », « /agent »)
  sans que la tâche le justifie → recadrer avec tact
- Tâche atypique sortant des patterns habituels

---

## Les 3 leviers qui fonctionnent réellement sur Opus 4.6

La recherche identifie trois interventions à gain positif
documenté sur les modèles frontières. Tout le reste est
redondant avec le raisonnement natif.

### Levier 1 — Enrichissement du contexte (toujours utile)

Le gain vient du **quoi**, pas du **comment**. Avant de
réfléchir plus, donner plus de matière :
- Documents source pertinents (pas tout, le minimum à
  haute valeur)
- Exemples concrets du résultat attendu (few-shot > consignes)
- Contraintes explicites (ce qui est interdit, le public,
  le registre)
- Critères de succès vérifiables

Heuristique : si la qualité est insuffisante, le premier
réflexe doit être « manque-t-il du contexte ? » — pas
« faut-il un framework de raisonnement ? ».

### Levier 2 — Vérification croisée (quand la fiabilité factuelle est critique)

Inspiré de Chain-of-Verification (CoVe). Utile quand une
erreur factuelle aurait des conséquences :
- Documents médico-légaux, avis d'inaptitude
- Arguments juridiques dans un courrier employeur
- Données toxicologiques (VLEP, classifications CMR)

Implémentation légère : après la rédaction, relire en
se demandant « quelles affirmations pourraient être
fausses ? » puis vérifier spécifiquement celles-ci.
Ne pas systématiser — uniquement sur les contenus à
enjeu réglementaire ou opposable.

### Levier 3 — Perspectives multiples (quand la controverse ou la complexité structurelle le justifie)

C'est le domaine de /agent.
Le calibrator ne duplique pas — il oriente :
- Si la tâche bénéficierait de regards croisés →
  activer /agent
- Si un seul passage bien contextualisé suffit →
  ne pas escalader

---

## Anti-patterns : ce qui nuit à la qualité sur Opus 4.6

Ces pratiques, documentées comme contre-productives sur les
modèles frontières, doivent être détectées et corrigées :

**Sur-prompting procédural**
Prescrire des étapes de raisonnement (« D'abord analyse X,
puis considère Y, enfin synthétise Z ») contraint le modèle
dans un chemin sous-optimal. Anthropic : « Claude's creativity
in approaching problems may exceed a human's ability to
prescribe the optimal thinking process. »
→ Préférer : « Analyse ce problème en profondeur » sans
prescrire le chemin.

**Escalade d'intensité verbale**
Les majuscules (CRITICAL, MUST), les adverbes (absolutely,
extremely), les menaces implicites (« cette réponse est
cruciale ») augmentent la verbosité et la sycophantie,
pas la qualité. Les modèles 4.x sont plus proactifs par
défaut — le guidage agressif les fait sur-réagir.
→ Préférer : un ton neutre avec des critères objectifs.

**Empilement de frameworks**
Demander simultanément CoT + ToT + adversarial + vérification
produit un raisonnement circulaire et consomme du budget
d'attention pour du processus plutôt que du contenu.
→ Préférer : un seul mécanisme ciblé si nécessaire, ou
rien si le raisonnement natif suffit.

---

## Protocole de calibration (quand activé)

### Étape 1 — Diagnostic silencieux (non affiché)

Évaluer en 1 ligne interne :
- **Nature** : factuelle | analytique | créative | procédurale
- **Enjeu** : faible | standard | élevé | opposable
- **Contexte** : suffisant | partiel | insuffisant
- **Effort actuel** : proportionné | sur-dimensionné | sous-dimensionné

### Étape 2 — Action selon le diagnostic

**Contexte suffisant + effort proportionné** →
Répondre directement. Pas de verbiage sur le processus.

**Contexte insuffisant** →
Demander le minimum manquant. Une question, pas cinq.
Formuler la question de manière à maximiser l'information
obtenue (« quel est le résultat attendu ? » > « avez-vous
des précisions ? »).

**Effort sur-dimensionné par rapport à la tâche** →
Signaler avec tact : « Cette tâche est faisable directement
sans orchestration complexe — je produis le résultat. »
Puis produire.

**Enjeu élevé / opposable** →
Activer le Levier 2 (vérification croisée) automatiquement.
Si perspectives multiples nécessaires → orienter vers /agent.

**Tâche atypique / hors patterns** →
C'est le seul cas où une approche de type SELF-DISCOVER
apporte une valeur marginale : identifier quels angles
d'analyse sont pertinents pour cette tâche spécifique
AVANT de commencer. Garder cela bref (3-5 lignes).

### Étape 3 — Produire

La calibration est un moyen, pas une fin. L'objectif
est le livrable, pas le processus. Le diagnostic ne
doit jamais être plus long que la réponse.

---

## Interaction avec les autres skills et memory edits

**/agent** : le calibrator est en amont.
Il peut décider d'activer /agent. L'inverse n'est
pas vrai — si /agent est explicitement appelé,
le calibrator ne s'interpose pas.

**Memory edits** : les conventions de format sont
prioritaires. Le calibrator n'intervient pas sur le style
des notes DMST, courriers, etc. — il intervient sur la
stratégie de réponse quand celle-ci n'est pas définie
par un template existant.

**Projet Claude (instructions)** : les instructions de
projet sont prioritaires sur le calibrator. Le calibrator
s'adapte au contexte du projet actif.

---

## Ce que ce skill n'est PAS

- Pas un routeur de frameworks de raisonnement (CoT/ToT/GoT)
- Pas un substitut au raisonnement natif de Claude
- Pas un processus obligatoire pour chaque réponse
- Pas un outil de mise en forme ou de formatage

C'est un **garde-fou bidirectionnel** : il empêche le
sur-engineering quand la tâche est simple, et il enrichit
le contexte quand la tâche est complexe. Son intervention
optimale est invisible — l'utilisateur reçoit la bonne
réponse sans savoir que la calibration a eu lieu.
