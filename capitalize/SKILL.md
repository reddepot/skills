---
name: capitalize
description: >
  Phase ACT du cycle PDCA appliqué au dev IT. Transforme une session,
  un audit POLYLENS, un ADR DEVCODE, un incident, ou un retex en
  assets durables : memory MD canoniques, mises à jour MEMORY.md,
  ADR projet, propagation cross-projet. 4ᵉ pilier après POLYPRISM
  (Plan) → POLYBUILD (Do) → POLYLENS (Check) → /capitalize (Act).
  Auto-graduation C0/C1/C2/C3 selon impact et nombre de fichiers
  touchés. Format canonique de lesson (title/why/how_to_apply/
  evidence/expiration/scope). Phase 2 dédup obligatoire pour éviter
  conflits memory. DÉCLENCHEUR EXPLICITE : /capitalize (alias /act).
  IMPLICITES : « capitalisons », « lesson apprise », « à retenir »,
  « pour la prochaine fois », « note ça en mémoire », fin de session
  POLYLENS ≥3 findings P0/P1, fin de session POLYBUILD avec ADR
  généré, détection anti-pattern récurrent (≥3 occurrences même
  sujet en 2 sem), conflit memory détecté, backlog pending
  « Maj feedback_*.md » repéré. NE S'ACTIVE PAS : bug fix < 30min
  sans surprise, code generation routinière, conversation sans
  nouveauté méthodologique, user a dit « pas la peine ». BYPASS si
  C3 trivial (1 ajout direct sans index) traité directement.
  SYNERGIE : POLYLENS amont (findings → lessons), POLYBUILD amont
  (ADR → input), /decision amont (ADR DEVCODE-Vote = source
  primaire), /retex amont (debrief clinique → lesson durable),
  /document aval si livrable opposable. Référence canonique :
  ~/.claude/projects/-Users-radu/memory/feedback_capitalize_method.md.
---

# /capitalize — Phase ACT du cycle PDCA — v1

## Acronyme

**CAPITALIZE** = Capture Analyse Propage Intègre Trace Auto-graduation Lessons Index Zéro-Entropie.

## Mantra

> Une lesson sans evidence est une opinion. Une lesson sans index est orpheline. Une lesson sans expiration est un piège futur.

---

## Ce que fait /capitalize (en 30 secondes)

Tu finis une session dense (audit, sprint, incident, débriefing). Tu tapes `/capitalize` (ou laisses l'auto-détection le déclencher). Claude extrait les lessons candidates de la source (transcript, ADR, findings POLYLENS, output POLYBUILD), les déduplique contre les 143+ fichiers memory existants, les gradue C0-C3, écrit/update les fichiers canoniques, met à jour `MEMORY.md`, et propage cross-projet si nécessaire.

C'est le maillon **ACT** longtemps manquant : avant /capitalize, les lessons étaient capturées artisanalement dans `lessons_*.md` mais rarement promues vers `feedback_*.md` (règles durables) ni propagées vers conventions globales.

---

## 1. Quand /capitalize se déclenche-t-il ?

### Auto-détection — signaux explicites

- Mots-clés : « capitalisons », « lesson apprise », « à retenir », « pour la prochaine fois », « note ça en mémoire », « ne pas oublier »
- Slash : `/capitalize`, `/act`

### Auto-détection — signaux implicites

| Contexte | Trigger |
|----------|---------|
| Fin POLYLENS | ≥3 findings P0/P1 confirmés avec preuve exécutable |
| Fin POLYBUILD | ADR généré + Phase 7 commit |
| Fin /decision P1+ | ADR DEVCODE-Vote produit |
| Fin /retex parcours C | bilan trimestriel à archiver |
| Récurrence | même anti-pattern détecté ≥3 fois en 2 semaines |
| Conflit memory | grep révèle 2+ fichiers contradictoires sur même topic |
| Backlog pending | détection « Maj feedback_*.md » dans backlog jamais exécuté |
| Incident résolu | `incident_*.md` créé sans `feedback_*.md` correspondant |

### Bypass (NE S'ACTIVE PAS)

- Bug fix < 30min sans surprise → fix direct, pas de capitalize
- Code generation routinière sans incident → skip
- Conversation conversationnelle sans nouveauté méthodologique
- User a dit explicitement « pas la peine de capitaliser »
- C3 trivial avec ajout direct < 5 lignes (passe direct par bypass)

---

## 2. Pipeline /capitalize (5 phases)

### Phase 0 — Cadrage source

Identifier la source primaire et le périmètre.

| Source | Extraction privilégiée |
|--------|------------------------|
| Transcript session | Corrections user, surprises, fixs non-obvious, validations explicites |
| Findings POLYLENS | P0/P1 confirmés avec mécanisme causal |
| ADR POLYBUILD/DEVCODE | Mécanismes causaux non-évidents + critères de succès |
| Incident résolu | Root cause + mitigation + détection durable |
| /retex parcours | Insights diagnostiques, biais identifiés, alternatives ratées |

**Règle** : si source ambigüe, demander en 1 question : « Source = transcript de la session entière, ou findings spécifiques d'un audit, ou ADR ciblé ? »

### Phase 1 — Extraction lessons candidates

Format **canonique** pour chaque lesson :

```yaml
lesson:
  title: "<règle ou fait, 1 ligne, ≤120 chars>"
  type: feedback | lessons | incident | project | reference
  scope: cross-project | project-X | session-only | cross-skill
  why: "<raison/incident/preuve, 1-3 lignes>"
  how_to_apply: "<quand/où ce s'applique, 1-2 lignes>"
  evidence: ["<test|repro|citation|commit>"]
  expiration: "<date ISO 8601 ou 'permanent' ou 'review:YYYY-MM'>"
  conflicts_with: ["<file_to_check.md>"]
  related_skills: ["<skill1>", "<skill2>"]
```

**Filtres rigueur** (bloquent l'ajout) :
- ❌ Lesson sans `evidence` → c'est une opinion, pas une lesson
- ❌ Lesson sans `why` → règle obscure dans 6 mois
- ❌ Lesson `scope=session-only` → ne va pas en memory durable, juste dans handoff
- ❌ Lesson dupliquant à >85% une existante → merge plutôt que ajout
- ❌ Lesson type=feedback sans `how_to_apply` → règle non-actionnable

### Phase 2 — Déduplication / conflit

Pour chaque lesson candidate :

1. **Search memory** : grep titre + topics + tags dans `~/.claude/projects/-Users-radu/memory/`
2. **Match similaire** (≥85% topic overlap) :
   - Si compatible → **merge** : ajouter section `### Updates YYYY-MM-DD` au fichier existant
   - Si conflit → **flag + escalade** : créer entrée temporaire `_pending_conflict_<topic>.md` et déclencher `/decision` P2 pour trancher
3. **Match exact** (titre identique) :
   - Update du fichier existant en place avec preuve renforcée
4. **Aucun match** :
   - Préparer création nouveau fichier selon convention nommage

**Convention nommage** (issue de project_skills.md + observations des 143 fichiers existants) :

| Type | Préfixe | Exemple |
|------|---------|---------|
| feedback (règle durable) | `feedback_<topic>.md` | `feedback_capitalize_method.md` |
| lessons (récap session) | `lessons_session_YYYYMMDD_<topic>.md` | `lessons_session_20260505_capitalize.md` |
| lessons (règle techn) | `lessons_<domain>_<topic>.md` | `lessons_sqlite_perf_anti_patterns.md` |
| incident (post-mortem) | `incident_<projet>_<topic>_YYYYMMDD.md` | `incident_meddata_db_corruption_20260424.md` |
| project (état projet) | `project_<projet>.md` ou `project_<projet>_<sub>.md` | `project_meddata.md` |
| reference (pointeur ext) | `reference_<resource>.md` | `reference_perplexity_api.md` |

### Phase 3 — Graduation C0/C1/C2/C3

| Niveau | Critères | Actions |
|--------|----------|---------|
| **C3 — Trivial** | 1 lesson légère, ≤1 fichier touché, scope session-only ou project-X mineur | Append direct memory MD. Pas d'update MEMORY.md si entrée déjà existe. |
| **C2 — Standard** | 2-5 lessons, 1-2 fichiers, scope project-X | Write/update memory MD + 1 entrée MEMORY.md (≤200 chars). |
| **C1 — Important** | Refactor cross-fichier (merge ≥2 feedback_*.md), update conventions, propagation 1-2 projets | Memory MD + MEMORY.md + ADR projet(s) + diff documenté. |
| **C0 — Critique** | Anti-pattern majeur, change de méthodologie, conflit cross-skill, propagation ≥3 projets | Memory MD + MEMORY.md + ADR(s) + audit POLYLENS consistency sur memory globale + alerte conventions skills. |

**Règle escalade** : si Phase 2 détecte conflit non-trivial → graduation forcée à **C1 minimum**.

### Phase 4 — Application (DO de l'ACT)

Selon graduation :

```bash
# C3
$EDITOR ~/.claude/projects/-Users-radu/memory/<file>.md

# C2 = C3 +
$EDITOR ~/.claude/projects/-Users-radu/memory/MEMORY.md  # ajouter ligne ≤200 chars

# C1 = C2 +
$EDITOR <project>/docs/ADR/<date>_<topic>.md  # ADR projet
# Cross-références : ajouter "voir feedback_X.md" dans projets concernés

# C0 = C1 +
$EDITOR ~/Developer/projects/skills/conventions.md  # si change conventions skills
# Audit /polylens consistency lite sur memory globale (axe F + B)
# Notification dans handoff session
```

**Contrainte stricte MEMORY.md** : entrée 1 ligne ≤200 chars sous forme :

```markdown
- [Titre](fichier.md) — hook 1 phrase
```

**Règle de gonflement (durable, état observé 2026-05-05)** : si `wc -c MEMORY.md` > 24 KB (limite chargement contexte truncation), /capitalize **REFUSE** d'ajouter une entrée. Action obligatoire AVANT ajout :
1. Identifier 3-5 entrées candidates à purge : C3 anciennes (>30j), entrées avec `expiration: review:<date>` dépassée, entrées dont le projet est terminé/archivé
2. Proposer purge à user ou auto-purge si scope = `session-only`
3. Si MEMORY.md repasse < 22 KB (marge sécurité 2 KB) → autoriser ajout
4. Logger purge dans `_capitalize_log.jsonl` avec champ `purged_entries: [...]`

### Phase 5 — Trace + audit retro

**Log durable** : append dans `~/.claude/projects/-Users-radu/memory/_capitalize_log.jsonl`.

**Maintenance du log** :
- Création : si fichier absent, créer avec ligne 1 = entrée actuelle (pas de header, JSONL pur)
- Append-only : jamais de réécriture, toujours `>>`
- Format strict (1 ligne JSON valide par invocation) :

```json
{"date":"2026-05-05T14:30:00Z","source":"session_sprint31","graduation":"C1","files_changed":["feedback_methodo_stricte.md","MEMORY.md"],"lessons_count":9,"conflicts_resolved":0,"duration_min":12,"purged_entries":[]}
```

- Rotation : tous les 365j ou 1000 entrées (atteint le premier), archiver vers `_capitalize_log_<YYYY>.jsonl.gz` et repartir vide
- Pas de PII / pas de contenu lesson : juste métadonnées (filenames, counts, durations)

**Audit retro** (auto-déclenché tous les 30j ou via `/capitalize --retro`) :
- Pour chaque lesson capitalisée il y a 30j+ : preuve d'application réelle ?
- Lessons jamais référencées dans 30j+ → flag `expiration: review:<date>` à pousser
- Conflit révélé par évolution code → trigger /decision pour arbitrage

---

## 3. Format canonique d'un fichier memory écrit par /capitalize

**Pour `feedback_*.md`** (règle durable) :

```markdown
---
name: <Nom court>
description: <1 ligne pour matching futur>
type: feedback
originSessionId: <session UUID si dispo>
---

# <Titre>

<Règle énoncée frontalement, 1-2 lignes>

**Why:** <raison/incident/preuve>

**How to apply:** <quand/où ce s'applique>

**Evidence:** <test, repro, commit, citation>

**Expiration:** <date ou 'permanent' ou 'review:YYYY-MM'>

**Conflicts checked:** <fichiers vérifiés Phase 2>
```

**Pour `lessons_*.md`** (récap technique) :

```markdown
---
name: <Nom>
description: <1 ligne>
type: lessons
originSessionId: <UUID>
---

# <Titre>

## Contexte
<…>

## Lessons durables
1. **<règle>** — <evidence brève>
2. ...

## Anti-patterns observés
<…>

## Backlog post-session
<…>
```

---

## 4. Anti-patterns à éviter

| Anti-pattern | Pourquoi mauvais | Mitigation |
|--------------|------------------|------------|
| **Capitalize panini** | Tout devient lesson → spam memory | Phase 1 filtres rigueur (evidence + why obligatoires) |
| **Lesson orpheline** | Fichier ajouté sans entrée MEMORY.md | Phase 4 obligatoire pour C2+ |
| **Conflit silencieux** | 2 fichiers contradictoires non-détectés | Phase 2 dédup obligatoire |
| **Lesson sans evidence** | Règle = opinion sans preuve | Filtre Phase 1 strict |
| **MEMORY.md gonflement** | Entrées trop longues → truncation | Rule ≤200 chars, alerte si > 24 KB |
| **Lesson trop project-specific dans feedback global** | `feedback_*.md` global pollué par détails projet-X | Champ `scope` explicite + ranger dans `project_*.md` |
| **Pas d'expiration** | Lessons périmées (« BGE-M3 perdu post-recovery ») jamais purgées | Champ `expiration` obligatoire |
| **Capitalize bypass POLYLENS** | C0 sans audit consistency = risque | Phase 3 audit POLYLENS lite obligatoire C0 |
| **Lesson dupliquée** | Même règle dans 3 feedback_*.md | Phase 2 merge plutôt que ajout |
| **Capitalize avant Check** | ACT sans audit fait des dommages durables | Si invoqué hors PDCA, vérifier source = audit/ADR/incident résolu |

---

## 5. Auto-graduation — matrice de décision rapide

| Tu sors de... | Probable graduation |
|---------------|---------------------|
| Bug fix simple, surprise minime | C3 ou skip |
| Sprint dense avec 5-10 lessons techniques | C2 |
| Audit POLYLENS avec 3 P0 confirmés | C1 |
| Incident production résolu (root cause + fix) | C1 |
| Refonte méthodologique (nouvelle convention skills) | C0 |
| Décision DEVCODE P0 médico-juridique | C0 |
| Conflit révélé entre 3 feedback_*.md existants | C0 |

---

## 6. Exemples d'utilisation

### Cas C3 — Trivial

```
User : ah tiens je note que `find -regex` veut le longest pattern d'abord pour matcher .tsx avant .ts. /capitalize

Agent (/capitalize) :
[Phase 0] Source = correction technique session
[Phase 1] 1 lesson :
  title: "find -regex avec alternation : longest pattern d'abord (sinon .tsx skipped)"
  type: lessons
  scope: cross-project
  evidence: "Documenté dans claude-code Bash tool prompt"
  expiration: permanent
[Phase 2] Search memory : aucun match
[Phase 3] C3 (1 lesson, scope cross-project mais petit, pas d'update conventions)
[Phase 4] Append à `lessons_durable_rules.md` (fichier consolidation existant)
[Phase 5] Log JSONL
→ Pas d'update MEMORY.md (entrée lessons_durable_rules.md déjà indexée)
```

### Cas C1 — Important (cas typique post-Sprint 3.1)

```
User : on capitalise les 9 lessons WAL/HDD/SET-diff de Sprint 3.1.

Agent (/capitalize) :
[Phase 0] Source = lessons_session_20260504_05_sprint31_full_run.md
[Phase 1] Extraction 9 lessons candidates avec evidence (commit + scripts)
[Phase 2]
  - 6 lessons nouvelles (WAL truncate, SET-diff, drop-indexes-pre-bulk, …)
  - 2 lessons compatibles avec feedback_methodo_stricte.md → merge en section dédiée
  - 1 lesson conflit potentiel avec lessons_sqlite_perf_anti_patterns.md → merge
[Phase 3] C1 : merge cross-fichier (2 fichiers feedback existants), 1 nouveau,
          propagation MedData + medcorpus
[Phase 4]
  - Update feedback_methodo_stricte.md (section "Bulk maintenance HDD")
  - Update lessons_sqlite_perf_anti_patterns.md (SET-diff > NOT EXISTS)
  - Create feedback_bulk_maintenance_hdd.md (consolidation 9 lessons)
  - Update MEMORY.md (1 nouvelle entrée + 2 entrées existantes maj)
  - ADR meddata : docs/ADR/20260505_sprint31_fts5_lessons.md
[Phase 5] Log JSONL + flag retro 30j
```

### Cas C0 — Critique (cas méta-PDCA actuel)

```
User : conçois /capitalize de manière autonome, applique PDCA à sa création.

Agent (/capitalize sur sa propre création) :
[Phase 0] Source = session de design + auto-audit POLYLENS lite
[Phase 1] Lessons :
  1. PDCA fermé : trilogie POLY devient quatuor avec /capitalize
  2. Anti-pattern « lesson orpheline » formalisé
  3. Format canonique lesson YAML standardisé
  4. Auto-graduation C0-C3 alignée avec /decision
  5. Filtre rigueur evidence + why obligatoires
[Phase 2] Aucun match (skill inexistant), conventions skills à étendre
[Phase 3] C0 : nouveau skill, change conventions globales, propagation cross-skill
[Phase 4]
  - Create feedback_capitalize_method.md (référence canonique)
  - Update MEMORY.md (entrée /capitalize sous Skills personnalisés)
  - Update project_skills.md (ajouter 10ᵉ skill)
  - Update conventions.md skills (section /capitalize)
  - ADR : devcode docs/ADR/20260505_capitalize_skill.md
  - Audit POLYLENS lite sur memory consistency (B + F axes)
[Phase 5] Log + flag retro 30j
```

---

## 7. Synergies avec autres skills

- **POLYLENS amont** : findings P0/P1 → input direct Phase 0 de /capitalize
- **POLYBUILD amont** : ADR Phase 7 → input direct (mécanismes causaux)
- **POLYPRISM amont** : décisions tactiques → ADR → /capitalize
- **/decision amont** : ADR DEVCODE-Vote → trace canonique
- **/retex amont** : debrief clinique → /capitalize prend le bilan en INPUT, jamais en parallèle. **Frontière** : /retex parcours C produit un bilan trimestriel narratif ; /capitalize l'extrait en lessons durables typées (feedback/lessons) avec evidence + expiration. Si bilan déjà classé en `lessons_*.md`, /capitalize le promeut éventuellement vers `feedback_*.md` après filtrage rigueur
- **/document aval** : si lesson C0 doit produire livrable opposable
- **/expertise aval** : si lesson révèle gap RAG SST à enrichir
- **/oriente** : si /capitalize invoqué sur input flou, renvoie vers /oriente d'abord

---

## 8. Cycle PDCA fermé

```
POLYPRISM (Plan)  →  POLYBUILD (Do)  →  POLYLENS (Check)  →  /capitalize (Act)
       ↑                                                               │
       └─────────────────────  feedback loop  ────────────────────────┘
```

**Boucle d'amélioration** : les lessons capitalisées C1+ alimentent :
- Réputation Glicko-2 par voix×domaine (input /decision)
- Calibration des seuils de graduation /decision et /capitalize elles-mêmes
- Anti-patterns POLYLENS (24+ aujourd'hui, ajoutés au fil des audits)
- Conventions skills globales

---

## 9. Auto-amélioration (méta)

Après chaque invocation, /capitalize **se capitalise lui-même** :
- Log JSONL en Phase 5 alimente l'analyse de ses propres patterns d'usage
- Tous les 90j : audit retro `/capitalize --retro --self` → identifier sur-déclenchements (panini), sous-déclenchements (lessons skippées), et drift de graduation

---

## 10. Statut & versions

- **v1** (2026-05-05) : version initiale, conçue par Claude Opus 4.7 en méta-PDCA. Plan/Do/Check internes, Act = ce skill lui-même.
- Roadmap v1.1 : intégrer search memory par embedding (BGE-M3 ou nomic-embed) pour Phase 2 dédup plus fine que grep.
- Roadmap v2 : déclenchement automatique post-POLYLENS (hook), avec preview + confirmation user avant write.

---

**Référence canonique** : `~/.claude/projects/-Users-radu/memory/feedback_capitalize_method.md`.

**Repo** : `~/Developer/projects/skills/capitalize/SKILL.md` (à pousser GitHub `reddepot/skills` quand réseau dispo).
