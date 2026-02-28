# /bug-create — Documenter un Bug Structuré

Crée un rapport de bug structuré dans `.claude/bugs/` pour lancer le pipeline de correction.

## Usage

```
/bug-create "description courte du bug"
```

## Ce que fait cette commande

1. Créer le répertoire `.claude/bugs/[bug-name]/`
2. Générer `report.md` avec les informations collectées
3. Afficher la prochaine étape (`/bug-analyze`)

## Instructions pour Claude

### 1. Générer le nom du bug

Transformer la description en kebab-case :
- "Login échoue avec erreur 500" → `login-error-500`
- "Bouton de paiement ne répond pas" → `payment-button-unresponsive`

### 2. Collecter les informations

Poser les questions suivantes si l'utilisateur ne les a pas fournies :
```
Pour documenter ce bug correctement, j'ai besoin de :
1. Comment reproduire le bug ? (étapes précises)
2. Comportement attendu : qu'est-ce qui devrait se passer ?
3. Comportement observé : qu'est-ce qui se passe réellement ?
4. Environnement : version, OS, navigateur, config spécifique ?
5. Message d'erreur exact ? (copier-coller si disponible)
6. Fréquence : toujours / parfois / rarement ?
```

### 3. Créer `.claude/bugs/[bug-name]/report.md`

```markdown
# Bug Report — [Titre]

**ID** : BUG-[YYYYMMDD]-[slug]
**Date** : [date]
**Statut** : REPORTED

---

## Description

[Description claire du bug en 2-3 phrases]

## Étapes de reproduction

1. [Étape 1]
2. [Étape 2]
3. [Étape 3]

## Comportement attendu

[Ce qui devrait se passer]

## Comportement observé

[Ce qui se passe réellement]

## Message d'erreur

```
[Message d'erreur exact ou "Aucun message d'erreur visible"]
```

## Environnement

- Version : [...]
- OS : [...]
- Stack : [...]
- Config : [...]

## Fréquence

[Toujours / Intermittent / Rare]

## Impact

[ ] Critique — Bloque l'utilisation
[ ] Majeur — Dégrade l'expérience
[ ] Mineur — Cosmétique ou contournable

## Fichiers suspectés

[Chemins vers les fichiers potentiellement impliqués, si connus]

---

*Créé avec /bug-create — Suite : /bug-analyze*
```

### 4. Confirmer et proposer la suite

```
✅ Bug documenté : .claude/bugs/[bug-name]/report.md

Prochaine étape :
→ /bug-analyze [bug-name]  — Analyser la cause racine
```
