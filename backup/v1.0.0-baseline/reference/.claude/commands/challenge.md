# /challenge — Session de Challenge Architectural

Lance une session de challenge approfondi avec 3 agents pour valider les décisions architecturales avant implémentation.

## Usage

```
/challenge
/challenge [feature-name]
/challenge "description de la décision à challenger"
```

## Ce que fait cette commande

Lance **3 agents en parallèle** :
1. `challenger` (Opus) — devil's advocate, questions fondamentales
2. `pragmatist` (Sonnet) — anti-sur-engineering
3. `architect-reviewer` (Opus) — revue architecturale

Idéal à utiliser :
- Avant de commencer une feature importante
- Quand on hésite entre deux approches
- Après avoir écrit design.md et avant de valider
- Sur une décision technique qui nous semble complexe

## Instructions pour Claude

### 1. Identifier la cible du challenge

**Cas 1 : feature-name fourni**
- Lire `docs/specs/[feature]/design.md` comme base du challenge

**Cas 2 : description fournie**
- Utiliser la description comme contexte du challenge
- Demander si des specs existent déjà

**Cas 3 : sans argument**
- Demander : "Quel aspect du projet voulez-vous challenger ? Design d'une feature ? Architecture globale ? Une décision technique spécifique ?"

### 2. Lancer les 3 agents en parallèle

```
challenger : "Challenger cette architecture/décision : [contexte complet]"
pragmatist : "Évaluer la complexité et détecter l'over-engineering dans : [contexte]"
architect-reviewer : "Revue architecturale de : [contexte]"

Tous READ-ONLY. Do NOT modify files.
```

### 3. Rapport de challenge

```markdown
# Session Challenge — [Sujet]
Date : [date]

## Contexte challengé
[Résumé de ce qui a été analysé]

---

## 🔴 Challenger (Questions Fondamentales)

[Rapport complet challenger]

---

## 🟡 Pragmatist (Complexité)

[Rapport complet pragmatist]

---

## 🔵 Architect Reviewer (Architecture)

[Rapport complet architect-reviewer]

---

## Synthèse du Challenge

### Questions sans réponse (à adresser avant de continuer)
1. [Question de challenger]
2. [...]

### Simplifications recommandées
1. [Recommandation pragmatist]

### Points architecturaux à renforcer
1. [Point architect-reviewer]

### Verdict
[L'architecture/décision est-elle solide ? Que doit-on faire avant de procéder ?]

### Prochaines étapes suggérées
[ ] Répondre aux questions fondamentales
[ ] Ajuster le design si nécessaire
[ ] Relancer /spec-validate [feature] si design modifié
[ ] Procéder avec /new-feature si challenge passé
```

### 4. Faciliter la discussion

Après le rapport, proposer :
```
→ Voulez-vous approfondir un point spécifique ?
→ /spec-validate [feature] design — Si vous avez modifié design.md
→ /review — Après implémentation
```
