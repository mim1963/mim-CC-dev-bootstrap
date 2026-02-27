#!/usr/bin/env bash
# StatusLine script — persiste le % de contexte pour les hooks décisionnels
# Reçoit sur stdin le JSON de contexte envoyé par Claude Code

INPUT=$(cat)
PCT=$(echo "$INPUT" | jq -r '.context_window.used_percentage // 0' 2>/dev/null)

# Fallback si jq échoue ou retourne vide
if [ -z "$PCT" ] || [ "$PCT" = "null" ]; then
  PCT=0
fi

# Persiste le % pour que les hooks puissent le lire
STATE_DIR="docs/state"
mkdir -p "$STATE_DIR" 2>/dev/null
echo "$PCT" > "$STATE_DIR/.context-level"

# Affiche la statusLine avec indicateur visuel selon le seuil
if [ "$PCT" -ge 70 ] 2>/dev/null; then
  echo "Dev Multi-Agent | ctx:${PCT}% SAVE NOW | /save-state puis /clear"
elif [ "$PCT" -ge 50 ] 2>/dev/null; then
  echo "Dev Multi-Agent | ctx:${PCT}% CHECKPOINT | preparer /save-state"
else
  echo "Dev Multi-Agent | ctx:${PCT}% OK"
fi
