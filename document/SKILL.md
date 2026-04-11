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
  SYNERGIE : /agent et /calibre.
---

# /document — Expert Document Engine v3

## 1. Sélection du mode

Trois modes. Claude sélectionne automatiquement sauf demande explicite.

| Mode | Quand | Phases | Hard stops |
|------|-------|--------|------------|
| **Rapide** | Enjeu faible, format connu, < 5 pages. Courrier type, note interne, fiche. | 0 → 1 → 4 → livraison | Aucun — exécution continue |
| **Standard** | Enjeu modéré, document structuré, besoin de rigueur. Rapport, étude, avis. | 0 → 1 → 2 → 3 → 4 → livraison | Après phase 0 |
| **Critique** | Enjeu élevé : juridique, médical, disciplinaire, publication, document opposable. | Toutes les phases (0–6) | Après chaque phase |

Annoncer le mode choisi et sa justification au démarrage.
L'utilisateur peut forcer un autre mode à tout moment.

**Critères d'auto-détection :**
- Mots-clés critique : inaptitude, contentieux, disciplinaire, opposable,
  tribunal, expertise, publication, MP, AT, harcèlement.
- Mots-clés standard : rapport, étude, analyse, avis, recommandation.
- Par défaut si aucun signal : standard.

## 2. Phases

### Phase 0 — SPÉCIFIER

Objectif : cadrer le document avant toute rédaction.

1. Si le sujet est clair et détaillé → cadrer en 3 lignes (public, format, CTQ essentiels) et passer.
2. Sinon → poser les questions nécessaires
   (charger `question-bank.md` — voir §5 pour la cascade).
3. Produire la spécification :
   - Cas d'usage (qui, pour quoi, dans quel contexte)
   - Structure attendue (sections, ordre)
   - Checklist CTQ binaire (charger `ctq-rubric.md` — voir §5)
   - Interdictions
   - Sources à exploiter (MCP internes, projet, web, uploads)
4. Si des lessons_learned du même domaine existent dans le projet → intégrer.

**STOP.** Présenter la spécification. Demander : « Validez-vous ce cadrage ? »
Ne pas continuer sans réponse explicite.
*(En mode rapide uniquement : continuer directement si le cadrage tient en 3 lignes.)*

### Phase 1 — CONSTRUIRE

Rédiger le document section par section à partir de la spécification.

1. Rechercher dans les sources (MCP internes d'abord — MedData pour le
   médical, SSTinfo pour le réglementaire/risques pro — web ensuite si
   insuffisant).
2. Rédiger chaque section avec :
   - Headers en questions (optimisation RAG si destination = projet Claude)
   - Citations traçables : `[Source: titre, URL ou référence]`
   - Aucune section vide — signaler les lacunes plutôt que combler par du vague
3. Format : Markdown + YAML frontmatter plat (metadata uniquement, corps en MD).
4. Anonymisation dès la rédaction si le document est partageable (privacy by design).
5. Vérifier la checklist CTQ. Chaque item = OUI ou NON.
   Tous les items critiques à OUI pour passer.

**Retour arrière** : si la rédaction révèle un défaut de cadrage (section
impossible, source manquante, périmètre flou) → mettre à jour la spec
et signaler le changement.

### Phase 2 — AMÉLIORER (standard + critique)

Relire le brouillon comme un lecteur externe, pas comme l'auteur.

1. Évaluer chaque section (clarté, précision, complétude, cohérence).
2. Corriger — max 2 passes.
3. Vérification factuelle des 5-10 affirmations les plus critiques.

### Phase 3 — STRESS-TESTER (standard + critique)

Critique structurée — PAS de débat simulé entre personas fictives.

**Mode standard** : 3-4 personas séquentielles (Claude seul).
Déclenché aussi en standard si le document est contentieux ou opposable.
**Mode critique** : 2 personas Claude + 1-2 modèles externes via RedAPI.

Les modèles externes **remplacent** des personas, ils ne s'y ajoutent pas.
Total : toujours 3-4 voix distinctes.

Chaque voix critique avec la même grille
(charger `adversarial.md` — voir §5) :
- Passage exact attaqué (citation)
- Nature de la faille
- Sévérité : HAUTE / MOYENNE / BASSE
- Correctif proposé ou rejet motivé

Corriger les failles HAUTE et MOYENNE.
Logger les critiques et décisions.

**Appels externes (critique) — protocole :**
1. Formuler un prompt auto-contenu (texte + CTQ + consigne précise).
2. Appeler `ai_chat` avec DeepSeek ou Gemini. Max 2 appels.
3. Si l'appel échoue (timeout, erreur, non-sens) → continuer avec critique
   interne seule. Noter dans la section Limites.
4. Claude analyse la réponse et décide quoi intégrer — ne recopie pas.

### Phase 4 — VÉRIFIER (tous modes)

Profondeur adaptée au mode :

| Couche | Rapide | Standard | Critique |
|--------|--------|----------|----------|
| Structurelle (sections, format, taille) | ✓ | ✓ | ✓ |
| Factuelle (affirmations pivots vérifiées) | — | ✓ | ✓ |
| Complétude (croisement avec sources) | — | ✓ | ✓ |
| Scénarios (5 situations concrètes) | — | — | ✓ |
| Pre-mortem (« si ce doc échouait... ») | — | — | ✓ |

**Vérification factuelle (standard + critique)** : soumettre les 5-10
affirmations pivots à `ai_search` (Sonar) pour croisement indépendant.
Si appel échoue → vérifier via web_search ou sources MCP.

**RÈGLE DURE** : toute affirmation juridique non validée par un appel outil
explicite (SSTinfo/Légifrance) doit être supprimée ou marquée
`[NON VÉRIFIÉ — confiance BASSE]`.

Charger `verification.md` (voir §5) pour le protocole détaillé de chaque couche.
Score de confiance par section : HAUTE / MOYENNE / BASSE.

### Phase 5 — CLÔTURER (critique uniquement)

1. Cibler les zones à confiance MOYENNE ou BASSE.
2. Soumettre ces zones à `ai_reason` (DeepSeek Reasoner) pour arbitrage.
   Prompt auto-contenu : texte de la zone + contexte minimal + question précise.
   Si appel échoue → arbitrer en interne et noter dans Limites.
3. Appliquer les corrections justifiées.
4. Si des failles persistent → documenter honnêtement.

**Budget adversarial total (phases 3 + 5) : max 2 passes.**
Phase 3 = 1 passe. Phase 5 = 1 passe ciblée. Pas de boucle.

### Livraison

1. Appliquer les règles de format
   (charger `formatting.md` — voir §5) :
   - YAML frontmatter plat (metadata seulement)
   - Headers en questions si destination projet Claude
   - Aucun renvoi vers des fichiers absents du projet cible
   - Budget tokens < 80 Ko si possible (sinon scinder)
   - Résumé analytique en tête si > 10 000 tokens
2. Livrer le document dans le chat ou via fichier selon le format demandé.
3. Si des fragilités subsistent → section « Limites et confiance » obligatoire.

### Capitalisation (critique uniquement, optionnel en standard)

Produire un bloc `lessons_learned` :
- Erreurs trouvées (type, gravité, phase de découverte)
- Critiques externes les plus utiles
- Phases à forte vs faible valeur ajoutée
- Limites résiduelles

Réutilisable en phase 0 des prochaines exécutions.

## 3. Appels externes via RedAPI — résumé

Claude a les mêmes biais et angles morts que l'auteur du texte.
Les modèles externes apportent une orthogonalité réelle.
Claude orchestre et décide — il ne recopie pas les réponses externes.

| Phase | Standard | Critique | Outil | Fallback |
|-------|----------|----------|-------|----------|
| 3 | — | Critique du brouillon (remplace 1-2 personas) | `ai_chat` (DeepSeek, Gemini) | Critique interne seule |
| 4 | Vérification factuelle | Vérification factuelle | `ai_search` (Sonar) | web_search ou MCP |
| 5 | — | Arbitrage zones fragiles | `ai_reason` (Reasoner) | Arbitrage interne |

**Max 2 appels par phase. Prompt toujours auto-contenu.**

## 4. Règles transversales

### Anti-sycophantie
- Ne pas approuver sans argument de contenu.
- Ne pas critiquer sans citer le passage exact.
- Ne pas converger par complaisance.
- Ne pas s'auto-évaluer favorablement — utiliser la checklist CTQ binaire.

### Honnêteté
- Confiance HAUTE / MOYENNE / BASSE sur chaque section.
- Arguments innovants signalés comme tels.
- Failles non résolues = documentées, jamais masquées.
- NE JAMAIS livrer un document avec des failles significatives non documentées.

### Recherche
- MCP internes d'abord (MedData pour médical, SSTinfo pour réglementaire/SST).
- Si l'outil MCP ne trouve rien → signaler la lacune dans Limites.
  Ne pas inventer de jurisprudence, de recommandation ou de référence.
- Web ensuite si MCP insuffisant.
- Chaque donnée citée inclut son URL ou référence publique.

## 5. Fichiers de référence (chargement à la demande)

Les fichiers de référence enrichissent chaque phase. Ne charger QUE le
fichier nécessaire à la phase en cours — pas tous d'un coup.

| Référence | Phase | Fichier |
|-----------|-------|---------|
| Questions de cadrage | 0 | `question-bank.md` |
| Checklists CTQ | 0, 1, 4 | `ctq-rubric.md` |
| Protocole adversarial | 3, 5 | `adversarial.md` |
| Protocole vérification | 4 | `verification.md` |
| Règles de format | Livraison | `formatting.md` |

### Ordre de chargement (cascade)

1. **Projet Claude** — `project_knowledge_search` si le fichier est dans
   la Knowledge Base du projet courant.
2. **NAS** — `nas_read_file("skills/document/references/[fichier]")` via RedAPI.
3. **GitHub** — `web_fetch` sur
   `https://raw.githubusercontent.com/reddepot/skills/main/document/references/[fichier]`
4. **Mode dégradé** — si les 3 sources échouent, exécuter avec les
   instructions du SKILL.md seul (le process reste fonctionnel,
   seuls les détails de référence manquent).
