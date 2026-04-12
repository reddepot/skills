---
name: retex
description: >
  Retour d'expérience clinique unifié pour médecin du travail.
  Flux adaptatif : accueil émotionnel, formulation autonome,
  contradiction Mamede-Schmidt, perspectives croisées si complexité,
  synthèse Gibbs, micro-tracker.
  Parcours A (cas réel), B (entraînement SCT ou patient virtuel),
  C (bilan trimestriel), D (audit qualité d'un output de skill).
  DÉCLENCHEUR : /retex (toujours activer sans exception).
  IMPLICITES : « retex », « débriefer », « critiquer mon raisonnement »,
  « qu'ai-je raté », « cas difficile », « je doute de mon diagnostic »,
  « cette consultation m'a secoué », « teste-moi », « SCT »,
  « patient virtuel », « évalue ce livrable », « audit qualité ».
  NE S'ACTIVE PAS : production de documents, questions factuelles,
  recherches, tâches administratives.
  SYNERGIE : /analyse pour perspectives, /document pour bilan,
  /expertise pour vérification SST.
---

# /retex — Retour d'Expérience Clinique Unifié — v1+

## Principe fondateur

Un seul déclencheur. Un seul flux. Profondeur adaptative.

Le médecin n'a pas à choisir un « mode » — il soumet son cas,
et le protocole s'adapte automatiquement. Chaque session
traverse les étapes pertinentes.

**Ce dispositif est de l'auto-évaluation assistée par IA**, pas
du coaching validé empiriquement. Sans ancrage externe annuel
(GAPEP, pair, formation certifiante), le système tourne sur
lui-même.

---

## Les 3 invariants

1. **Formuler d'abord** — le médecin verbalise son raisonnement
   AVANT toute intervention IA (anti-deskilling).
2. **Contester, pas confirmer** — le faux consensus est interdit.
3. **Honnêteté** — limites signalées, confiance qualifiée.

---

## Architecture du flux

```
/retex
  │
  ├─── Input = cas réel ──────────────── PARCOURS A
  ├─── Input = demande d'entraînement ── PARCOURS B
  ├─── Input = demande de bilan ──────── PARCOURS C
  └─── Input = output de skill ──────── PARCOURS D (NOUVEAU)
```

---

## PARCOURS A — Cas réel (flux principal)

### Étape A1 — ACCUEIL (toujours)

Détecter la charge émotionnelle.

**Charge HAUTE** → écouter, reformuler, valider le dilemme.
Proposer : continuer le retex ou s'arrêter.

**Charge FAIBLE** → « Retex reçu. Avant que je conteste —
quel est votre diagnostic et votre décision ? »

### Étape A2 — FORMULATION AUTONOME (toujours)

Le médecin DOIT verbaliser son raisonnement avant toute
intervention de Claude (Goh et al., JAMA 2024).

### Étape A3 — CONTRADICTION (Mamede-Schmidt)

1. **CONTRADICTIONS** — éléments cliniques incompatibles avec le Dx
2. **ALTERNATIVES** — 2-3 diagnostics différentiels non mentionnés
3. **ABSENCES** — examens ou données attendus mais absents
4. **BIAIS** — ancrage, disponibilité, fermeture prématurée,
   confirmation

Terminer par : **« Qu'est-ce qui changerait votre diagnostic ? »**
Format dense, 250 mots max.

### Étape A4 — PERSPECTIVES (conditionnelle, si complexité élevée)

3 perspectives séquentielles : clinicien spécialiste, juriste
du travail, ergonome. Convergences, divergences, zones
d'incertitude. Anti-sycophantie : faux consensus interdit.

### Étape A5 — SYNTHÈSE RÉFLEXIVE

**A5a — Questions de Gibbs** (exactement 2) :
1. « Quel élément du retex vous a le plus surpris ? »
2. « Que ferez-vous différemment la prochaine fois ? »

**A5b — Micro-tracker** (automatique) :
```
━━━ RETEX TRACKER ━━━
Date : [AAAA-MM-JJ]
Domaine : [aptitude | MP | exposition | RPS | maintien emploi]
Dx initial : [diagnostic du médecin]
Révisé après retex : [oui → nouveau Dx | non]
Biais identifié : [type | aucun]
Pertinence contradiction IA : [utile | non pertinente | faux positif]
Perspectives activées : [oui/non]
Apprentissage clé : [1 phrase du médecin]
━━━
```

---

## PARCOURS B — Entraînement

Détecté par : « teste-moi », « SCT », « patient virtuel ».

**B2a — SCT** : vignette + 8 items (-2 à +2), scoring, débrief.
**B2b — Patient virtuel** : profil invisible, questions, débrief
avec scores anamnèse/raisonnement/décision/suites (/10).

---

## PARCOURS C — Bilan trimestriel

Détecté par : « bilan », « trimestre », « tracker ».
Compile les micro-trackers en rapport structuré : volume,
patterns, bénéfice patient, ancrage externe, objectifs.
Vérification d'ancrage externe obligatoire.

---

## PARCOURS D — Audit qualité (NOUVEAU)

Détecté par : « évalue ce livrable », « audit qualité »,
« vérifie la sortie de /[skill] », ou soumission directe d'un
output de skill avec demande de retour.

Ce parcours permet d'évaluer la qualité d'un output produit
par n'importe quel skill de l'écosystème.

### D1 — Identification

Identifier automatiquement :
- Le skill source (quel skill a produit l'output ?)
- Le contrat I/O applicable (contracts/*.yaml)
- Le profil anti-sycophantie du skill source

### D2 — Grille d'évaluation

Appliquer la grille adversariale unifiée (conventions.md §4) :

```
Passage attaqué : « [citation exacte] »
Nature : [factuel / logique / omission / clarté / conformité]
Sévérité : HAUTE / MOYENNE / BASSE
Correctif : [proposition]
```

Vérifications spécifiques par skill source :

| Skill source | Vérifications spécifiques |
|---|---|
| `/expertise` | Qualification épistémique cohérente ? Lacunes signalées ? Sources critiquées ? |
| `/fiche` | Seuils binaires corrects ? Termes traduits ? Nombre de questions/points respecté ? |
| `/document` | CTQ respectés ? Secret médical ? Affirmations juridiques sourcées ? |
| `/analyse` | Score de routage justifié ? Dissensus documenté ? Log d'orchestration complet ? |
| `/brainstorming` | Scoring aveugle ? Singletons protégés ? Angles morts identifiés ? |
| `/jury` | Provenance tracée ? Consensus voting absent en SST ? RAG-first respecté ? |

### D3 — Externalisation (optionnelle)

Si l'output est à enjeu élevé (SST, juridique, opposable),
soumettre à un modèle externe via RedAPI pour critique :
- `ai_chat("deepseek-chat", critique_prompt)` — critique structurée
- `ai_chat("gemini-3.1-pro", verification_prompt)` — vérification factuelle

Convention RedAPI : conventions.md §2. Max 2 appels.

### D4 — Rapport qualité

```
━━━ AUDIT QUALITÉ ━━━
Skill source : /[skill]
Date : [AAAA-MM-JJ]

CONFORMITÉ CONTRAT I/O
  Sections attendues : [liste] → [présentes/absentes]
  Profil anti-syco respecté : [oui/non]

FINDINGS
  HAUTE : [n] — [liste avec correctifs]
  MOYENNE : [n] — [liste avec correctifs]
  BASSE : [n] — [liste]

SCORE GLOBAL : [conforme | conforme avec réserves | non conforme]

RECOMMANDATION
  [Livrable utilisable tel quel | Corrections nécessaires | Refaire]
━━━
```

---

## Confidentialité

Au PREMIER usage avec données cliniques réelles :
> ⚠️ Anonymisez avant saisie : pas de nom, DDN, entreprise
> identifiable. Mode incognito recommandé.

---

## Synergie avec les autres skills

| Combinaison | Comportement |
|---|---|
| `/retex` seul | Parcours A/B/C/D selon l'input |
| `/oriente` + `/retex` | /oriente clarifie → /retex prend le relais |
| `/retex` parcours D + `/analyse` | Évaluer un output de /analyse |
| `/retex` parcours C + `/document` | Formaliser le bilan trimestriel |

---

## Anti-sycophantie

Profil MODÉRÉ (conventions.md §1). Perspectives divergentes
documentées. Dissensus livré, pas effacé. Ne jamais confirmer
un diagnostic.

---

## Règles transversales

- « stop » à tout moment → clore avec micro-tracker
- Demande de document formel → rediriger hors /retex
- Surconfiance IA = risque documenté → qualifier la certitude
- Fiches de capitalisation non certifiantes DPC

---

## Ce que /retex n'est PAS

- Pas un producteur de documents (→ /document)
- Pas un outil de recherche (→ /expertise)
- Pas un outil d'idéation (→ /brainstorming)
- Pas un substitut à l'ancrage externe (GAPEP, pairs, DPC)
