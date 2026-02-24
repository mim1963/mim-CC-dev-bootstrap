# /spec-validate — Validation d'une Phase de Spec

Valide manuellement une phase de spec (requirements, design, ou tasks) à la demande.

## Usage

```
/spec-validate [feature-name] [phase]
/spec-validate user-auth requirements
/spec-validate payment-flow design
/spec-validate data-export tasks
/spec-validate user-auth all
```

## Paramètres

- `feature-name` : nom de la feature (correspond au répertoire `docs/specs/[feature-name]/`)
- `phase` : `requirements` | `design` | `tasks` | `all`

## Ce que fait cette commande

### Phase `requirements`

Lancer `spec-requirements-validator` sur `docs/specs/[feature]/requirements.md` en READ-ONLY.
Afficher le rapport complet de validation.

### Phase `design`

Lancer `spec-design-validator` sur `docs/specs/[feature]/design.md` en READ-ONLY.
Afficher le rapport complet de validation.

### Phase `tasks`

Lancer `spec-task-validator` sur `docs/specs/[feature]/tasks.md` en READ-ONLY.
Afficher le rapport complet de validation.

### Phase `all`

Lancer les 3 validators **en parallèle** :
- `spec-requirements-validator`
- `spec-design-validator`
- `spec-task-validator`

Afficher un rapport consolidé :
```
## Validation Complète — [feature]

### Requirements : [score]/100 [✅/⚠️/❌]
[Résumé des points clés]

### Design : [score]/100 [✅/⚠️/❌]
[Résumé des points clés]

### Tasks : [score]/100 [✅/⚠️/❌]
[Résumé des points clés]

## Score Global : [moyenne]/100
## Verdict : [PRÊT POUR IMPLÉMENTATION / CORRECTIONS NÉCESSAIRES]
```

## Instructions pour Claude

1. Vérifier que le fichier existe : `docs/specs/[feature]/[phase].md`
   - Si absent → "❌ Fichier non trouvé : `docs/specs/[feature]/[phase].md`"
2. Lancer le(s) validator(s) approprié(s)
3. Afficher le rapport complet
4. Proposer les prochaines étapes selon le verdict

## Cas sans paramètres

Si `/spec-validate` sans paramètres :
```
Usage : /spec-validate [feature] [phase]

Features disponibles :
[Lister les répertoires dans docs/specs/]

Phases : requirements | design | tasks | all
```
