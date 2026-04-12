# Protocole d'élévation

## Principe

Chaque livrable contient un élément de valeur au-delà de la commande.
L'élévation distingue un output expert d'un output standard.
Si aucune élévation pertinente n'émerge, le dire plutôt que forcer.

## Types d'élévation par tâche

| Type de tâche | Forme d'élévation |
|---|---|
| Analytique / stratégique | Angle non demandé mais décisif, anticipation d'objections |
| Rédactionnelle / créative | Trouvaille stylistique, structure narrative inattendue |
| Factuelle / compilatoire | Vérification croisée, complétude auditée, données manquantes signalées |
| Technique / procédurale | Cas limite identifié et traité, optimisation non demandée |
| Argumentative / juridique | Stress-test de la thèse, contre-argument le plus fort traité |

## Élévation par skill aval

Quand /agent passe le relais à un autre skill, l'élévation s'adapte :

| Skill aval | Élévation attendue |
|------------|-------------------|
| /document | Section « connexions transversales » ou « angle non couvert » |
| /expert | Cartographie des controverses actives, connexions inter-domaines |
| /standard | Red flags non évidents pour l'IDST, cas limites opérationnels |
| /retex | Question de réflexion non posée, biais cognitif identifié |

## Vérification

À l'étape 5 (élévation finale), vérifier :
1. L'élévation annoncée au diagnostic est-elle présente dans le livrable ?
2. Est-elle substantielle (pas une reformulation de la commande) ?
3. Les attaques du Challenger sont-elles traitées ?

Si l'élévation promise n'a pas émergé → le signaler honnêtement
dans le log plutôt que forcer un ajout artificiel.

## Inner monologue de l'agent

Chaque agent structure son intervention en 4 temps :

1. **COMPRENDRE** — reformuler la tâche dans ses propres termes
2. **ÉVALUER** — appliquer sa méthode de raisonnement spécifique
3. **CONFIANCE** — qualifier son niveau de certitude
   (haute / moyenne / basse) sur chaque affirmation clé
4. **PRODUIRE** — livrer sa contribution

Mode transparent : 4 temps visibles.
Mode clean : seul PRODUIRE livré, log à la demande.

Ce protocole empêche le « raisonnement générique » où tous
les agents pensent de la même manière.
