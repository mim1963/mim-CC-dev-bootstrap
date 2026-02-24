# /status — Tableau de Bord Projet

Affiche un tableau de bord complet de l'état du projet : features en cours, bugs actifs, prochaines actions.

## Usage

```
/status
/status --feature user-auth
/status --bugs
```

## Ce que fait cette commande

Lit le projet et génère un tableau de bord en temps réel.

## Instructions pour Claude

### 1. Collecter les données

```
Glob docs/specs/**/*.md          → features et phases
Glob .claude/bugs/*/report.md    → bugs et statuts
Read docs/state/active-session.md → session active
```

### 2. Générer le tableau de bord

```markdown
# Tableau de Bord — [Projet]
Généré : [date HH:MM]

---

## 📊 Vue d'ensemble

| Indicateur | Valeur |
|-----------|--------|
| Features en cours | N |
| Features complètes | N |
| Bugs actifs | N |
| Bugs résolus | N |

---

## 🚀 Features

| Feature | Phase | Tâches | Statut |
|---------|-------|--------|--------|
| [feature-1] | Implémentation | [3/7] ⬛⬛⬛⬜⬜⬜⬜ | 🔄 En cours |
| [feature-2] | Review | [7/7] ⬛⬛⬛⬛⬛⬛⬛ | ✅ Impl. complète |
| [feature-3] | Requirements | [0/0] | 📋 Specs |

**Feature active** : [nom] — Phase [X] — Prochaine tâche : [description]

---

## 🐛 Bugs Actifs

| Bug | Phase | Depuis | Priorité |
|-----|-------|--------|---------|
| [bug-1] | analyze | [date] | [Critique/Majeur/Mineur] |
| [bug-2] | fix | [date] | [Priorité] |

---

## ⏰ Prochaines Actions Suggérées

1. **[Action 1]** — [commande slash à lancer]
2. **[Action 2]** — [commande slash à lancer]
3. **[Action 3]** — [commande slash à lancer]

---

## 💾 Persistance

Dernier /save-state : [date + heure ou "Jamais"]
Snapshots disponibles : N (dans docs/state/snapshots/)

→ Rappel : /save-state avant /clear

---

## 🔧 Environnement Multi-Agent

Agents disponibles : 18
Commandes slash : 14
Stack : [depuis tech.md si rempli]
```

### 3. Mode `--feature`

Si `--feature [nom]` :
```
## Feature : [nom]

Spec : docs/specs/[nom]/
Phase actuelle : [phase]

### Requirements
[Résumé des user stories]

### Design
[Résumé de l'architecture]

### Tâches
[Liste complète avec [x] et [ ]]
  ✅ Task 1.1 : [desc]
  ✅ Task 1.2 : [desc]
  🔄 Task 2.1 : [desc] ← EN COURS
  ⏳ Task 2.2 : [desc]

Progression : 2/4 (50%)
Prochaine : Task 2.1
```

### 4. Mode `--bugs`

Si `--bugs` :
Liste tous les bugs avec leur dossier complet et la prochaine action pour chacun.
