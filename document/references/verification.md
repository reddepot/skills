# Protocole de vérification — Phase 4

## Couche 1 — Structurelle (tous modes)

Vérifier :
- [ ] Toutes les sections de la spec sont présentes
- [ ] YAML frontmatter valide et plat
- [ ] Pas de section vide
- [ ] Taille totale < 80 Ko (sinon scinder)
- [ ] Pas de renvoi vers des fichiers absents
- [ ] Headers cohérents (en questions si destination projet Claude)
- [ ] Conformité aux règles de formatting.md respectée

## Couche 2 — Factuelle (standard + critique)

1. Extraire les 5-10 **affirmations pivots** du document :
   - Liens de causalité (exposition → pathologie)
   - Interprétations normatives (article de loi → obligation)
   - Données quantitatives (VLEP, seuils, délais, statistiques)

2. Pour chaque affirmation :
   a. Vérifier via MCP interne (SSTinfo pour réglementaire, MedData pour médical).
   b. Croiser via `ai_search` (Sonar) — prompt :
      « Vérifie cette affirmation : [affirmation]. Sources fiables uniquement. »
   c. Concordance MCP + Sonar → HAUTE confiance.
   d. Divergence → MOYENNE confiance, documenter la divergence.
   e. Aucune source ne confirme → BASSE confiance, signaler dans Limites.

3. Fallback si ai_search échoue : web_search classique ou sources MCP élargies.

**RÈGLE DURE : toute affirmation juridique (article de loi, JP, obligation)
non validée par un appel outil explicite (SSTinfo/Légifrance) doit être
supprimée du document final ou marquée [NON VÉRIFIÉ — confiance BASSE].**

## Couche 3 — Complétude (standard + critique)

- Le document couvre-t-il tous les aspects identifiés dans les sources ?
- Vérifier par recherche ciblée qu'aucune source d'autorité majeure
  (article récent, JP de principe, méta-analyse, recommandation HAS)
  contredisant le raisonnement n'a été omise.
- Les contre-arguments ou nuances des sources sont-ils reflétés ?

## Couche 4 — Scénarios (critique uniquement)

Définir 5 situations concrètes d'utilisation du document.
Pour chaque scénario :
- Le document guide-t-il correctement la décision ?
- Y a-t-il un cas où le document induirait en erreur ?
- Les cas limites sont-ils couverts ?

Exemples de scénarios SST :
1. Salarié conteste l'avis d'inaptitude devant le CPH
2. Employeur refuse l'aménagement proposé
3. CPAM demande des justificatifs pour reconnaissance MP
4. Inspection du travail contrôle la procédure
5. Salarié en AT avec comorbidité préexistante

## Couche 5 — Pre-mortem (critique uniquement)

Répondre à : « Si ce document échouait dans son objectif, la raison
la plus probable serait... »

Identifier les 3 scénarios d'échec les plus probables.
Pour chacun : le document y répond-il ? Si non → corriger ou documenter.

## Score de confiance

Attribué par section selon :
- **Ancienneté des sources** (< 5 ans = favorable)
- **Consensus des sources** (concordance MCP + externe)
- **Cohérence interne** (pas de contradiction avec d'autres sections)
- **Traçabilité** (chaque affirmation liée à un appel outil réussi)

| Score | Signification |
|-------|--------------|
| HAUTE | Sources concordantes, récentes, traçables |
| MOYENNE | Divergence mineure ou source unique non croisée |
| BASSE | Aucune source primaire, ou contradiction non résolue |

## Sortie attendue

```
═══ VÉRIFICATION ═══

Section 1 : [titre] → HAUTE confiance
  Structurelle : OK
  Factuelle : 3/3 affirmations pivots confirmées (SSTinfo + Sonar)
  Traçabilité : tous les articles vérifiés par appel Légifrance

Section 2 : [titre] → MOYENNE confiance
  Structurelle : OK
  Factuelle : 2/3 confirmées, 1 divergence (art. R.4624-XX)
  Note : SSTinfo donne version 2022, Sonar cite version 2024 — à vérifier

Section 3 : [titre] → HAUTE confiance
  (...)

Pre-mortem : risque principal = [description]
  → Couvert par section 4, paragraphe 2. OK.
```
