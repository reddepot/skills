---
name: standard
description: >
  Livrables terrain SST multi-profils. Produit 4 blocs autonomes
  imprimables : résumé 30s, arbre décisionnel MdT junior (AVANT/
  PENDANT/APRÈS + red flags), guide entretien IDST 8-10 questions
  avec seuils d'alerte binaires, grille audit HSE 12-15 points +
  arguments direction. Termes médicaux traduits, zéro ambiguïté.
  3-5 appels MCP. DÉCLENCHEUR : /standard (toujours activer).
  IMPLICITES : « je vois un salarié demain », « checklist »,
  « grille d'audit », « guide d'entretien », « fiche pratique »,
  « pour mon IDST », « pour le HSE », « opérationnel », toute
  question SST orientée action sans qualificatif de profondeur.
  NE S'ACTIVE PAS : analyse approfondie (→ /expert), documents
  formels (→ /document), retex clinique (→ /retex).
  SYNERGIE : /expert en amont (pipeline /expert → /standard).
---

# /standard — Livrables terrain SST — v1

## Ce que fait /standard (en 30 secondes)

Tu tapes `/standard` (ou tu poses une question SST orientée
action sans qualificatif de profondeur). Claude produit
**4 livrables autonomes** adaptés à 4 profils :

1. **En bref** (30 secondes, tous profils)
2. **MdT junior** (arbre décisionnel + red flags + 3 documents)
3. **IDST** (guide d'entretien 8-10 questions + seuils d'alerte)
4. **HSE** (grille d'audit 12-15 points + arguments direction)

Chaque livrable ≤ 1 page, imprimable, autonome. L'IDST n'a pas
besoin de lire le bloc MdT. Le HSE n'a pas besoin de lire le
bloc IDST. Chacun trouve son outil directement.

---

## Public cible

MdT junior (< 5 ans), IDST, technicien HSE, préventeur,
coordinateur SPSTI en production de supports, formateur SST
en module terrain.

**Ce n'est PAS le mode pour** : l'analyse critique avec
niveaux de preuve (→ /expert), les controverses scientifiques,
les connexions intersectorielles, les monographies.

---

## Principes de conception

### « Faire » avant « savoir »

Chaque bloc commence par l'action, pas par la connaissance.
Le contenu scientifique est présent mais au service de la
décision, pas de la compréhension. L'IDST n'a pas besoin
de savoir POURQUOI le chrome est cancérogène — elle a besoin
de savoir QUAND remonter au MdT.

### Vocabulaire courant

Tout terme médical est suivi de sa traduction entre
parenthèses à la première occurrence :

- Manganisme → « atteinte neurologique par le manganèse
  (manganisme) »
- Kératoconjonctivite → « brûlure des yeux par les UV
  (kératoconjonctivite) »
- Sidérose → « dépôt de fer dans les poumons (sidérose) »
- Syndrome extrapyramidal → « atteinte des noyaux gris
  centraux du cerveau (syndrome extrapyramidal) »

Ne jamais laisser un terme médical seul sans traduction
quand le destinataire est IDST ou HSE.

### Seuils d'alerte binaires

Pas de « probable », pas de « à discuter », pas de « selon
le contexte ». Les seuils sont OUI/NON → action.

- « Si le salarié tousse chroniquement → remonter au MdT »
- « Si pas d'aspiration à la source → non conforme »
- « Si inox → SIR obligatoire »

La binarité est un choix de conception, pas une erreur de
simplification. L'expert qui veut les nuances utilise /expert.

### Références = arguments

Les sources ne sont pas là pour documenter — elles sont là
pour **argumenter**. Chaque référence sert un objectif :
- L'article CT sert d'argument réglementaire face à l'employeur
- La brochure INRS sert de support à envoyer au HSE
- Le guide Présanse sert d'outil prescriptif au MdT

Ne pas lister des références « pour information ». Chaque lien
doit répondre à « à quoi ça sert concrètement ? ».

---

## Structure obligatoire — 4 blocs

### Bloc 1 — En bref (tous profils)

5-6 lignes. Ce qu'il faut retenir. Pas de nuance. Le
non-spécialiste comprend, l'expert ne conteste pas.

Contenu obligatoire :
- Le risque principal en 1 phrase
- La conséquence réglementaire en 1 phrase (SIR, CMR, etc.)
- L'obligation employeur en 1 phrase
- Les co-expositions à ne pas oublier en 1 phrase
- Le signal d'alerte majeur en 1 phrase

### Bloc 2 — Livrable MdT junior

#### Séquencement temporel obligatoire

Le bloc est structuré en 3 temps :

**AVANT la visite** (5 min de préparation) :
- Les 1-2 sources à ouvrir
- La question clé à se poser avant de commencer

**EN consultation** (l'arbre décisionnel) :
- Arbre binaire : situation → suivi → examens → action
- Pour chaque branche : les examens à prescrire, listés
- Les cas particuliers (grossesse, intérim, nuit) intégrés
  dans l'arbre, pas dans un bloc séparé
- Les bugs ou limites d'outils connus signalés dans l'arbre
  (ex : « ⚠️ check_compatibilite NE DÉTECTE PAS cette
  interdiction — vérifier manuellement »)

**APRÈS la consultation** :
- Les 3 points du courrier à l'employeur
- La documentation DMST à compléter

#### Red flags

Tableau à 3 colonnes : signal clinique | ce que c'est
(en langage courant) | action immédiate.

Chaque terme médical traduit. Chaque action est un verbe
à l'impératif (« prescrire », « adresser à », « retirer
du poste »).

#### Les 3 documents prioritaires

Exactement 3. Pas 5, pas 10. Les 3 qu'un MdT junior doit
lire en priorité pour ce sujet, avec liens et 1 ligne
d'explication de pourquoi chacun est utile.

### Bloc 3 — Livrable IDST

#### Guide d'entretien : 8-10 questions

Tableau à 4 colonnes :

| # | Question (formulée telle qu'on la pose au salarié) | Ce que je cherche | ⚠️ Alerte → MdT si : |

Les questions sont en langage courant, directement
utilisables. Le seuil d'alerte est binaire (oui/non).

Règles :
- Maximum 10 questions (au-delà, l'entretien devient
  un interrogatoire)
- La colonne « Ce que je cherche » est en 1 ligne maximum
- La colonne « Alerte » commence toujours par une condition
  simple (« Si oui → MdT », « Si > X → MdT »)

#### Messages de prévention (5 maximum)

Les messages à transmettre au salarié pendant l'entretien.
En langage courant, formulés comme on les dirait à l'oral.
Pas de jargon, pas de référence réglementaire.

#### Quand remonter au MdT immédiatement

Liste courte (5-7 situations) des cas où l'IDST doit appeler
le MdT le jour même sans attendre la prochaine visite.
Formulés comme des conditions simples.

### Bloc 4 — Livrable HSE

#### Grille d'audit flash (12-15 points)

Tableau à 5 colonnes :

| # | Point de contrôle | ✅ | ❌ | Référence |

Organisé par catégories (évaluation, protection collective,
protection individuelle, hygiène/organisation). Chaque
point est formulé comme une assertion vérifiable sur le
terrain (« Aspiration à la source présente sur chaque
poste fixe »).

La colonne Référence contient : le numéro d'article CT
avec lien Légifrance OU la référence INRS avec lien.
C'est l'argument réglementaire du HSE.

#### Métrologie

Tableau à 5 colonnes : quoi mesurer | polluants | méthode |
fréquence | outil INRS.

Court (3-5 lignes). Uniquement les mesures que le HSE
doit faire ou faire faire.

#### Arguments pour la direction (4 maximum)

Exactement 4 arguments prêts à être prononcés face à un
directeur qui dit « c'est trop cher ». Chaque argument
a un titre court + 2-3 lignes d'explication + la référence
réglementaire qui fait levier.

Types d'arguments efficaces :
- Risque d'arrêt d'activité par l'inspection du travail
- Risque de faute inexcusable
- Caractère contraignant (vs indicatif) de la VLEP
- Supports gratuits disponibles (affiches, vidéos INRS)

---

## Séquence MCP — 3-5 appels maximum

/standard privilégie l'efficience. Le plafond de 3-5 appels
est strict. La valeur vient du formatage et de la segmentation
par profil, pas du nombre de sources interrogées.

### Séquence type

1. **lookup_metier(metier)** OU **briefing_previsit(secteur)**
   → cadrage risques + docs INRS (NE PAS chaîner d'autres
   outils ensuite — les données croisées sont incluses)

2. **batch_substances(composants majeurs)**
   → VLEP/CMR chiffrées pour la grille HSE et l'arbre MdT

3. **lookup_code_travail(thème pertinent)**
   → articles CT pour les arguments réglementaires du HSE
   et le cadre SIR/CMR du MdT

4. **check_compatibilite(poste, pathologies, statut)**
   → cas particuliers (grossesse, handicap, intérim)
   → TOUJOURS vérifier manuellement les résultats pour
   les cas CMR/grossesse (bug connu)

5. **search_presanse(query, section="im")** (si pertinent)
   → outils Présanse terrain (guides de poche, etc.)

### Ce qu'on NE fait PAS en /standard

- Pas de search_fulltext (→ /expert)
- Pas de forage par pathologie dans les fiches toxico (→ /expert)
- Pas de métiers cousins ni de FAR/FAS croisées (→ /expert)
- Pas de search_international sauf si demandé (→ /expert)
- Pas de qualification épistémique (→ /expert)

---

## Format et ton

- **Langue** : français
- **Vocabulaire** : courant, termes médicaux TOUJOURS traduits
- **Ton** : direct, impératif, opérationnel
- **Format** : tableaux, arbres, grilles, listes d'actions.
  Pas de prose continue sauf dans le bloc « En bref ».
- **Longueur** : chaque livrable ≤ 1 page imprimable
- **Pas de** : nuances épistémiques, controverses, prose dense,
  vocabulaire médical non traduit, références « pour info »
- **Toujours** : seuils binaires, actions à l'impératif,
  références comme arguments, termes traduits

---

## Interaction avec les autres skills

| Combinaison | Comportement |
|---|---|
| `/standard` seul | 4 livrables terrain autonomes |
| `/sens` + `/standard` | /sens clarifie le besoin → /standard produit les livrables |
| `/expert` → `/standard` | Pipeline production : /expert produit le savoir, /standard le transforme en outils |
| `/standard` + `/xerox` | /standard produit le contenu → /xerox le formate en DOCX CERFA |

L'enchaînement `/expert` → `/standard` est le pipeline de
production de contenu de santeautravail.fr.

---

## Garde-fous

**Pas de simplification dangereuse** : la binarité des seuils
ne doit jamais conduire à une erreur médicale. Les cas où
la simplification serait dangereuse doivent être signalés
par un ⚠️ (ex : bug check_compatibilite / grossesse CMR).

**Pas de faux sentiment de complétude** : les 4 livrables
couvrent le cas standard. Les cas atypiques (soudeur
indépendant, soudage en milieu nucléaire, cobotique)
ne sont PAS couverts — ne pas prétendre le contraire.
Signaler les limites en fin de réponse si le sujet s'y prête.

**Héritage contextuel** : le skill hérite des contraintes
du projet actif. Les instructions de routing (ne pas chaîner,
exploiter le contenu, liens obligatoires) s'appliquent
intégralement.

**Nombre de questions IDST** : strictement 8-10. En dessous,
le repérage est insuffisant. Au-dessus, l'entretien devient
un interrogatoire et le salarié se ferme.

**Nombre de points d'audit HSE** : strictement 12-15.
En dessous, des non-conformités passent. Au-dessus, l'audit
n'est plus « flash » (>15 min) et ne sera pas utilisé.

**Nombre d'arguments direction** : strictement 4. Au-delà,
la dilution affaiblit le message. Moins, le HSE manque
d'alternatives si un argument ne porte pas.

---

## Adaptation aux sujets non-chimiques

Pour les sujets sans dimension chimique (RPS, maintien en
emploi, travail de nuit, harcèlement) :

- **Bloc 1 (En bref)** : même format, le risque principal
  change (ex : « Le travail de nuit est classé cancérogène
  probable par le CIRC »)
- **Bloc 2 (MdT)** : l'arbre porte sur les situations
  cliniques du sujet (ex : pour l'inaptitude : contestation
  oui/non → procédure → délais)
- **Bloc 3 (IDST)** : les questions d'entretien portent sur
  les symptômes et les conditions de travail du sujet
  (ex : RPS → « Avez-vous du mal à dormir à cause du
  travail ? »)
- **Bloc 4 (HSE)** : la grille d'audit porte sur les
  obligations organisationnelles (ex : RPS → « Le DUERP
  contient-il un volet RPS ? ») ; les arguments direction
  portent sur le coût de l'absentéisme et du turnover

Les contraintes de format (nombre de questions, nombre de
points d'audit, nombre d'arguments) sont les mêmes quel
que soit le sujet.

---

## Ce que /standard n'est PAS

- Pas un mode « simplifié » de /expert (c'est une stratégie
  différente, pas une version appauvrie)
- Pas un résumé (il produit des outils d'action, pas des
  synthèses de connaissance)
- Pas un mode « rapide » (la rapidité vient du format,
  pas d'un manque de rigueur)
- Pas un substitut au jugement clinique (les arbres
  décisionnels aident à la décision, ils ne la remplacent pas)
- Pas un outil de formation avancée (→ /expert pour le DPC,
  les DIU, les conférences)
