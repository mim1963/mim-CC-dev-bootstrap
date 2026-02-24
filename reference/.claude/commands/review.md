# /review — Comprehensive Review 5 Agents

Lance une revue complète du code avec 5 agents spécialisés en parallèle.

## Usage

```
/review
/review [chemin/fichier-ou-répertoire]
/review src/user-auth/
```

## Ce que fait cette commande

Lance **5 agents simultanément en parallèle** :
1. `architect-reviewer` — perspective architecturale
2. `code-reviewer` — qualité du code
3. `security-auditor` — vulnérabilités OWASP
4. `jenny` — conformité specs vs implémentation
5. `pragmatist` — sur-engineering et complexité inutile

Chaque agent est READ-ONLY et travaille indépendamment.
Les résultats sont consolidés en un rapport final.

## Instructions pour Claude

### 1. Déterminer le périmètre

Si un chemin est fourni → limiter la review à ce périmètre
Si pas de chemin → review de l'ensemble du projet (ou des fichiers récemment modifiés)

### 2. Lancer les 5 agents en parallèle

Utiliser Task pour lancer simultanément :

```
Lancer en parallèle :
- architect-reviewer : [périmètre]
- code-reviewer : [périmètre]
- security-auditor : [périmètre]
- jenny : [périmètre] + docs/specs/ pour la comparaison
- pragmatist : [périmètre]

Instruction commune : "Review READ-ONLY de [périmètre]. Do NOT reload context."
```

### 3. Collecter les rapports

Attendre que les 5 agents aient terminé.

### 4. Produire le rapport consolidé

```markdown
# Comprehensive Review — [Projet/Feature]
Date : [date]

## Scores

| Agent | Score | Verdict |
|-------|-------|---------|
| 🏗️ Architecture | XX/100 | [✅/⚠️/❌] |
| 📝 Qualité Code | XX/100 | [✅/⚠️/❌] |
| 🔒 Sécurité | [CRITIQUE/ÉLEVÉ/MODÉRÉ/FAIBLE] | [✅/⚠️/❌] |
| ✅ Conformité Specs | XX% | [✅/⚠️/❌] |
| 🧹 Simplicité | XX/100 | [✅/⚠️/❌] |

**Score Global** : XX/100

---

## Actions Requises (P1 — avant merge)

[Consolidation des problèmes critiques de tous les agents]
1. [Problem] — Source : [architect/code/security/jenny/pragmatist]

## Actions Recommandées (P2 — planifier)

[...]

## Améliorations Optionnelles (P3 — backlog)

[...]

---

## Rapports Détaillés

<details>
<summary>🏗️ Architecture Review (architect-reviewer)</summary>
[Rapport complet architect-reviewer]
</details>

<details>
<summary>📝 Code Review (code-reviewer)</summary>
[Rapport complet code-reviewer]
</details>

<details>
<summary>🔒 Security Audit (security-auditor)</summary>
[Rapport complet security-auditor]
</details>

<details>
<summary>✅ Conformité Specs (jenny)</summary>
[Rapport complet jenny]
</details>

<details>
<summary>🧹 Pragmatisme (pragmatist)</summary>
[Rapport complet pragmatist]
</details>
```

### 5. Proposer les prochaines étapes

Si des problèmes P1 sont détectés :
```
⚠️ N problèmes critiques détectés — correction recommandée avant merge
→ /challenge  — Pour un challenge architectural approfondi
→ /team-review --focus security  — Pour un focus sécurité
```

Si tout est OK :

Vérifier si git est activé :
```bash
grep -q "git_enabled.*true" docs/state/active-session.md 2>/dev/null && echo "GIT_ON" || echo "GIT_OFF"
```

Si `GIT_OFF` :
```
✅ Review complète — Code prêt pour merge
```

Si `GIT_ON`, proposer :
```
✅ Review complète — Code prêt pour merge

Git — que faire de cette branche ?
  [A] Créer un commit de jalon "chore: review passed" + afficher les instructions de merge
  [B] Je gère le merge manuellement
```

Si l'utilisateur choisit [A] :
```bash
git commit --allow-empty -m "chore: review passed"
```
Puis afficher :
```
📦 Commit de jalon créé.

Pour merger :
  git checkout main
  git merge [branche-courante]
  # ou ouvrir une PR si un remote est configuré
```
