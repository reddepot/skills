# Protocole Challenger renforcé

## Principe

Le Challenger est le dernier garde-fou avant livraison. Il ne produit
pas de contenu — il attaque le livrable.

## Deux techniques obligatoires

### Quote-grounding
Le Challenger CITE le passage exact du livrable qu'il attaque avant
de formuler sa critique. Pas de critique vague.

Format :
```
Passage : « [citation exacte] »
Faille : [factuel / logique / omission / clarté / conformité]
Sévérité : HAUTE / MOYENNE / BASSE
Correctif : [proposition]
```

### Pre-mortem
Le Challenger répond à : « Si ce livrable échouait à atteindre son
objectif, quelle serait la raison la plus probable ? »
Puis vérifie si cette raison est traitée dans le livrable.

## Checklist

- [ ] Hypothèses non-déclarées identifiées ?
- [ ] Contre-argument le plus fort formulé ?
- [ ] Affirmations non-sourcées repérées ?
- [ ] Dissensus documenté ?
- [ ] Pre-mortem traité ?
- [ ] Convergence artificielle détectée ?

## Externalisation (enjeux élevés)

Quand : score de routage ≥ 8, ou domaine SST/juridique/opposable.

Méthode : appeler `/council` — utiliser `ai_chat` avec un modèle
externe (DeepSeek, Gemini) pour une critique indépendante.

Prompt type :
```
Tu es un critique expert en [domaine]. Voici un livrable et ses
critères de qualité. Critique-le impitoyablement :
- Cite chaque passage attaqué
- Nomme la faille (factuel/logique/omission/clarté/conformité)
- Donne la sévérité (HAUTE/MOYENNE/BASSE)
- Propose un correctif

Livrable :
[texte complet]

Critères :
[CTQ ou brief original]
```

Max 2 appels. Si échec → Challenger interne avec cette grille renforcée.
Claude analyse la réponse externe et décide quoi intégrer — ne recopie pas.

## Arbitrage D3 (enjeux critiques)

Pour les livrables opposables (inaptitude, contentieux, publication) :
structure Debate-Deliberate-Decide plutôt que juge unique.

1. **Advocate** — défend le livrable tel quel
2. **Critique** — attaque (Challenger standard)
3. **Juge** — arbitre sur la qualité des arguments, pas sur la majorité

Si score ≥ 8 ou domaine juridique → externaliser le Critique via
/council et garder Claude comme Advocate + Juge.

## Si le Challenger ne trouve rien

Il le dit honnêtement. Pas de critique artificielle pour justifier
son existence. L'absence de faille est un signal positif, pas un échec.
