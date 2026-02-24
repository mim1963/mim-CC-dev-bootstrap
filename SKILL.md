---
name: dev-env-bootstrap
description: "Bootstrap un nouvel environnement de développement multi-agent Claude Code complet. Déploie depuis la référence embarquée dans le skill les 18 agents (spec-driven + review + challenge), 14 commandes (/new-feature, /review, /bug-*, /save-state…), hooks PreCompact/PostToolUse/Stop, et toute la structure docs/ — puis personnalise pour démarrer vierge. Utiliser quand l'utilisateur dit : 'crée un nouveau projet', 'bootstrap mon environnement de dev pour [projet X]', 'initialise un projet avec l'environnement multi-agent', 'nouveau projet de dev', ou 'déploie l'environnement dans [dossier]'."
---

# Bootstrap — Environnement de Dev Multi-Agent

Ce skill déploie l'environnement multi-agent complet dans un nouveau répertoire projet, depuis la référence embarquée (`reference/`).

## Configuration

**Source embarquée :** `~/.claude/skills/dev-env-bootstrap/reference/`

La référence est toujours disponible dans le skill lui-même — aucun chemin externe requis. Pour mettre à jour le template de référence, modifier les fichiers dans `reference/` directement.

## Phase 1 — Interview

**Avant de poser les questions**, utilise Bash pour vérifier que la référence embarquée est accessible :

```bash
MASTER_DEFAULT="$HOME/.claude/skills/dev-env-bootstrap/reference"
[ -d "$MASTER_DEFAULT" ] && echo "FOUND" || echo "NOT_FOUND"
```

- Si `FOUND` : pose les **3 questions** ci-dessous en un seul bloc.
- Si `NOT_FOUND` : la référence embarquée est absente — arrêter et informer l'utilisateur que le skill doit être réinstallé (la référence `reference/` manque dans `~/.claude/skills/dev-env-bootstrap/`).

Attends les réponses avant de passer à la Phase 2.

1. **Nom du projet** : Un identifiant court en kebab-case (ex. `mon-api-rest`, `dashboard-rh`, `cli-converter`). Ce nom sera utilisé dans la statusline et les fichiers de config.

2. **Chemin de destination** : Le chemin absolu complet du nouveau dossier (ex. `C:\Users\VotreNom\Documents\Projets\mon-api-rest`). Le dossier sera créé s'il n'existe pas.

3. **Description courte** (optionnel) : 1-2 phrases décrivant le projet. Utilisé pour pré-remplir les fichiers steering. Peut être laissé vide pour remplir manuellement via `/init-project`.

## Phase 2 — Déploiement

Une fois les réponses obtenues, exécute les étapes suivantes dans l'ordre.

### Étape 1 : Copie depuis la référence embarquée

Utilise l'outil Bash pour créer le dossier destination et copier la référence embarquée :

```bash
SOURCE="$HOME/.claude/skills/dev-env-bootstrap/reference"
DEST="[chemin-destination-en-forward-slashes]"

if [ ! -d "$SOURCE" ]; then
  echo "ERREUR: Répertoire maître introuvable : $SOURCE"
  exit 1
fi

mkdir -p "$DEST"
cp -r "$SOURCE/." "$DEST/"
echo "Copie terminée : $(ls "$DEST" | wc -l) éléments à la racine"
```

**Important (Windows)** : Convertis les chemins avec des forward slashes pour bash (ex. `C:\Users\VotreNom\...` → `c:/Users/VotreNom/...`).

### Étape 2 : Nettoyage des fichiers état

La référence embarquée est déjà un template vierge. Effectue un nettoyage défensif :

```bash
# Nettoyage défensif des snapshots (la référence n'en contient pas, mais garantit la propreté)
rm -f "$DEST/docs/state/snapshots/"*.md 2>/dev/null
touch "$DEST/docs/state/snapshots/.gitkeep"
echo "Snapshots vérifiés"
```

### Étape 3 : Création du .gitignore

Crée (ou remplace) le fichier `.gitignore` dans le répertoire destination pour garantir un contenu cohérent, indépendamment du contenu copié depuis le maître :

```bash
cat > "$DEST/.gitignore" << 'EOF'
# Session-specific state (données personnelles de session)
docs/state/active-session.md
docs/state/snapshots/*.md
!docs/state/snapshots/.gitkeep

# Permissions locales Claude Code (peut contenir des settings personnels)
.claude/settings.local.json

# Rapports de bugs (données projet spécifiques, code potentiellement sensible)
.claude/bugs/

# OS
.DS_Store
Thumbs.db
EOF
echo ".gitignore créé"
```

### Étape 4 : Personnalisation de la statusline

Mets à jour la statusline dans `[DEST]/.claude/settings.json` pour afficher le nom du projet. Utilise l'outil Edit pour remplacer la valeur existante :

**Valeur actuelle :**
```
"statusLine": "🏗️ Dev Multi-Agent | Opus·Sonnet·Haiku | ctx<50% idéal | /save-state avant /clear"
```

**Nouvelle valeur :**
```
"statusLine": "🏗️ [NOM-PROJET] | Multi-Agent | ctx<50% idéal | /save-state avant /clear"
```

### Étape 5 : Pré-remplissage steering (si description fournie)

Si l'utilisateur a fourni une description à la Phase 1, mets à jour `[DEST]/.claude/steering/product.md` : remplace les deux occurrences `[À remplir]` des champs **Nom du projet** et **Description** avec les valeurs fournies. Laisse le reste en `[À remplir]`.

### Étape 6 : Vérification finale

```bash
echo "=== Structure déployée ==="
echo "Agents    : $(ls "$DEST/.claude/agents/" | wc -l) fichiers"
echo "Commandes : $(ls "$DEST/.claude/commands/" | wc -l) fichiers"
echo "Snapshots : $(ls "$DEST/docs/state/snapshots/" | wc -l) fichiers (doit être 1 = .gitkeep)"
echo "Archives  : $(ls "$DEST/docs/archives/" 2>/dev/null | wc -l) fichiers (doit être 0)"
echo ".gitignore: $([ -f "$DEST/.gitignore" ] && echo "présent" || echo "ABSENT ⚠️")"
```

## Phase 3 — Récapitulatif et prochaines étapes

Affiche un récapitulatif concis :

```
✅ Environnement déployé : [NOM-PROJET]
📁 Emplacement : [CHEMIN-DESTINATION]

Contenu déployé :
  • 18 agents    (.claude/agents/)
  • 14 commandes (.claude/commands/)
  • 4 hooks      (.claude/settings.json)
  • Steering     (.claude/steering/ — templates vides)
  • Docs         (docs/state/, docs/specs/)
  • .gitignore   (état session, bugs, settings.local)

Prochaines étapes :
  1. Ouvrir le dossier dans Claude Code
  2. /init-project          → configurer les fichiers steering avec les infos du projet
  3. /new-feature "..."     → démarrer le premier développement
```

## Fichiers déployés (référence)

| Composant | Emplacement | État après déploiement |
|-----------|-------------|------------------------|
| CLAUDE.md | racine | Copié — générique, mis à jour par `/init-project` |
| 18 agents | `.claude/agents/` | Copiés intacts |
| 14 commandes | `.claude/commands/` | Copiées intactes |
| Hooks + statusLine | `.claude/settings.json` | Copié + statusLine mise à jour |
| Steering templates | `.claude/steering/` | Copiés (product partiellement pré-rempli si description fournie) |
| État session | `docs/state/active-session.md` | Copié — déjà un template vierge |
| Snapshots | `docs/state/snapshots/` | Répertoire vidé (sauf .gitkeep) |
| Archives | `docs/archives/` | Non inclus dans la référence embarquée |
| Specs | `docs/specs/README.md` | Copié intact |
| .gitignore | racine | **Créé explicitement** (état session, bugs, settings.local) |
