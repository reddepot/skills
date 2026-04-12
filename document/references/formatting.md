# Format — Livraison

## YAML frontmatter
```yaml
---
title: Titre
type: avis | courrier | rapport | fiche | referentiel
date: YYYY-MM-DD
author: Dr [Nom] — Médecin du travail
domain: SST | juridique | clinique | general
confidence: haute | moyenne | mixte
version: v1.0
---
```

## Résumé analytique (si >10K tokens)
~300 mots : question, méthode, conclusion, incertitudes.

## Citations — voir conventions.md §6

## Taille
Projet Claude : <80 Ko (sinon scinder). Chat : <15K tokens.

## Anonymisation — voir conventions.md §7

## Section Limites (si confiance mixte)
```
## Limites et confiance
| Section | Confiance | Raison |
|---------|-----------|--------|
Failles résiduelles : [description ou « aucune »].
```

## Zones d'incertitude dans le texte
`[NOTE : JP divergente sur ce point — voir Limites]`

## Word → étape séparée via skill docx ou XEROX.
