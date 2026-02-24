# /new-feature — Pipeline Spec-Driven Complet

Lance le pipeline spec-driven complet pour développer une nouvelle feature.

## Usage

```
/new-feature "description de la feature"
```

## Ce que fait cette commande

Orchestre les phases Requirements → Design → Tasks → Implémentation avec gates de validation utilisateur obligatoires entre chaque phase.

## Instructions pour Claude

Quand l'utilisateur invoque `/new-feature`, exécuter les étapes suivantes :

### Étape 0 — Préparer

1. Extraire le nom de la feature depuis la description (kebab-case)
2. Créer le répertoire `docs/specs/[feature-name]/`
3. Créer un TodoWrite avec les phases du pipeline
4. Afficher :
   ```
   🚀 Démarrage pipeline spec-driven : [feature-name]

   Phases :
   - [ ] Phase 1 : Requirements
   - [ ] Phase 2 : Design + Tasks
   - [ ] Phase 3 : Implémentation (N tâches)
   - [ ] Phase 4 : Review
   ```

### Étape 1 — Requirements (déléguer à spec-analyst)

Lancer un sous-agent `spec-analyst` avec le contexte minimal :
- La description de la feature
- Le contenu de `.claude/steering/product.md` si existant et rempli
- Instruction : "Générer `docs/specs/[feature]/requirements.md`. Do NOT reload steering files."

Après completion :
- Lancer `spec-requirements-validator` en READ-ONLY sur requirements.md
- Afficher le rapport de validation

**⛔ GATE 1 — Validation utilisateur obligatoire**
```
📋 Requirements générés. Rapport de validation : [score]/100

→ Options :
  [A] Approuver et passer au Design
  [B] Demander des modifications (préciser lesquelles)
  [C] Annuler
```
Attendre la réponse explicite de l'utilisateur avant de continuer.

### Étape 2 — Design + Tasks (déléguer à spec-architect)

Lancer un sous-agent `spec-architect` avec :
- `docs/specs/[feature]/requirements.md` (contenu complet)
- `.claude/steering/tech.md` + `structure.md` (si remplis)
- Instruction : "Générer design.md et tasks.md. Do NOT reload requirements."

Après completion :
- Lancer **en parallèle** `spec-design-validator` et `spec-task-validator`
- Afficher les deux rapports

**⛔ GATE 2 — Validation utilisateur obligatoire**
```
🏗️ Design + Tasks générés.
Validation design : [score]/100
Validation tasks : [score]/100 | N tâches | ~Xh estimées

→ Options :
  [A] Approuver et lancer l'implémentation
  [B] Demander des modifications
  [C] Annuler
```

### Étape 3 — Implémentation (boucle tâche par tâche)

Pour chaque tâche dans tasks.md :
1. Afficher : `🔨 Tâche X/N : [description]`
2. Lancer `spec-developer` avec :
   - La tâche spécifique uniquement
   - La section design pertinente (pas le design complet)
   - Instruction : "Implémenter UNIQUEMENT cette tâche, marquer [x], STOP"
3. Lancer `spec-tester` pour les tests
4. Si tests passent → tâche suivante
5. Si tests échouent → itérer avec spec-developer (max 2 tentatives)

Afficher la progression : `[X/N] tâches complétées`

### Étape 4 — Review finale

Afficher :
```
✅ Implémentation complète (N/N tâches)

→ Lancer /review pour la revue complète 5-agents ?
  [A] Oui, lancer /review maintenant
  [B] Non, je le ferai plus tard
```

## Gestion du contexte

Si le contexte atteint 70% pendant le pipeline :
1. Faire /save-state automatiquement
2. Informer l'utilisateur : "⚠️ Contexte à 70%. /save-state effectué. Recommande /clear puis /restore-state."
3. Laisser l'utilisateur décider
