---
name: document
description: >
  Moteur de production de documents experts de haute qualité. Trois modes
  auto-détectés (rapide/standard/critique) selon l'enjeu et la complexité.
  Pipeline : spécifier → construire → stress-tester → vérifier → livrer,
  avec profondeur adaptative et validation externe par modèles non-Claude.
  DÉCLENCHEUR EXPLICITE : /document.
  DÉCLENCHEURS IMPLICITES : « document de référence », « guide exhaustif »,
  « référentiel complet », « source pour un projet Claude », « knowledge
  base sur [sujet] ».
  S'ACTIVE AUSSI si (1) besoin de grande qualité/rigueur ET (2) contexte
  sensible (risque juridique, médical, réglementaire, déontologique,
  financier) — même pour un texte court.
  NE S'ACTIVE PAS : questions simples, résumés, traductions, tâches en un
  seul passage.
  SYNERGIE : /analyse et /oriente.
---

# /document — Expert Document Engine v3

## 1. Sélection du mode

Trois modes. Claude sélectionne automatiquement sauf demande explicite.

| Mode | Quand | Phases | Hard stops |
|------|-------|--------|------------|
| **Rapide** | Enjeu faible, format connu, < 5 pages. | 0 → 1 → 4 → livraison | Aucun |
| **Standard** | Enjeu modéré, document structuré. | 0 → 1 → 2 → 3 → 4 → livraison | Après phase 0 |
| **Critique** | Enjeu élevé : juridique, médical, disciplinaire, opposable. | Toutes (0–6) | Après chaque phase |

Annoncer le mode choisi et sa justification au démarrage.

**Critères d'auto-détection :**
- Mots-clés critique : inaptitude, contentieux, disciplinaire, opposable,
  tribunal, expertise, publication, MP, AT, harcèlement.
- Mots-clés standard : rapport, étude, analyse, avis, recommandation.
- Par défaut si aucun signal : standard.

## 2. Phases

### Phase 0 — SPÉCIFIER

1. Si sujet clair → cadrer en 3 lignes et passer.
2. Sinon → poser les questions nécessaires
   (charger `question-bank.md` — voir §5).
3. Spécification : cas d'usage, structure, checklist CTQ binaire
   (charger `ctq-rubric.md` — voir §5), interdictions, sources.
4. Si lessons_learned du même domaine existent → intégrer.

**STOP.** Présenter la spécification. Demander validation.
*(Mode rapide : continuer directement si cadrage en 3 lignes.)*

### Phase 1 — CONSTRUIRE

1. Rechercher (MCP internes d'abord — MedData, SSTinfo — web ensuite).
2. Rédiger section par section. Citations traçables. Aucune section vide.
3. Format : Markdown + YAML frontmatter plat.
4. Anonymisation dès la rédaction si document partageable.
5. Checklist CTQ : chaque item OUI/NON. Items critiques = OUI obligatoire.

**Retour arrière** : si défaut de cadrage → mettre à jour la spec.

### Phase 2 — AMÉLIORER (standard + critique)

Relire comme un lecteur externe. Max 2 passes.
Vérification factuelle des 5-10 affirmations les plus critiques.

### Phase 3 — STRESS-TESTER (standard + critique)

Critique structurée — voir conventions.md §4 pour le protocole.

**Standard** : 3-4 personas séquentielles (Claude seul).
Aussi en standard si le document est contentieux ou opposable.
**Critique** : 2 personas Claude + 1-2 modèles externes via RedAPI.
Les modèles externes remplacent des personas (total 3-4 voix).

Profil anti-sycophantie : CRITIQUE (conventions.md §1).

**Appels externes — protocole conventions.md §2.**

### Phase 4 — VÉRIFIER (tous modes)

| Couche | Rapide | Standard | Critique |
|--------|--------|----------|----------|
| Structurelle | ✓ | ✓ | ✓ |
| Factuelle (affirmations pivots) | — | ✓ | ✓ |
| Complétude | — | ✓ | ✓ |
| Scénarios (5 situations) | — | — | ✓ |
| Pre-mortem | — | — | ✓ |

Vérification factuelle : soumettre les affirmations pivots à `ai_search`
(Sonar). Fallback : web_search ou MCP.

**RÈGLE DURE** : affirmation juridique sans appel outil = supprimée
ou marquée `[NON VÉRIFIÉ — confiance BASSE]`.

Charger `verification.md` (voir §5) pour le protocole détaillé.
Score de confiance par section : HAUTE / MOYENNE / BASSE.

### Phase 5 — CLÔTURER (critique uniquement)

Cibler les zones MOYENNE/BASSE. Arbitrage externe via `ai_reason`.
Budget adversarial total : max 2 passes (phases 3 + 5).

### Livraison

Charger `formatting.md` (voir §5). YAML plat, headers en questions si
projet Claude, ≤80 Ko, résumé analytique si >10K tokens.
Section Limites obligatoire si confiance mixte.

### Capitalisation (critique, optionnel en standard)

Bloc lessons_learned réutilisable en phase 0.

## 3. Appels externes via RedAPI — résumé

Voir conventions.md §2 pour le protocole commun.

| Phase | Standard | Critique | Outil | Fallback |
|-------|----------|----------|-------|----------|
| 3 | — | Critique brouillon | `ai_chat` | Critique interne |
| 4 | Vérif. factuelle | Vérif. factuelle | `ai_search` | web_search / MCP |
| 5 | — | Arbitrage | `ai_reason` | Arbitrage interne |

## 4. Règles transversales

- Anti-sycophantie : profil CRITIQUE (conventions.md §1).
- Honnêteté : confiance H/M/B, failles documentées, JAMAIS masquées.
- Recherche : MCP internes d'abord. Si rien → Limites, pas d'invention.
- Ne pas s'auto-évaluer favorablement — utiliser la checklist CTQ.

## 5. Fichiers de référence (à la demande)

| Référence | Fichier |
|-----------|---------|
| Questions de cadrage | `question-bank.md` |
| Checklists CTQ | `ctq-rubric.md` |
| Protocole adversarial | `adversarial.md` |
| Vérification 5 couches | `verification.md` |
| Format final | `formatting.md` |

### Cascade de chargement
1. `project_knowledge_search`
2. `nas_read_file("skills/document/references/[fichier]")`
3. `web_fetch` sur `https://raw.githubusercontent.com/reddepot/skills/main/document/references/[fichier]`
4. Mode dégradé — SKILL.md seul.
