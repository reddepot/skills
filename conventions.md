# Conventions partagées — Écosystème Skills Claude

Référencé par tous les skills. Source de vérité unique.
Charger via : nas_read_file("skills/conventions.md") ou
web_fetch sur https://raw.githubusercontent.com/reddepot/skills/main/conventions.md

---

## 1. Anti-sycophantie — 3 profils

### Profil CRITIQUE (détection continue)
Utilisé par : /analyse, /document (phases adversariales)
- Interdiction du faux consensus : approuver = expliquer POURQUOI
  en termes de contenu, avec citation du passage.
- Détection à chaque tour : approbation sans citation = rejet.
- Si toutes les critiques disparaissent sans correction substantielle
  → alerte convergence artificielle, maintenir le dissensus.
- Confiance indépendante : chaque agent forme son jugement AVANT
  de considérer les conclusions des autres.

### Profil MODÉRÉ (détection ponctuelle)
Utilisé par : /retex, /expertise, /oriente
- Vérification au moment de la convergence, pas à chaque tour.
- Les perspectives divergentes sont documentées, pas forcées à converger.
- Le dissensus est livré au résultat, pas effacé.

### Profil CRÉATIF (transparence des convergences)
Utilisé par : /brainstorming
- Documentation de quel modèle a produit quelle idée.
- Injection disruptive si convergence prématurée entre modèles.
- Les convergences multi-modèles sont des signaux (★), pas des preuves.
- Les singletons (◆) sont protégés, pas éliminés.

### Règle commune aux 3 profils
Diversité de méthode de raisonnement > diversité de persona.
Méthodes : inductif, déductif, par analogie, par contradiction,
par premiers principes, conservateur, exploratoire.

---

## 2. Convention RedAPI

1. **Prompt auto-contenu** : le modèle externe n'a pas le contexte projet.
   Inclure : texte pertinent + critères + consigne précise.
2. **Max 2 appels par phase** d'un skill.
3. **Fallback** : si l'appel échoue → continuer sans, noter dans Limites.
4. **JAMAIS de Claude via API payante** — Claude est déjà là gratuitement.
5. **Plafond de coût** : $2.00 maximum par session de skill.
6. **Policy gate PHI** : aucune donnée nominative vers providers externes.
   Si PHI détecté : dépersonnaliser ou bloquer.
7. **Limite 225K tokens en entrée** par appel. Tronquer si nécessaire.
8. **Modèles recommandés par rôle** :
   - Critique/adversarial : DeepSeek Chat, Gemini 3.1 Pro
   - Recherche web : Sonar Pro
   - Raisonnement profond : DeepSeek Reasoner (ai_reason)
   - Scoring/jugement : Qwen 3.5 (jamais GPT-5.4 en auto-évaluation)
   - Provocation : Grok 4.20 ("Direct, incisif, 200 mots max")

---

## 3. État partagé / Handoff inter-skills

Format standard pour le passage de relais :

```yaml
handoff:
  from: /expertise
  to: /fiche
  summary: "[résumé ≤500 mots]"
  conclusions: [...]
  open_questions: [...]
  dissensus: [...]
  constraints_inherited: [...]
  confidence: {section_1: haute, section_2: moyenne}
```

Convention de piping : `/expertise > /fiche` → Claude enchaîne via handoff.

---

## 4. Protocole adversarial unifié

Référencé par /analyse, /document, /brainstorming.

Grille de critique :
```
Passage attaqué : « [citation exacte] »
Nature : [factuel / logique / omission / clarté / conformité]
Sévérité : HAUTE / MOYENNE / BASSE
Correctif : [proposition]
```

Règles :
- Citations obligatoires — pas de critique vague.
- Corriger HAUTE et MOYENNE obligatoirement.
- BASSE = documenter, corriger si facile.
- Rejet d'une critique = motivation obligatoire.
- Pas de consensus par vote en SST/juridique.
- Budget : max 2 passes adversariales par livrable.
- Externalisation via RedAPI si enjeu ≥ 8 ou SST/juridique/opposable.

---

## 5. Anti-sur-ingénierie (ex /calibre)

Convention transversale, pas un skill.
- Le raisonnement natif d'Opus 4.6 suffit dans la majorité des cas.
- Superposer des frameworks (CoT, ToT, GoT) dégrade la performance.
- Si qualité insuffisante → « manque-t-il du contexte ? » avant
  « faut-il un framework ? ».
- Chaque skill a son propre gate de profondeur.
- /oriente ne calibre PAS — il route.
- Anti-patterns : sur-prompting procédural, escalade verbale, empilement.

---

## 6. Format de citation unifié

Légifrance : `[Art. L.4624-4 C. trav.]` + URL
JP : `[Cass. soc., 29 nov. 2023, n° 22-12.345]` + URL Judilibre
INRS : `[INRS ED 6294 — Titre]` + URL
Médical : `[Auteur et al., Année, Journal — DOI ou PMID]`
Autre : `[Source: Titre — URL]`
Pas de citation = pas d'affirmation factuelle.
Si pas de source → `[Source non vérifiée — confiance BASSE]`.

---

## 7. Anonymisation — Privacy by design

Appliquer dès la rédaction, pas à la livraison :
- Noms → [SALARIÉ], [ENTREPRISE], [MÉDECIN TRAITANT]
- Dates de consultation → mois/année sauf si date exacte nécessaire
- Exception : documents confraternels (secret médical partagé)
