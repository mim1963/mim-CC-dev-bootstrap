# Environnement de Dev Claude Code — Multi-Agent

> Stack : Spec-Driven (Pimzino) + Quality Challenge (wshobson/darcyegb) + Persistance custom
> Modèles : Opus (critique) · Sonnet (exécution) · Haiku (opérationnel)
> Contexte : idéal < 50% · impératif < 70% → /save-state puis /clear

---

## WORKFLOWS PRINCIPAUX

### 1. Nouveau développement — Pipeline Spec-Driven

```
/new-feature "description"
  └─ orchestrator → spec-analyst   → requirements.md
       └─ spec-requirements-validator [READ-ONLY]
       └─ [Validation utilisateur obligatoire ⛔]
  └─ orchestrator → spec-architect  → design.md + tasks.md
       └─ spec-design-validator + spec-task-validator [READ-ONLY]
       └─ [Validation utilisateur obligatoire ⛔]
  └─ orchestrator → spec-developer  → 1 tâche → STOP ✋
       └─ spec-tester → tests unitaires → [Tests OK?]
       └─ [Répéter par tâche jusqu'à complétion]
  └─ /review → 5 agents simultanés en parallèle
```

### 2. Bug — Pipeline structuré

```
/bug-create → /bug-analyze → /bug-fix → /bug-verify
Fichiers : .claude/bugs/[nom]/{report,analysis,fix-notes}.md
```

---

## AGENTS (18 agents)

| Agent | Modèle | Rôle | Permissions |
|-------|--------|------|-------------|
| **orchestrator** | Opus | Coordinateur pipeline complet | Task, Read, Glob, Grep, TodoWrite |
| **spec-analyst** | Opus | Requirements → requirements.md | Read, Write, Glob, Grep |
| **spec-architect** | Opus | Architecture → design.md + tasks.md | Read, Write, Glob, Grep |
| **spec-developer** | Sonnet | Implémentation atomique (1 tâche → STOP) | Read, Write, Edit, Bash, Glob, Grep |
| **spec-tester** | Sonnet | Tests unitaires post-implémentation | Read, Bash, Glob, Grep |
| **tdd-orchestrator** | Sonnet | Cycle TDD red/green/refactor | Read, Bash, Glob, Grep |
| **spec-requirements-validator** | Sonnet | Valide Phase 1 [READ-ONLY] | Read, Glob, Grep |
| **spec-design-validator** | Sonnet | Valide Phase 2 [READ-ONLY] | Read, Glob, Grep |
| **spec-task-validator** | Sonnet | Valide Phase 3 [READ-ONLY] | Read, Glob, Grep |
| **architect-reviewer** | Opus | Revue architecturale [READ-ONLY] | Read, Glob, Grep |
| **code-reviewer** | Opus | Revue qualité code [READ-ONLY] | Read, Glob, Grep |
| **security-auditor** | Opus | Audit sécurité OWASP [READ-ONLY] | Read, Glob, Grep |
| **challenger** | Opus | Challenge architectural [READ-ONLY] | Read, Glob, Grep |
| **pragmatist** | Sonnet | Anti sur-engineering [READ-ONLY] | Read, Glob, Grep |
| **jenny** | Sonnet | Vérif impl vs specs [READ-ONLY] | Read, Glob, Grep |
| **karen** | Sonnet | Reality check complétude | Read, Bash, Glob, Grep |
| **coherence-checker** | Sonnet | Cohérence globale [READ-ONLY] | Read, Glob, Grep |
| **guardian** | Sonnet | Maintenance CLAUDE.md | Read, Edit, Glob, Grep |

---

## COMMANDES SLASH

| Commande | Description |
|----------|-------------|
| `/new-feature` | Pipeline spec-driven complet |
| `/spec-validate` | Valide une phase de spec |
| `/bug-create` | Documente un bug structuré |
| `/bug-analyze` | Analyse cause racine |
| `/bug-fix` | Correction ciblée (no scope creep) |
| `/bug-verify` | Vérifie la résolution |
| `/review` | 5-agent comprehensive review (parallèle) |
| `/team-review` | `--focus [security\|architecture\|quality\|all]` |
| `/challenge` | 3-agent challenge session |
| `/save-state` | Sauvegarde état avant /clear |
| `/restore-state` | Restauration contexte après /clear |
| `/status` | Tableau de bord projet |
| `/init-project` | Initialise les fichiers steering |
| `/worktree-setup` | Crée worktree isolé par feature |

---

## RÈGLES CRITIQUES

### Workflow Spec-Driven (Pimzino)
- **Phases non-sautables** : validation utilisateur obligatoire entre chaque phase
- **Stop after each task** : spec-developer implémente UNE tâche → marque [x] dans tasks.md → STOP
- **Délégation sélective** : transmettre uniquement le contexte minimal à chaque sous-agent (Do NOT reload full context)
- **Steering** dans `.claude/steering/` — ne charger qu'à la demande, pas en permanence
- **Specs** dans `docs/specs/[feature]/` → `requirements.md`, `design.md`, `tasks.md`

### Pipeline Bugs (Pimzino)
- Fichiers dans `.claude/bugs/[nom]/{report.md, analysis.md, fix-notes.md}`
- **No scope creep** : /bug-fix corrige UNIQUEMENT le bug documenté, rien d'autre

### Review (wshobson)
- `/review` = 5 agents **simultanés en parallèle** (architect-reviewer + code-reviewer + security-auditor + jenny + pragmatist)
- TDD = **RED → GREEN → REFACTOR** avec arrêt et confirmation utilisateur à chaque étape

### Gestion du contexte
- **< 50%** : zone idéale — continuer normalement
- **50–70%** : zone de vigilance — préparer /save-state
- **> 70%** : /save-state IMMÉDIAT → /clear → /restore-state
- Hooks PostToolUse : alerte automatique si seuils approchés

### Sécurité
- **Hooks** : ne jamais évaluer de variables input dans les hooks (`bash -c "... $VAR ..."` interdit)
- **Agents Bash** (spec-developer, karen, tdd-orchestrator) : confirmation explicite requise avant toute commande destructrice (`rm -rf`, `chmod`, `curl | bash`)
- **Isolation agents** : chaque agent reçoit uniquement le contexte minimal nécessaire — pas le contexte complet de session

---

## FICHIERS CLÉS

| Fichier | Rôle |
|---------|------|
| `.claude/steering/product.md` | Vision produit (charger à la demande) |
| `.claude/steering/tech.md` | Stack technique (charger à la demande) |
| `.claude/steering/structure.md` | Structure projet (charger à la demande) |
| `docs/state/active-session.md` | État session courante — pivot du système |
| `docs/state/snapshots/` | Snapshots PreCompact (5 derniers conservés) |
| `docs/specs/[feature]/` | Specs features : requirements/design/tasks |
| `.claude/bugs/[nom]/` | Pipeline bugs structuré |

---

*Maintenu automatiquement par l'agent **guardian***
