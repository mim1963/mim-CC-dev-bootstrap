# Specs — Guide d'organisation

Ce répertoire contient les **spécifications structurées** de chaque feature, générées
par le pipeline spec-driven (Pimzino).

---

## Structure par feature

```
docs/specs/
  [nom-feature]/
    requirements.md    ← Phase 1 : Ce que le système doit faire (QUOI)
    design.md          ← Phase 2 : Comment le système le fait (COMMENT)
    tasks.md           ← Phase 3 : Liste de tâches atomiques (PAR QUOI COMMENCER)
```

## Cycle de vie d'une spec

```
1. /new-feature "description"
   └─ spec-analyst génère requirements.md
   └─ spec-requirements-validator valide [READ-ONLY]
   └─ [Validation utilisateur ⛔ obligatoire]

2. spec-architect génère design.md + tasks.md
   └─ spec-design-validator + spec-task-validator valident [READ-ONLY]
   └─ [Validation utilisateur ⛔ obligatoire]

3. spec-developer implémente 1 tâche → STOP ✋
   └─ spec-tester valide les tests
   └─ [Répéter jusqu'à complétion]

4. /review → revue complète 5 agents
```

## Format requirements.md

```markdown
# Requirements — [Nom Feature]
## Contexte
## User Stories
## Critères d'acceptance
## Contraintes
## Hors scope
```

## Format design.md

```markdown
# Design — [Nom Feature]
## Architecture overview
## Composants
## Flux de données
## API / Interfaces
## Décisions techniques
```

## Format tasks.md

```markdown
# Tasks — [Nom Feature]
## Phase 1 : [Nom phase]
- [ ] Task 1.1 : [Description atomique]
- [ ] Task 1.2 : [Description atomique]
## Phase 2 : [Nom phase]
- [ ] Task 2.1 : [Description atomique]
```

## Règles importantes

- **Chaque tâche dans tasks.md est atomique** : une tâche = 1 fichier ou 1 fonction
- **Ne jamais sauter de phase** : requirements → design → tasks → implémentation
- **Validation utilisateur obligatoire** entre chaque phase (gate explicite)
- **Les specs sont immuables** pendant l'implémentation (pas de scope creep)
- Nommer les features en **kebab-case** : `user-auth`, `payment-flow`, `data-export`

---

*Alimenté par le pipeline spec-driven — Agents spec-analyst + spec-architect*
