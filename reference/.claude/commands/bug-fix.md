# /bug-fix — Correction Ciblée du Bug

Applique la correction définie dans analysis.md. Aucun scope creep.

## Usage

```
/bug-fix [bug-name]
/bug-fix login-error-500
```

## RÈGLE ABSOLUE

**No scope creep.** Corriger UNIQUEMENT ce qui est défini dans `analysis.md`.
Ne pas refactoriser le code environnant.
Ne pas "améliorer" d'autres choses pendant qu'on y est.
Ne pas changer le style du code non touché.

## Ce que fait cette commande

1. Lire `.claude/bugs/[bug-name]/analysis.md`
2. Appliquer la correction minimale
3. Écrire `.claude/bugs/[bug-name]/fix-notes.md`
4. Indiquer les tests à lancer

## Instructions pour Claude

### 1. Lire l'analyse

```
Read .claude/bugs/[bug-name]/analysis.md
```

Vérifier :
- La localisation exacte (fichier + lignes)
- Le plan de correction (correction minimale recommandée)
- Ce qu'il ne faut PAS faire

### 2. Appliquer la correction

**Avant de modifier** :
- Lire le fichier cible en entier
- Comprendre le contexte complet
- Confirmer que la correction de analysis.md est toujours valide

**Appliquer avec Edit** :
- Modifier uniquement les lignes identifiées
- Respecter le style existant
- Pas de refactoring

### 3. Vérifier la correction

Après modification :
- Relire le fichier modifié pour s'assurer que la logique est correcte
- Grep pour chercher des occurrences similaires du même bug ailleurs
  (Si trouvées, les documenter dans fix-notes.md sans les corriger automatiquement)

### 4. Créer `.claude/bugs/[bug-name]/fix-notes.md`

```markdown
# Fix Notes — [Titre]

**Bug** : [lien report.md]
**Analyse** : [lien analysis.md]
**Date correction** : [date]

---

## Correction Appliquée

**Fichier** : `[chemin/fichier.ext]`
**Lignes** : L[N]-L[N]

**Avant** :
```[code avant]```

**Après** :
```[code après]```

**Explication** : [pourquoi cette correction résout le problème]

## Occurrences Similaires Détectées

[Liste de fichiers avec un bug potentiellement similaire, à vérifier séparément]
- `[fichier:ligne]` — [description]

## Tests à Lancer

```bash
[commande de test à exécuter pour vérifier la correction]
```

## Test de Régression à Ajouter

```[langage]
# [description du test à ajouter dans le fichier de test approprié]
```

---

*Correction appliquée — Suite : /bug-verify [bug-name]*
```

### 5. Confirmer et proposer la suite

```
✅ Correction appliquée

Fichier modifié : [chemin]
Changement : [description courte]

Tests à lancer :
  [commande]

→ /bug-verify [bug-name]  — Vérifier la résolution complète
```
