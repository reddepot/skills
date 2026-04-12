# Protocole adversarial — Phase 3 & 5

Voir aussi conventions.md §4 pour le protocole unifié.

## Personas SST
| Juriste/DRH employeur | Failles exploitables pour contester un avis |
| Inspecteur du travail/DREETS | Conformité réglementaire, traçabilité |
| Médecin-conseil CPAM | Lien professionnel, délais, causalité |
| Salarié non-expert | Compréhension sans jargon |
| Contrôleur CARSAT | Cohérence prévention/sinistralité |
| Ingénieur HSE employeur | Faisabilité des préconisations |

## Personas juridique
| Avocat adverse | Failles argumentation/preuve |
| Magistrat/Assesseur | Rigueur sources et logique |
| Expert technique | Affirmations de fond |
| Lecteur profane | Clarté pour non-juriste |

## Personas clinique
| Spécialiste | Précision médicale |
| Généraliste/MdT junior | Applicabilité pratique |
| Patient/famille | Compréhensibilité |
| Épidémiologiste | Niveaux de preuve, causalité |

Sélectionner 3-4 personas pertinents selon le cas.

## Prompt type pour appels externes
```
Tu es [persona]. Voici un document et ses CTQ.
Critique impitoyablement. Pour chaque faille :
- Cite le passage exact
- Nature (factuel/logique/omission/clarté/conformité)
- Sévérité (HAUTE/MOYENNE/BASSE)
- Correctif

Document : [texte]
CTQ : [checklist]
```
Max 2 appels. Si échec → critique interne + noter dans Limites.

## Exemple de sortie
```
═══ STRESS-TEST — 4 voix ═══
Voix 1 — Juriste employeur (Claude) :
  Passage : « Le MdT peut prescrire des examens »
  Faille : factuel — préconise, pas prescrit
  Sévérité : HAUTE → Corriger
Voix 2 — DeepSeek (externe) :
  Passage : « Inaptitude après une seule visite »
  Faille : omission — exception danger immédiat
  Sévérité : MOYENNE → Corriger
Bilan : 1 HAUTE, 1 MOYENNE corrigées.
```
