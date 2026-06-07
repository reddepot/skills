---
name: veille
description: >
  Veille professionnelle automatisée santé-travail / médicale via RedAPI.
  Orchestre rss_poll (INRS, HAS, ANSM, Légifrance, BO Travail), anonymise les
  titres (défense en profondeur PII), indexe optionnellement dans embed_store,
  et envoie un digest Telegram / email. Peut être planifié via scheduler pour
  exécution quotidienne.
  DÉCLENCHEUR : /veille (toujours activer sans exception).
  IMPLICITES : « nouveautés RSS », « quoi de neuf INRS/HAS/ANSM »,
  « veille du jour », « digest veille », « alertes SST ».
  NE S'ACTIVE PAS : recherche documentaire ponctuelle (→ ai_search),
  analyse d'un article précis (→ /analyse), brainstorming (→ /brainstorming).
  SYNERGIE : /analyse en aval (approfondir une nouveauté),
  /document pour rédiger un résumé mensuel.
---

# /veille — Pipeline de Veille Automatisée — v1 (Architecture V3)

## Principe

`/veille` consomme les flux RSS métier via RedAPI, déduplique, anonymise
défensivement, indexe sémantiquement (optionnel), puis notifie. Une seule
exécution = un digest du jour. Idempotent : les entrées déjà vues ne sont
jamais renvoyées (dédup SQLite par URL normalisée).

## Flux

```
rss_poll (dedup)
    ↓
anonymize (PII défensive sur titres)
    ↓
embed_store.add (optionnel, collection "veille")
    ↓
webhook_notify → Telegram
```

L'outil MCP `veille_engine` expose ce pipeline en un seul appel.

## Usage

### Exécution one-shot (manuelle)

```
/veille
```

Claude appelle `veille_engine` avec les sources par défaut (INRS, HAS, ANSM,
Légifrance, BO Travail), notify = telegram, embed = false.

### Ciblé sur une thématique

```
/veille amiante, RPS, CMR
```

→ Claude appelle `veille_engine` avec `keywords=["amiante","RPS","CMR"]`
(filtre OR sur titre + résumé côté `rss_poll`).

### Sources spécifiques

```
/veille sources: has, ansm
```

→ Claude appelle avec `sources=["has_recommandations","ansm_actualites"]`.

### Digest + indexation sémantique

```
/veille index
```

→ `embed=true` : chaque titre anonymisé est indexé dans la collection
`veille` pour recherche sémantique ultérieure via `embed_store`.

### Planification quotidienne

```
/veille cron "0 8 * * *"
```

→ Claude crée une tâche `scheduler` qui exécute `veille_engine` chaque
matin à 08:00 UTC avec les paramètres par défaut (ou précédents).

## Livrable (format digest)

```
## 📡 Veille du YYYY-MM-DD — N nouveautés

### 🔴 À lire en priorité (si keywords)
- [HAS] Titre anonymisé — [lien]
- [INRS] Titre anonymisé — [lien]

### 🔵 Autres nouveautés
- [ANSM] …
- [Légifrance] …

### 📊 Stats
- Sources pollées : N/5
- Nouveautés : K
- Indexées : K (si embed=true)
- Erreurs : aucune / liste
```

## Paramètres MCP `veille_engine`

| Paramètre | Type | Défaut | Rôle |
|-----------|------|--------|------|
| `sources` | list[str] | toutes | Clés `rss_poll` (inrs_nouveautes, has_recommandations, ansm_securite, ansm_actualites, legifrance_sante_travail, bo_travail) |
| `keywords` | list[str] | — | Filtre OR titre + résumé |
| `notify_channel` | str\|null | `telegram` | `telegram` ou null |
| `notify_topic` | str | env | Chat/canal Telegram cible |
| `embed` | bool | false | Indexer dans embed_store |
| `embed_collection` | str | `veille` | Collection de destination |
| `max_notify_items` | int | 10 | Taille du digest |

## Garde-fous

- **Anonymisation défensive** : les titres RSS contiennent rarement des PII,
  mais le pipeline les passe systématiquement par `anonymize` (Niveau 1).
  Jamais de PII brute dans les notifications ni dans l'index sémantique.
- **Dédup strict** : `rss_poll` utilise un hash SHA-256 de l'URL normalisée.
  Une relance 5 min après ne produit aucun faux positif.
- **Best-effort embed** : un échec d'indexation n'interrompt pas le digest.
- **Rate limit feeds** : `rss_poll` respecte les ETags / Last-Modified.
- **Pas d'extraction full-text v1** : seuls les champs RSS sont utilisés.
  Roadmap v2 : fetch + extract contenu + classification LLM légère.

## Chainage

| Combinaison | Comportement |
|---|---|
| `/veille` + `/analyse` | Digest → approfondir une nouveauté précise |
| `/veille index` + `/brainstorming` | Corpus veille → idéation thématique |
| `/veille` + `/document` | Synthèse mensuelle basée sur l'index sémantique |

## Ce que /veille n'est PAS

- Pas un lecteur RSS interactif (→ client dédié)
- Pas une recherche (→ `ai_search`, `hybrid_research`)
- Pas un classifieur de pertinence LLM (v1 : filtre keywords seulement)
