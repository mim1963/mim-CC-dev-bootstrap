# /save-state — Sauvegarder l'État de Session

Sauvegarde l'état complet de la session courante dans `docs/state/active-session.md` avant un `/clear`.

## Usage

```
/save-state
```

## Quand utiliser

- Avant d'exécuter `/clear` (obligatoire)
- Quand le contexte approche 70%
- En fin de session de travail
- Avant de changer de feature

## Ce que fait cette commande

Mettre à jour `docs/state/active-session.md` avec l'état complet de la session.

## Instructions pour Claude

### 1. Collecter l'état actuel

Analyser la conversation courante et le projet pour récolter :

**Contexte projet** :
- Nom et description du projet
- Stack principale (lire tech.md si disponible)
- Répertoire de travail

**Travail en cours** :
- Feature ou tâche actuelle
- Phase du pipeline (requirements/design/tasks/impl/review)
- Fichier de spec actif

**État des tâches** :
- Lire `docs/specs/[feature]/tasks.md` pour les [x] et [ ]
- Identifier la prochaine tâche

**Décisions importantes** :
- Décisions architecturales prises pendant la session
- Choix techniques importants

**Blocages** :
- Problèmes en suspens
- Questions à résoudre

**Bugs actifs** :
- Lister les dossiers dans `.claude/bugs/` avec leur statut

### 2. Écrire `docs/state/active-session.md`

Remplir le template avec toutes les informations collectées.
Mettre à jour la ligne "Dernière mise à jour : [date + heure]".

### 3. Confirmer la sauvegarde

```
✅ État sauvegardé : docs/state/active-session.md
Heure : [HH:MM:SS]

Résumé :
- Projet : [nom]
- Feature active : [nom ou "Aucune"]
- Prochaine tâche : [description ou "N/A"]
- Bugs actifs : N

→ Vous pouvez maintenant faire /clear
→ Après /clear, utilisez /restore-state pour reprendre
```

### 4. Backup automatique

Créer également une copie dans `docs/state/snapshots/session-[YYYYMMDD-HHMMSS].md`
Supprimer les snapshots au-delà de 5 (conserver les 5 plus récents).

### 5. Métadonnées pipeline checkpoint

Si un pipeline est actif (ex: `/new-feature`), ajouter en fin de `active-session.md` :

```markdown
## CHECKPOINT METADATA

- **pipeline** : new-feature | bug-fix | none
- **feature_name** : [nom kebab-case]
- **phase** : requirements | design | implementation | review
- **task_current** : [X] (numéro tâche, 0 si pas en implémentation)
- **task_total** : [N]
- **gate_passed** : 1 | 2 | 3 | 4
- **next_action** : [commande exacte ou instruction pour reprendre]
```

Ces métadonnées permettent à `/restore-state` de proposer une reprise précise.

### 6. Écrire la sentinelle (si automatique)

Si le save-state est déclenché par un checkpoint automatique (contexte >= 50%) :
1. Écrire `docs/state/.pending-restore` avec le timestamp et le snapshot
2. Remettre le compteur : `echo 0 > docs/state/.checkpoint-counter`
3. Informer l'utilisateur que le restore se fera automatiquement après `/clear`
