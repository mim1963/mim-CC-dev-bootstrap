# /restore-state — Restaurer le Contexte après /clear

Recharge le contexte complet depuis `docs/state/active-session.md` en une seule réponse.

## Usage

```
/restore-state
/restore-state snapshots/session-20260223-142301.md
```

## Ce que fait cette commande

Lit `docs/state/active-session.md` (ou un snapshot spécifique) et restaure le contexte de la session en une réponse complète et structurée.

## Instructions pour Claude

### 1. Lire le fichier d'état

```
Read docs/state/active-session.md
```

Si un snapshot est spécifié :
```
Read docs/state/snapshots/[fichier-snapshot]
```

Si `active-session.md` n'existe pas ou est vide :
```
⚠️ Aucun état sauvegardé trouvé.

Snapshots disponibles :
[Glob docs/state/snapshots/*.md → lister avec dates]

Utilisez : /restore-state snapshots/[nom-snapshot]
Ou relancez /init-project pour démarrer un nouveau projet.
```

### 2. Restaurer le contexte

Produire une réponse complète qui recharge le contexte :

```markdown
# ✅ Contexte Restauré — [Projet]

## Situation au moment de la sauvegarde

**Projet** : [nom] — [description courte]
**Stack** : [technologies]
**Sauvegardé** : [date + heure]

---

## Travail en cours

**Feature** : [nom-feature]
**Phase** : [requirements/design/tasks/implémentation/review]
**Spec active** : `docs/specs/[feature]/[phase].md`

---

## Prochaine action

**Tâche suivante** : [description précise]
**Fichier(s) concerné(s)** : [chemin(s)]

```
Pour continuer, lancer :
[commande à exécuter pour reprendre]
```

---

## État des tâches

```
[Extrait du tasks.md avec les [x] et [ ]]
```

---

## Décisions importantes à retenir

1. [Décision 1] — [Raison]
2. [Décision 2] — [Raison]

---

## Problèmes en suspens

- [Problème ou "Aucun"]

---

## Bugs actifs

| Bug | Statut | Prochaine étape |
|-----|--------|-----------------|
| [nom] | [phase] | /bug-[action] [nom] |

---

## Pour continuer immédiatement

[Instructions concrètes sur quoi faire maintenant, dans l'ordre]
```

### 3. Proposer les prochaines étapes

Terminer par :
```
→ Contexte fully restored. Quelle est votre première action ?
  Suggestion : [action basée sur "prochaine tâche"]
```

### 4. Cas d'état incomplet

Si certaines sections sont vides dans active-session.md :
- Compléter avec "Non renseigné" ou chercher dans les specs/code
- Mentionner les sections manquantes pour que l'utilisateur les renseigne si nécessaire
