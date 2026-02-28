# /doc-lookup — Consulter la Documentation d'une Librairie

Interroge la documentation à jour d'une librairie ou d'un framework via Context7.

## Usage

```
/doc-lookup [librairie] [question]
/doc-lookup react "how to use useEffect cleanup"
/doc-lookup express "middleware error handling"
/doc-lookup pytest "parametrize fixtures"
```

## Ce que fait cette commande

1. Résoudre le nom de la librairie en identifiant Context7
2. Interroger la documentation avec la question précise
3. Afficher les extraits pertinents avec exemples de code

## Instructions pour Claude

### 1. Résoudre la librairie

Appeler `mcp__plugin_context7_context7__resolve-library-id` avec :
- `libraryName` : le nom fourni par l'utilisateur
- `query` : la question de l'utilisateur

Sélectionner le résultat le plus pertinent parmi ceux retournés (priorité : correspondance de nom exacte, puis source reputation High, puis benchmark score élevé).

### 2. Interroger la documentation

Appeler `mcp__plugin_context7_context7__query-docs` avec :
- `libraryId` : l'ID retourné par resolve-library-id
- `query` : la question précise de l'utilisateur

### 3. Présenter le résultat

Format de réponse :

```
📚 Documentation — [Nom Librairie] (via Context7)

[Réponse synthétisée à la question]

---

**Exemples de code :**
[Extraits de code pertinents avec syntaxe mise en valeur]

---

**Source :** [libraryId] | Réputation : [High/Medium/Low]
```

## Cas d'usage courants

- Vérifier la signature exacte d'une fonction API
- Comprendre les breaking changes d'une version
- Trouver des exemples d'usage pour un pattern spécifique
- Confirmer les options de configuration d'un outil
- Chercher des patterns de test pour un framework

## Règle de qualité

Si `resolve-library-id` retourne plusieurs candidats proches, choisir celui avec :
1. Le meilleur `benchmarkScore`
2. La `sourceReputation` la plus haute (High > Medium > Low)
3. Le plus de `codesnippets` disponibles
