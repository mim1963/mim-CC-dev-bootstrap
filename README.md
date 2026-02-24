# dev-env-bootstrap

Skill Claude Code qui déploie l'environnement de dev multi-agent complet dans un nouveau projet.
Il a été réalisé à partir d'un état de l'existant complété par les conseils de Claude restitué dans le fichier "skills-programming-environments-prd0.md".

## Ce que ça fait

3 phases automatiques :
1. **Interview** — nom du projet, chemin destination, description optionnelle
2. **Déploiement** — copie depuis la référence embarquée dans le skill, mise à jour statusline, pré-remplissage steering
3. **Récapitulatif** — rapport de déploiement + instructions de démarrage

Contenu déployé : 18 agents + 14 commandes + 4 hooks + structure docs/.

## Utilisation

Depuis n'importe quelle session Claude Code :

> "Crée un nouveau projet appelé `mon-api-rest` dans `C:\Users\VotreNom\Documents\Projets\mon-api-rest`"

Claude déclenche le skill, copie tout depuis la référence embarquée (`reference/`), et guide vers :
- `/init-project` → configurer les fichiers steering
- `/new-feature "..."` → démarrer le premier développement

## Référence embarquée

Le skill contient une copie de référence complète dans `~/.claude/skills/dev-env-bootstrap/reference/`. Aucun répertoire maître externe n'est requis — le skill est totalement autonome.

**Pour mettre à jour les templates** : modifiez directement les fichiers dans `reference/`. Tout nouveau projet bootstrappé bénéficiera des mises à jour.

**Pour synchroniser depuis l'environnement maître** : après avoir amélioré des agents ou commandes dans votre env de dev, copiez les fichiers modifiés dans `reference/` manuellement.
