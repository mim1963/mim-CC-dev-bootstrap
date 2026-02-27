# /init-project — Initialiser le Projet

Initialise les fichiers steering avec les informations du projet courant. À lancer en début de projet ou quand les fichiers steering sont encore vides.

## Usage

```
/init-project
/init-project --auto
```

## Ce que fait cette commande

Remplit `.claude/steering/product.md`, `tech.md`, et `structure.md` avec les informations réelles du projet.

## Instructions pour Claude

### 1. Explorer le projet

```
Glob "**" → cartographier la structure
Glob "package.json|requirements.txt|Cargo.toml|go.mod|pyproject.toml"
Read [fichier de config trouvé]
Glob "README.md|README*"
Read README.md si présent
```

### 2. Mode interactif (défaut)

Poser les questions par section :

**Section Produit** :
```
Pour remplir product.md, j'ai besoin de :

1. Nom du projet : [déjà détecté depuis package.json/README ?]
2. Description courte (1-2 phrases) :
3. Objectif principal (quel problème résout-il ?) :
4. Utilisateurs cibles :
5. Fonctionnalités clés du MVP (liste) :
6. Ce que le projet ne fait PAS (hors scope) :
```

**Section Tech** :
```
Pour remplir tech.md (certains éléments ont été auto-détectés) :

Stack détectée :
- Langage : [Python 3.x / Node.js X / etc.]
- Framework : [FastAPI / Express / etc.]
- Config trouvée : [fichiers de config détectés]

À confirmer/compléter :
1. Base(s) de données :
2. Infrastructure / déploiement :
3. Framework de test :
4. Conventions de code (linter, formatter) :
```

**Section Structure** :
```
Pour remplir structure.md, j'ai analysé le projet :

Structure détectée :
[Arborescence des principaux répertoires]

À confirmer :
1. Répertoire du code source principal :
2. Répertoire des tests :
3. Conventions de nommage (snake_case/camelCase/etc.) :
4. Patterns architecturaux utilisés :
5. Fichiers critiques à ne pas modifier sans revue :
```

### 3. Mode `--auto`

Sans interaction, remplir les steering files avec ce qui peut être détecté automatiquement, et indiquer les sections qui nécessitent une saisie manuelle.

### 4. Écrire les steering files

Utiliser Write pour remplir les 3 fichiers avec les informations collectées.

### 5. Mettre à jour CLAUDE.md si nécessaire

Si des informations dans CLAUDE.md sont maintenant obsolètes ou incorrectes, signaler à l'utilisateur de lancer `guardian` pour une mise à jour.

### 6. Confirmer

```
✅ Projet initialisé

Fichiers mis à jour :
- .claude/steering/product.md ✅
- .claude/steering/tech.md ✅
- .claude/steering/structure.md ✅

Prochaines étapes :
→ /new-feature "première feature" — Pour démarrer le développement
→ /status — Pour voir l'état du projet
```

### 7. Commit steering (si git activé)

Vérifier si git est activé :

```bash
grep -q "git_enabled.*true" docs/state/active-session.md 2>/dev/null && echo "GIT_ON" || echo "GIT_OFF"
```

Si `GIT_ON` :

```bash
git add .claude/steering/
git commit -m "chore(steering): initialisation fichiers projet"
```

Afficher : `📦 Git : commit steering créé — structure projet versionnée`

Si `GIT_OFF` : ne rien faire.
