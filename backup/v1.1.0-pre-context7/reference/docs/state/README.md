# Persistance d'État — Guide

Ce répertoire gère la **persistance du contexte** entre les sessions Claude Code.

---

## Problème résolu

Après un `/clear`, Claude Code perd tout le contexte conversationnel. Ce système
permet de sauvegarder l'état avant le clear et de le restaurer en une seule réponse.

## Fichiers

| Fichier | Rôle |
|---------|------|
| `active-session.md` | État de la session courante — pivot du système |
| `snapshots/` | Snapshots horodatés créés automatiquement par le hook PreCompact |

## Workflow type

```
Avant /clear :
  1. /save-state          → met à jour active-session.md
  2. Hook PreCompact       → copie automatiquement dans snapshots/ (si compaction)
  3. /clear               → contexte effacé

Après /clear :
  1. /restore-state       → lit active-session.md, recharge le contexte en une réponse
  2. Reprendre le travail  → contexte restauré
```

## Gestion des snapshots

- Le hook `PreCompact` crée automatiquement un snapshot horodaté avant chaque compaction
- Format : `snapshots/session-YYYYMMDD-HHMMSS.md`
- **Maximum 5 snapshots** conservés (les plus anciens sont supprimés automatiquement)
- En cas de corruption de `active-session.md`, utiliser le dernier snapshot

## Seuils de contexte

| Niveau | Action |
|--------|--------|
| < 50% | Zone idéale — continuer |
| 50–70% | Zone de vigilance — préparer /save-state |
| > 70% | /save-state IMMÉDIAT → /clear → /restore-state |

## Worktrees

Pour les features en parallèle, chaque worktree dispose de son propre état :
- Worktree principal : `docs/state/active-session.md`
- Worktrees feature : `.claude/worktrees/[feature]/active-session.md` (créés par /worktree-setup)

---

*Système custom — Couche 3 de l'environnement de dev multi-agent*
