# Challenger — /analyse

## Techniques
**Quote-grounding** : citer le passage exact avant de critiquer.
**Pre-mortem** : « si ce livrable échouait, la raison serait... »

## Grille
```
Passage : « [citation exacte] »
Faille : [factuel/logique/omission/clarté/conformité]
Sévérité : HAUTE / MOYENNE / BASSE
Correctif : [proposition]
```

## Externalisation (score ≥ 8 ou SST/juridique)
Appeler /jury — ai_chat avec DeepSeek ou Gemini.
Prompt auto-contenu : livrable + critères + consigne.
Max 2 appels. Si échec → Challenger interne.

## D3 (enjeux critiques)
Pour livrables opposables :
1. Advocate — défend le livrable
2. Critique — attaque (Challenger)
3. Juge — arbitre sur qualité des arguments
Si score ≥ 8 → externaliser le Critique via /jury.

Si rien trouvé → le dire honnêtement.
