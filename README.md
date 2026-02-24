# dev-env-bootstrap

[![Version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/mim1963/mim-CC-dev-bootstrap/releases/tag/v1.0.0)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Skill-orange)](https://claude.ai)
[![Agents](https://img.shields.io/badge/agents-18-purple)](.claude/agents/)

Skill [Claude Code](https://claude.ai) qui déploie en **une phrase** un environnement de dev multi-agent complet dans un nouveau projet : 18 agents, 14 commandes slash, 4 hooks, pipeline spec-driven + review parallèle.

---

## Quick Start

```bash
# 1. Installer le skill
git clone https://github.com/mim1963/mim-CC-dev-bootstrap.git ~/.claude/skills/dev-env-bootstrap
```

```
# 2. Dans n'importe quelle session Claude Code, dire :
"Crée un nouveau projet mon-api dans C:\Users\VotreNom\Documents\Projets\mon-api"
```

```
# 3. Claude bootstrap tout — démarrer immédiatement avec :
/init-project    → renseigner le projet (vision, stack, structure)
/new-feature "…" → premier développement spec-driven
```

---

## Demo

> *GIF à venir — enregistré avec [Terminalizer](https://terminalizer.com/) ou [asciinema](https://asciinema.org/)*

Ce que Claude affiche à la fin du bootstrap :

```
✅ Environnement déployé : mon-api
📁 Emplacement : C:\Users\VotreNom\Documents\Projets\mon-api

Contenu déployé :
  • 18 agents    (.claude/agents/)
  • 14 commandes (.claude/commands/)
  • 4 hooks      (.claude/settings.json)
  • Steering     (.claude/steering/ — templates vides)
  • Docs         (docs/state/, docs/specs/)
  • .gitignore   (état session, bugs, settings.local, worktrees, build)
  • Git          (repo initialisé, commit initial créé)   ← si activé

Prochaines étapes :
  1. Ouvrir le dossier dans Claude Code
  2. /init-project          → configurer les fichiers steering
  3. /new-feature "..."     → démarrer le premier développement
```

---

## Ce que ça fait

3 phases automatiques :

1. **Interview** — nom du projet, chemin destination, description optionnelle, git O/N
2. **Déploiement** — copie depuis la référence embarquée, statusline personnalisée, steering pré-rempli, git init si activé
3. **Récapitulatif** — rapport de déploiement + instructions de démarrage

---

## Architecture déployée

| Composant | Quantité | Rôle |
|-----------|----------|------|
| Agents spec-driven | 9 | orchestrator, analyst, architect, developer, tester, tdd + 3 validators |
| Agents review | 5 | architect-reviewer, code-reviewer, security-auditor, jenny, pragmatist |
| Agents support | 4 | challenger, karen, coherence-checker, guardian |
| Commandes slash | 14 | /new-feature, /review, /bug-*, /save-state, /challenge… |
| Hooks | 4 | PreCompact, PostToolUse, Stop, SubagentStop |

### Pipelines inclus

```
/new-feature "description"
  → requirements.md → [validation] → design.md + tasks.md → [validation]
  → implémentation atomique (1 tâche → STOP) → tests unitaires → /review

/bug-create → /bug-analyze → /bug-fix → /bug-verify

/review  →  5 agents simultanés en parallèle
```

---

## Utilisation

Depuis n'importe quelle session Claude Code, formuler la demande naturellement :

- `"Crée un nouveau projet mon-api-rest dans C:\Users\VotreNom\Documents\Projets\mon-api-rest"`
- `"Bootstrap mon environnement de dev pour dashboard-rh"`
- `"Nouveau projet cli-converter dans ~/projets/cli-converter"`

Claude déclenche le skill, pose 4 questions en un bloc, puis déploie tout automatiquement.

---

## Référence embarquée

Le skill est **totalement autonome** : la référence complète est embarquée dans `~/.claude/skills/dev-env-bootstrap/reference/`. Aucun répertoire externe requis.

**Mettre à jour les templates** : modifier les fichiers dans `reference/`. Tout nouveau projet bootstrappé bénéficie des mises à jour.

**Synchroniser depuis un environnement maître** : copier les fichiers modifiés dans `reference/` après avoir amélioré des agents ou commandes dans votre env de dev.

---

## Prérequis

- [Claude Code](https://claude.ai) installé
- Git (pour le clonage du skill)
- Windows, macOS ou Linux

---

## License

[MIT](LICENSE)
