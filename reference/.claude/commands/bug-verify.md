# /bug-verify — Vérifier la Résolution du Bug

Vérifie que le bug est réellement résolu et que la correction n'a pas introduit de régression.

## Usage

```
/bug-verify [bug-name]
/bug-verify login-error-500
```

## Ce que fait cette commande

1. Lire report.md + analysis.md + fix-notes.md
2. Vérifier que la correction est en place
3. Confirmer les tests à lancer
4. Vérifier qu'il n'y a pas de régression
5. Mettre à jour le statut du bug

## Instructions pour Claude

### 1. Lire tout le dossier bug

```
Read .claude/bugs/[bug-name]/report.md
Read .claude/bugs/[bug-name]/analysis.md
Read .claude/bugs/[bug-name]/fix-notes.md
```

### 2. Vérifier la correction

- Lire le fichier corrigé (version actuelle)
- Confirmer que la correction de fix-notes.md est bien présente
- Vérifier que le code "avant" n'est plus là
- Vérifier qu'aucune régression évidente n'a été introduite

### 3. Vérification des tests

Afficher les commandes de test à lancer et demander à l'utilisateur de les lancer :

```
🔍 Vérification de la correction

Tests à lancer :
  [commandes depuis fix-notes.md]

Avez-vous lancé ces tests ?
[A] Oui, tous les tests passent ✅
[B] Oui, certains tests échouent ❌
[C] Non, pas encore
```

### 4. Vérification de la reproduction

Rappeler les étapes de reproduction du bug :

```
🔁 Vérification de la reproduction

Selon report.md, le bug se reproduisait en :
1. [Étape 1]
2. [Étape 2]
3. [Étape 3]

Avez-vous vérifié que le bug n'est plus reproductible ?
[A] Oui, le bug est résolu
[B] Non, le bug persiste
[C] Partiellement résolu
```

### 5. Verdict et mise à jour du statut

**Si résolu** :
- Ajouter dans report.md :
  ```
  **Statut** : RÉSOLU ✅
  **Date résolution** : [date]
  **Fix** : voir fix-notes.md
  ```
- Commit fix (si git activé) :
  ```bash
  grep -q "git_enabled.*true" docs/state/active-session.md 2>/dev/null && \
    git add -A && \
    git commit -m "fix: [bug-name]" || true
  ```
- Afficher :
  ```
  ✅ Bug [bug-name] RÉSOLU

  Résumé :
  - Cause racine : [1 phrase]
  - Correction : [1 phrase]
  - Tests : ✅ Passent
  - Régression : Aucune détectée

  Dossier : .claude/bugs/[bug-name]/
  ```

**Si non résolu** :
- Suggérer : "Le bug persiste. Recommande de relancer `/bug-analyze [bug-name]` pour approfondir l'analyse."
- Ne pas modifier le statut

**Si partiellement résolu** :
- Créer une note dans fix-notes.md sur ce qui reste
- Recommander `/bug-create` pour le problème restant
