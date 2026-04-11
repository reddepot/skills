# Règles de format — Livraison

## Structure Markdown

- YAML frontmatter plat (metadata uniquement) :
  ```yaml
  ---
  title: Titre du document
  type: avis | courrier | rapport | fiche | référentiel
  date: YYYY-MM-DD
  author: Dr [Nom] — Médecin du travail
  domain: SST | juridique | clinique | général
  confidence: haute | moyenne | mixte
  version: v1.0
  ---
  ```
- Corps en Markdown standard
- Headers en questions si destination = projet Claude (optimisation RAG)
- Headers classiques (## Titre) si destination = lecture humaine directe

## Résumé analytique

Pour les documents > 10 000 tokens : inclure un résumé analytique (~300 mots)
en tête de document, synthétisant :
- La question posée
- La méthode suivie
- La conclusion principale
- Les incertitudes majeures

## Citations et sources — formats par type

### Textes réglementaires
`[Art. L.4624-4 C. trav.]` ou `[Art. R.4127-28 CSP]`
Avec URL Légifrance si disponible.

### Jurisprudence
`[Cass. soc., 29 nov. 2023, n° 22-12.345]`
Avec URL Judilibre si disponible.

### Documents INRS
`[INRS ED 6294 — Titre abrégé]` avec URL.

### Articles médicaux
`[Auteur et al., Année, Journal — DOI ou PMID]`

### Autres sources
`[Source: Titre — URL]`

Pas de citation = pas d'affirmation factuelle.
Si pas de source trouvée → marquer `[Source non vérifiée — confiance BASSE]`.

## Contraintes de taille

| Destination | Limite | Action si dépassement |
|-------------|--------|----------------------|
| Projet Claude (Knowledge Base) | < 80 Ko | Scinder : principal + annexe |
| Chat direct | < 15 000 tokens | Résumer ou livrer en sections |
| Word/PDF | Pas de limite dure | Structurer avec TdM si > 10 pages |

## Anonymisation — Privacy by design

Appliquer **dès la phase 1** (rédaction), pas à la livraison :
- Noms → `[SALARIÉ]`, `[ENTREPRISE]`, `[MÉDECIN TRAITANT]`
- Dates de consultation → mois/année sauf si la date exacte est nécessaire
- Postes très spécifiques (risque de réidentification) → généraliser

Exception : documents confraternels (médecin → médecin) — données
nominatives autorisées si couvertes par le secret médical partagé.
Vérifier le type de communication (question-bank Q12).

## Section Limites (obligatoire si confiance mixte)

Placer en fin de document :

```markdown
## Limites et confiance

| Section | Confiance | Raison |
|---------|-----------|--------|
| [titre] | MOYENNE | Divergence source X vs Y sur [point] |
| [titre] | BASSE | Aucune source primaire trouvée |

Appels externes : [N] effectués, [N] échoués.
Failles résiduelles : [description ou « aucune »].
```

## Zones d'incertitude dans le corps du texte

Les divergences interprétatives ou conflits de sources signalés
directement dans le corps du texte entre crochets :

`[NOTE : La jurisprudence sur ce point est divergente — voir Limites]`

## Format Word (si demandé)

Le skill /document produit le contenu en Markdown.
Le rendu Word/PDF est une étape séparée via le skill docx ou XEROX.
