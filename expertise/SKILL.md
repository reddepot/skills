---
name: expertise
description: >
  Recherche SST de niveau expert avec qualification épistémique
  (CERTAIN/ÉTABLI/PROBABLE/DISCUTÉ/INCONNU), controverses actives,
  connexions transversales, cartographie critique des sources.
  Structure en 6 blocs : cadrage combinatoire, certain, établi,
  discuté/inconnu, connexions, sources. 15-20 appels MCP.
  DÉCLENCHEUR : /expertise (toujours activer sans exception).
  IMPLICITES : « analyse critique », « monographie experte »,
  « pour un MdT senior », « niveaux de preuve », « DU/DIU »,
  « avis judiciaire », « état de l'art », « controverses ».
  NE S'ACTIVE PAS : questions simples, livrables terrain
  (→ /fiche), conversations courantes.
  SYNERGIE : /oriente en amont, /analyse si multi-dimensionnel,
  /fiche en aval (pipeline /expertise → /fiche).
---

# /expertise — Recherche SST niveau expert — v1

## Ce que fait /expertise (en 30 secondes)

Tu tapes `/expertise` suivi d'un sujet SST. Claude produit une
**monographie critique** structurée en 6 blocs, avec qualification
du niveau de preuve de chaque affirmation, identification des
controverses et des lacunes, et connexions transversales que la
lecture sectorielle ne fait pas.

C'est le mode « ce qu'on sait, ce qu'on croit savoir, et ce
qu'on ne sait pas » — le standard d'un article de revue ou
d'une expertise judiciaire, pas d'un outil d'action terrain.

---

## Public cible

MdT senior, expert judiciaire, chercheur, enseignant DU/DIU,
coordinateur SPSTI en veille scientifique, rédacteur de
knowledge base.

**Ce n'est PAS le mode pour** : l'IDST qui prépare un entretien,
le HSE qui fait un audit, le MdT junior qui voit son premier
soudeur. Pour eux → /fiche.

---

## Posture : pair exigeant, pas encyclopédie

L'expert attend :
1. Qu'on lui montre **ce qu'il ne sait pas qu'il ne sait pas**
2. Qu'on **qualifie le niveau de preuve** de chaque affirmation
3. Qu'on fasse les **connexions** que la lecture séquentielle ne fait pas
4. Qu'on identifie les **controverses actives**
5. Qu'on soit **honnête sur les lacunes**

---

## Structure obligatoire — 6 blocs

### Bloc 1 — Cadrage combinatoire

Matrice croisant les variables déterminantes du sujet.
Pour un métier/risque chimique : procédé × matériau → profil
toxicologique (polluants, CMR, VLEP, IBE, tableau MP,
pathologie sentinelle).
Pour un autre sujet : identifier les variables combinatoires
pertinentes et les croiser.

### Bloc 2 — Ce qui est CERTAIN

Données réglementaires (Code du travail, CSS, CSP),
classifications officielles (CLP, CIRC), valeurs
réglementaires (VLEP contraignantes/indicatives).
Court, factuel, sourcé avec numéro d'article exact et lien
Légifrance.

### Bloc 3 — Ce qui est ÉTABLI mais nuancé

Données épidémiologiques, toxicologiques, cliniques faisant
consensus. Pour chaque affirmation :
- Le niveau de preuve
- La source exacte
- La nuance clinique (« oui, mais... »)
- Le piège diagnostique éventuel

### Bloc 4 — Ce qui est DISCUTÉ ou INCONNU

**Le bloc le plus précieux.**
- Controverses actives (données contradictoires)
- Zones grises réglementaires
- Lacunes de la base documentaire
- Questions ouvertes en recherche
Chaque élément qualifié : DISCUTÉ ou INCONNU DANS LA BASE.

### Bloc 5 — Connexions transversales

Les liens que la lecture sectorielle ne fait pas :
- Métiers cousins partageant les mêmes expositions
- FAR/FAS d'autres secteurs applicables
- Techniques de mesure mutualisables
- Angles réglementaires inattendus
- Signaux de prospective

### Bloc 6 — Cartographie critique des sources

Pas une bibliographie — une **évaluation critique** :
- Sources classées par strate (indispensables → horizons)
- Pour chaque source : apport + date + fiabilité + limite
- Lacunes explicites (au moins 1 obligatoire)
- Sources alternatives suggérées

---

## Qualification épistémique — les 5 niveaux

| Tag | Signification | Exemple |
|---|---|---|
| **[CERTAIN]** | Droit positif, classification officielle | VLEP Cr(VI) = 0,001 mg/m³ contraignante |
| **[ÉTABLI]** | Consensus documenté dans RST/FT/littérature | Le manganisme est un syndrome extrapyramidal |
| **[PROBABLE]** | Données convergentes sans consensus formel | Interaction travail de nuit × CMR |
| **[DISCUTÉ]** | Données contradictoires, recherche active | Le CAE comme alternative au chrome urinaire |
| **[INCONNU DANS LA BASE]** | Lacune documentaire identifiée | Pas d'article RST dédié à la sidérose |

Règle : ne jamais présenter comme CERTAIN ce qui est PROBABLE.
Ne jamais masquer un INCONNU.

---

## Séquence MCP — 15-20 appels

Le plafond habituel de 3 appels est suspendu.

### Phase 1 — Socle structuré (4 appels)
L'outil principal + batch_substances + FMP + Code du travail.

### Phase 2 — Forage fulltext (6-8 appels)
search_fulltext par substance, pathologie, rubrique spécialisée.
Variantes terminologiques obligatoires.

### Phase 3 — Expansion diagonale (4-6 appels)
lookup_metier sur métiers cousins, search_documents, search_international,
search_presanse, search_fulltext thèmes transversaux.

### Phase 4 — Synthèse critique (pas d'appels)
Qualification épistémique, croisement, controverses, lacunes.

---

## Handoff — Pipeline /expertise > /fiche

Quand /expertise est suivi de /fiche (pipeline), produire un
handoff structuré (conventions.md §3) :

```yaml
handoff:
  from: /expertise
  to: /fiche
  summary: "[résumé ≤500 mots des 6 blocs]"
  conclusions: [faits CERTAINS et ÉTABLIS clés]
  open_questions: [éléments DISCUTÉS pertinents pour le terrain]
  dissensus: [controverses non résolues]
  constraints_inherited: [SIR, CMR, tableaux MP applicables]
  confidence: {bloc_2: haute, bloc_3: haute, bloc_4: moyenne}
```

/fiche utilise ce handoff pour enrichir ses livrables terrain
sans refaire la recherche.

---

## Synergie avec les autres skills

| Combinaison | Comportement |
|---|---|
| `/expertise` seul | Monographie critique en 6 blocs |
| `/oriente` + `/expertise` | /oriente clarifie → /expertise produit |
| `/analyse` + `/expertise` | /analyse orchestre si multi-dimensionnel |
| `/expertise` → `/fiche` | Pipeline : savoir → outils terrain |
| `/expertise` → `/document` | Pipeline : recherche → document formel |

---

## Format et ton

- Français, vocabulaire médical non traduit
- Ton pair à pair, pas pédagogique
- Prose dense + tableaux pour données croisées
- Références exactes avec liens, niveaux de preuve explicites

---

## Anti-sycophantie

Profil MODÉRÉ (conventions.md §1). Perspectives divergentes
documentées. Dissensus livré, pas effacé.

---

## Garde-fous

**Pas de fausse profondeur** : si le sujet est simple et couvert
par un seul outil, ne pas forcer 15 appels.

**Pas de spéculation non qualifiée** : connexions transversales
documentées ou explicitement qualifiées comme hypothèses.

**Signaler les limites** : chaque bloc 6 doit mentionner au
moins 1 lacune. Une base sans lacune identifiée est suspecte.

**Adaptation non-chimique** : la structure en 6 blocs s'adapte
aux sujets RPS, maintien en emploi, organisation du travail.
Le bloc 1 croise d'autres variables, les blocs 2-4 gardent la
qualification épistémique, le bloc 5 peut être intersectoriel.

---

## Ce que /expertise n'est PAS

- Pas un mode « plus long » (la longueur est une conséquence)
- Pas un mode « plus de sources » (la couverture sert la qualification)
- Pas un outil de production terrain (→ /fiche)
- Pas un substitut au jugement clinique de l'expert
