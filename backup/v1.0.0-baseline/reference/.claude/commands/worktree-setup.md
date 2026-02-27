# /worktree-setup — Créer un Worktree Isolé par Feature

Crée un git worktree isolé pour développer une feature en parallèle sans affecter le worktree principal.

## Usage

```
/worktree-setup [feature-name]
/worktree-setup user-auth
/worktree-setup payment-flow --base main
```

## Pourquoi les worktrees

Les git worktrees permettent de :
- Travailler sur plusieurs features en parallèle
- Avoir des sessions Claude Code indépendantes par feature
- Éviter les conflits de fichiers entre sessions
- Partager l'historique git sans copier le repository

## Ce que fait cette commande

### Instructions pour Claude

### 1. Vérifier les prérequis

```bash
git status  # Vérifier qu'on est dans un repo git
git branch  # Lister les branches existantes
```

Si pas dans un repo git :
```
⚠️ /worktree-setup nécessite un repository git.
   Initialiser d'abord avec : git init
```

### 2. Créer le worktree

```bash
# Créer le worktree dans .claude/worktrees/[feature-name]
# Branch créée automatiquement depuis HEAD (ou --base si spécifié)
git worktree add .claude/worktrees/[feature-name] -b feature/[feature-name]
```

### 3. Initialiser la structure du worktree

Dans le nouveau worktree :
- Copier `.claude/steering/` (contexte projet partagé)
- Créer `docs/state/active-session.md` (état spécifique à ce worktree)
- Créer `docs/state/snapshots/` (snapshots de ce worktree)

### 4. Créer un fichier de contexte worktree

Créer `.claude/worktrees/[feature-name]/WORKTREE.md` :

```markdown
# Worktree — feature/[feature-name]

**Créé** : [date]
**Branch** : feature/[feature-name]
**Base** : [branch de base]
**Feature** : [description]

## Instructions de travail

Ce worktree est isolé du worktree principal.
- Modifications ici → branch `feature/[feature-name]`
- `/save-state` → sauvegarde dans ce worktree uniquement
- Pour merger : `git merge feature/[feature-name]` depuis main

## Démarrage rapide

Pour reprendre le travail dans ce worktree :
1. Ouvrir Claude Code dans `.claude/worktrees/[feature-name]/`
2. `/restore-state` pour recharger le contexte
3. Continuer avec `/new-feature [feature-name]`
```

### 5. Afficher les instructions

```
✅ Worktree créé : .claude/worktrees/[feature-name]/

Branch : feature/[feature-name]
Base : [branch]

Pour travailler dans ce worktree :
1. Ouvrir un nouveau terminal
2. cd ".claude/worktrees/[feature-name]"
3. claude  (ou Code . si VSCode)

Pour lister les worktrees actifs :
  git worktree list

Pour supprimer ce worktree (après merge) :
  git worktree remove .claude/worktrees/[feature-name]
  git branch -d feature/[feature-name]
```

## Gestion des worktrees existants

Si un worktree existe déjà pour cette feature :
```
⚠️ Worktree existant détecté pour [feature-name]
   Chemin : .claude/worktrees/[feature-name]

→ Reprendre le worktree existant ? [O/N]
```
