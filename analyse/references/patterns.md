# 8 Architectures — /analyse

## 1. Pipeline séquentiel
3-5 agents. Traçabilité max. Synergie : livrable doc → /document.
Contrats : recherche→corpus, structuration→plan, rédaction→brouillon.

## 2. Fan-out / Fan-in
3-8 spécialistes + 1 synthétiseur. Règles de merge explicites.
Chaque spécialiste : input=sous-question → output=analyse ≤500 mots.

## 3. Confrontation adversariale
2-3 débatteurs + 1 juge. Max 2-3 rounds. Pas de vote en SST/juridique.
Enjeux élevés → externaliser juge via /jury.
Architectures : D3 (advocate/judge/jury), DREAM.

## 4. Boucle auteur-critique
1+1+1, 2 tours. Ne pas critiquer ce qui est déjà bon.
Synergie : doc formel → /document après la boucle.

## 5. Rôles métier
4-7 spécialistes + CdP. Agents SST possibles : toxicologue,
juriste travail, ergonome, épidémiologiste.
Peuvent appliquer /expertise dans leur périmètre.

## 6. Squelette + remplissage
Architecte→plan, rédacteurs→sections, intégrateur→document.
Synergie : /document gère la rédaction section par section.

## 7. Meta-Prompting dynamique
Expertises identifiées dynamiquement. Peut invoquer /expertise.

## 8. Combinaison adaptative
Hybride. Ex : /brainstorming (diverger) → /analyse P8 → /document.
