# /team-review — Revue Focalisée par Équipe

Lance une revue focalisée sur un aspect spécifique avec les agents les plus pertinents.

## Usage

```
/team-review --focus security
/team-review --focus architecture
/team-review --focus quality
/team-review --focus all
/team-review --focus specs
```

## Configurations par focus

### `--focus security`

Agents lancés :
- `security-auditor` (Opus) — audit OWASP complet
- `code-reviewer` (Opus) — focus sur les pratiques sécurisées

Contexte : "Focus sécurité — OWASP Top 10 + pratiques de code sécurisé"

### `--focus architecture`

Agents lancés :
- `architect-reviewer` (Opus) — revue architecturale approfondie
- `challenger` (Opus) — challenge des décisions

Contexte : "Focus architecture — patterns, SOLID, scalabilité, décisions"

### `--focus quality`

Agents lancés :
- `code-reviewer` (Opus) — qualité code
- `pragmatist` (Sonnet) — complexité et simplicité
- `coherence-checker` (Sonnet) — cohérence globale

Contexte : "Focus qualité — clean code, simplicity, cohérence"

### `--focus specs`

Agents lancés :
- `jenny` (Sonnet) — conformité implémentation vs specs
- `spec-requirements-validator` (Sonnet) — si requirements.md présent
- `spec-design-validator` (Sonnet) — si design.md présent

Contexte : "Focus conformité — specs vs implémentation"

### `--focus all`

Équivalent à `/review` — lance les 5 agents de base + coherence-checker.

## Instructions pour Claude

### 1. Parser le focus

Identifier le focus demandé. Si absent ou invalide :
```
Usage : /team-review --focus [security|architecture|quality|specs|all]
```

### 2. Lancer les agents appropriés en parallèle

Identifier le périmètre (fichier ou projet entier).
Lancer tous les agents du focus en parallèle avec Task.

### 3. Rapport focalisé

```markdown
# Team Review — Focus [SECURITY/ARCHITECTURE/QUALITY/SPECS]
Date : [date]

## Agents mobilisés
- [Agent 1] — [rôle]
- [Agent 2] — [rôle]

## Résultats

[Rapport de chaque agent]

## Synthèse Focus [X]

[Actions prioritaires pour ce focus]
[Score global sur ce focus]
```

## Combinaison de focus

```
/team-review --focus security --focus architecture
```
Lance les agents des deux focuses en parallèle et produit un rapport combiné.
