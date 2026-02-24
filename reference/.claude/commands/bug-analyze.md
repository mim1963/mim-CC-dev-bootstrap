# /bug-analyze — Analyser la Cause Racine

Analyse la cause racine d'un bug documenté et produit un plan de correction ciblé.

## Usage

```
/bug-analyze [bug-name]
/bug-analyze login-error-500
```

## Ce que fait cette commande

1. Lire `.claude/bugs/[bug-name]/report.md`
2. Explorer le code pertinent
3. Identifier la cause racine
4. Produire `.claude/bugs/[bug-name]/analysis.md`

## Instructions pour Claude

### 1. Lire le rapport

```
Read .claude/bugs/[bug-name]/report.md
```

### 2. Explorer le code

En utilisant les fichiers suspectés et les étapes de reproduction :
```
Grep pour les patterns d'erreur mentionnés
Read les fichiers suspects
Grep pour le flux d'exécution lié au bug
```

### 3. Analyser la cause racine

Utiliser la méthode des **5 Pourquoi** :
- Pourquoi le bug se produit-il ? → [Symptôme]
- Pourquoi ce symptôme ? → [Cause intermédiaire]
- Pourquoi cette cause ? → [Cause profonde]
- Continuer jusqu'à trouver la cause racine

### 4. Créer `.claude/bugs/[bug-name]/analysis.md`

```markdown
# Analyse du Bug — [Titre]

**Bug** : [lien vers report.md]
**Date analyse** : [date]
**Analyste** : Claude

---

## Cause Racine

[Description précise de la cause racine en 2-3 phrases]

## Localisation

**Fichier principal** : `[chemin/fichier.ext]`
**Ligne(s)** : L[N]-L[N]
**Fonction/Méthode** : `[nom]`

## Analyse des 5 Pourquoi

1. **Symptôme** : [Ce qu'on observe]
2. **Cause** : [Pourquoi ça se produit]
3. **Cause** : [Pourquoi la cause précédente]
4. **Cause racine** : [La vraie origine]

## Impact

**Périmètre** : [Modules/fonctionnalités affectés]
**Régression possible** : Oui/Non — [explication]
**Tests affectés** : [liste des tests qui devraient couvrir ça]

## Plan de Correction

### Correction minimale (recommandée)
[Description de la correction la plus ciblée possible]
- Fichier : `[chemin]`
- Changement : [description précise]
- Risque : Faible/Moyen/Élevé

### Alternative (si la minimale n'est pas suffisante)
[Description de la correction alternative]

### À NE PAS FAIRE
- [Ce qui serait tentant mais mauvais]
- [Scope creep à éviter]

## Tests à Ajouter

- [ ] Test de régression : [description du test à ajouter]

---

*Analyse complète — Suite : /bug-fix [bug-name]*
```

### 5. Confirmer et proposer la suite

```
✅ Analyse complète : .claude/bugs/[bug-name]/analysis.md

Cause racine identifiée : [résumé en 1 phrase]
Localisation : [fichier:ligne]
Effort estimé : [S/M/L]

→ /bug-fix [bug-name]  — Appliquer la correction ciblée
```
