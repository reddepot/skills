# Protocole adversarial — Stress-test Phase 3 & 5

## Principe

Critique structurée par voix indépendantes. Pas de débat simulé.
En standard : 3-4 personas Claude séquentielles.
En critique : 2 personas Claude + 1-2 modèles externes (ai_chat).
Total toujours 3-4 voix.

**Déclenchement :**
- Toujours en mode critique.
- En mode standard : si le document est à visée contentieuse, contradictoire,
  ou opposable à un tiers.

## Banque de personas par domaine

### SST / Médecine du travail
| Persona | Angle d'attaque |
|---------|----------------|
| Juriste / DRH employeur | Cherche les failles exploitables pour contester un avis |
| Inspecteur du travail / DREETS | Vérifie la conformité réglementaire et la traçabilité |
| Médecin-conseil CPAM | Challenge le lien professionnel, les délais, la causalité |
| Salarié non-expert | Teste la compréhension sans jargon |
| Contrôleur CARSAT | Vérifie la cohérence prévention / sinistralité |
| Ingénieur HSE employeur | Challenge les préconisations techniques (faisabilité, coût) |

Sélectionner 3-4 personas pertinents selon le cas. Pas tous systématiquement.

### Juridique / opposable
| Persona | Angle d'attaque |
|---------|----------------|
| Avocat adverse | Cherche les failles d'argumentation et de preuve |
| Magistrat / Assesseur prud'homal | Vérifie la rigueur des sources et la logique |
| Expert technique | Challenge les affirmations de fond |
| Lecteur profane | Teste la clarté pour un non-juriste |

### Clinique / médical
| Persona | Angle d'attaque |
|---------|----------------|
| Médecin spécialiste | Challenge la précision médicale |
| Médecin généraliste / MdT junior | Teste l'applicabilité en pratique courante |
| Patient / famille | Vérifie la compréhensibilité |
| Épidémiologiste | Challenge les niveaux de preuve et la causalité |

## Grille de critique (obligatoire pour chaque voix)

```
Passage attaqué : « [citation exacte du document] »
Nature de la faille : [factuel / logique / omission / clarté / conformité]
Sévérité : HAUTE / MOYENNE / BASSE
Correctif proposé : [formulation alternative ou ajout]
```

## Règles

1. Chaque critique DOIT citer le passage exact — pas de critique vague.
2. Classer par sévérité. Corriger HAUTE et MOYENNE obligatoirement.
3. BASSE = documenter, corriger si facile.
4. Rejet d'une critique = motivation obligatoire.
5. Pas de consensus par vote — chaque voix est indépendante.
6. Chercher aussi les biais systémiques du skill (excès de prudence
   procédurale au détriment de l'analyse clinique fine, par exemple).

## Appels externes (critique uniquement)

Prompt type pour ai_chat :

```
Tu es [persona]. Voici un document destiné à [contexte] et ses critères
de qualité (CTQ). Critique-le impitoyablement. Pour chaque faille :
- Cite le passage exact
- Nomme la nature (factuel/logique/omission/clarté/conformité)
- Donne la sévérité (HAUTE/MOYENNE/BASSE)
- Propose un correctif

Document :
[texte complet du brouillon]

CTQ applicables :
[checklist sélectionnée]
```

Max 2 appels. Si échec (timeout, erreur, non-sens) → critique interne
seule + noter dans la section Limites.
Claude analyse la réponse externe et décide quoi intégrer — ne recopie pas.

## Exemple de sortie

```
═══ STRESS-TEST — 4 voix ═══

Voix 1 — Juriste employeur (Claude) :
  Passage : « Le médecin du travail peut prescrire des examens »
  Faille : factuel — le MdT ne prescrit pas, il préconise/recommande
  Sévérité : HAUTE
  → Corriger : remplacer « prescrire » par « préconiser »

Voix 2 — Inspecteur du travail (Claude) :
  Passage : « conformément à l'article R.4624-31 »
  Faille : factuel — l'article a été renuméroté post-réforme 2021
  Sévérité : HAUTE
  → Corriger : vérifier via SSTinfo et mettre à jour

Voix 3 — DeepSeek (externe) :
  Passage : « L'inaptitude peut être prononcée après une seule visite »
  Faille : omission — ne mentionne pas l'exception du danger immédiat
  Sévérité : MOYENNE
  → Corriger : ajouter la mention de l'article L.4624-4

Voix 4 — Salarié non-expert (Claude) :
  Passage : « aménagement de poste au sens de l'article L.4624-6 »
  Faille : clarté — incompréhensible sans connaître l'article
  Sévérité : BASSE
  → Corriger : ajouter une parenthèse explicative

Bilan : 2 HAUTE corrigées, 1 MOYENNE corrigée, 1 BASSE documentée.
```
