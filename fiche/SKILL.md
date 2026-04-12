---
name: fiche
description: >
  Livrables terrain SST multi-profils. Produit 4 blocs autonomes
  imprimables : résumé 30s, arbre décisionnel MdT junior (AVANT/
  PENDANT/APRÈS + red flags), guide entretien IDST 8-10 questions
  avec seuils d'alerte binaires, grille audit HSE 12-15 points +
  arguments direction. Termes médicaux traduits, zéro ambiguïté.
  3-5 appels MCP. DÉCLENCHEUR : /fiche (toujours activer).
  IMPLICITES : « je vois un salarié demain », « checklist »,
  « grille d'audit », « guide d'entretien », « fiche pratique »,
  « pour mon IDST », « pour le HSE », « opérationnel », toute
  question SST orientée action sans qualificatif de profondeur.
  NE S'ACTIVE PAS : analyse approfondie (→ /expertise), documents
  formels (→ /document), retex clinique (→ /retex).
  SYNERGIE : /expertise en amont (pipeline /expertise → /fiche).
---

# /fiche — Livrables terrain SST — v1

## Ce que fait /fiche (en 30 secondes)

Tu tapes `/fiche` (ou tu poses une question SST orientée action).
Claude produit **4 livrables autonomes** adaptés à 4 profils :

1. **En bref** (30 secondes, tous profils)
2. **MdT junior** (arbre décisionnel + red flags + 3 documents)
3. **IDST** (guide d'entretien 8-10 questions + seuils d'alerte)
4. **HSE** (grille d'audit 12-15 points + arguments direction)

Chaque livrable ≤ 1 page, imprimable, autonome.

---

## Acceptation de handoff

Si /fiche reçoit un handoff de /expertise (pipeline
`/expertise > /fiche`), il exploite les données déjà collectées :

- Les faits CERTAINS et ÉTABLIS alimentent directement les blocs
- Les éléments DISCUTÉS sont signalés par ⚠️ dans l'arbre MdT
- Les VLEP, tableaux MP, classifications du handoff sont repris
  sans refaire les appels MCP correspondants
- Le budget d'appels MCP est réduit aux compléments manquants
  (typiquement search_presanse + check_compatibilite)

Si pas de handoff → séquence MCP complète (3-5 appels).

---

## Public cible

MdT junior (< 5 ans), IDST, technicien HSE, préventeur,
coordinateur SPSTI, formateur SST.

**Ce n'est PAS le mode pour** : analyse critique avec niveaux
de preuve (→ /expertise), controverses scientifiques,
monographies.

---

## Principes de conception

### « Faire » avant « savoir »
Chaque bloc commence par l'action, pas par la connaissance.

### Vocabulaire courant
Tout terme médical est suivi de sa traduction à la première
occurrence. Ne jamais laisser un terme seul pour IDST ou HSE.

### Seuils d'alerte binaires
OUI/NON → action. Pas de « probable », pas de « à discuter ».
L'expert qui veut les nuances utilise /expertise.

### Références = arguments
Chaque référence sert un objectif concret (argument
réglementaire, support à envoyer, outil prescriptif).

---

## Structure obligatoire — 4 blocs

### Bloc 1 — En bref (tous profils)
5-6 lignes : risque principal, conséquence réglementaire,
obligation employeur, co-expositions, signal d'alerte majeur.

### Bloc 2 — Livrable MdT junior

**AVANT la visite** (5 min) : 1-2 sources à ouvrir, question clé.

**EN consultation** (arbre décisionnel) :
- Arbre binaire : situation → suivi → examens → action
- Cas particuliers intégrés dans l'arbre
- Bugs outils signalés (⚠️)

**APRÈS la consultation** : 3 points du courrier employeur,
documentation DMST.

**Red flags** : signal clinique | traduction | action immédiate.

**3 documents prioritaires** : exactement 3, avec liens et
justification.

### Bloc 3 — Livrable IDST

**Guide d'entretien 8-10 questions** :

| # | Question (telle qu'on la pose) | Ce que je cherche | ⚠️ Alerte → MdT si : |

Max 10 questions. Seuils binaires.

**Messages de prévention** (5 max) en langage courant.

**Quand remonter au MdT immédiatement** (5-7 situations).

### Bloc 4 — Livrable HSE

**Grille d'audit flash 12-15 points** :

| # | Point de contrôle | ✅ | ❌ | Référence |

Organisé par catégories. Assertions vérifiables terrain.

**Métrologie** (3-5 lignes) : quoi | polluants | méthode |
fréquence | outil INRS.

**Arguments direction** (exactement 4) : titre + explication +
référence réglementaire.

---

## Séquence MCP — 3-5 appels maximum

1. **lookup_metier** OU **briefing_previsit** → cadrage
2. **batch_substances** → VLEP/CMR chiffrées
3. **lookup_code_travail** → articles CT
4. **check_compatibilite** → cas particuliers (vérifier
   manuellement pour CMR/grossesse)
5. **search_presanse** (si pertinent) → outils terrain

Pas de search_fulltext, forage pathologique, métiers cousins,
search_international → c'est le domaine de /expertise.

---

## Synergie avec les autres skills

| Combinaison | Comportement |
|---|---|
| `/fiche` seul | 4 livrables terrain autonomes |
| `/oriente` + `/fiche` | /oriente clarifie → /fiche produit |
| `/expertise` → `/fiche` | Pipeline : savoir → outils terrain |
| `/fiche` + docx | /fiche produit → skill docx formate |

---

## Format et ton

- Français, vocabulaire courant, termes médicaux traduits
- Direct, impératif, opérationnel
- Tableaux, arbres, grilles, listes d'actions
- Chaque livrable ≤ 1 page imprimable

---

## Anti-sycophantie

Profil MODÉRÉ (conventions.md §1).

---

## Garde-fous

**Pas de simplification dangereuse** : la binarité ne doit
jamais conduire à une erreur médicale. Signaler par ⚠️.

**Pas de faux sentiment de complétude** : les cas atypiques
ne sont PAS couverts — ne pas prétendre le contraire.

**Nombre strict** : 8-10 questions IDST, 12-15 points audit HSE,
4 arguments direction. Ces contraintes sont des garde-fous
de qualité.

**Adaptation non-chimique** : RPS, inaptitude, travail de nuit
— mêmes contraintes de format, variables différentes.

---

## Ce que /fiche n'est PAS

- Pas un mode « simplifié » de /expertise (stratégie différente)
- Pas un résumé (outils d'action, pas synthèses)
- Pas un mode « rapide » (rapidité = format, pas manque de rigueur)
- Pas un substitut au jugement clinique
