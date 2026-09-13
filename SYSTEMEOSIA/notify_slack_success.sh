#!/usr/bin/env bash
# ================================================================
# notify_slack_success.sh — Notification de Validation de Certification
# GEMINI CORE 2.7 PRO  |  Auteur : Zoubirou Mohammed Ilyes
# ================================================================

set -e
source .env 2>/dev/null || true

TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
HOSTNAME=$(hostname)
PROJECT_NAME=${PROJECT_NAME:-"GEMINI_CORE_2.7_PRO"}

PAYLOAD=$(cat <<EOF
{
  "attachments": [
    {
      "color": "#36a64f",
      "fallback": "✅ Certification réussie – $PROJECT_NAME",
      "title": "✅ Certification Souveraine – Version 2.7",
      "text": "Tous les modules ont été validés et certifiés.",
      "fields": [
        { "title": "Version", "value": "2.7", "short": true },
        { "title": "Statut", "value": "CERTIFICATION SUCCESSFUL", "short": true },
        { "title": "Noyau", "value": "GEMINI_CORE", "short": true },
        { "title": "Modules Validés", "value": "SOP_ENGINE, SECURITY_LAYER, DATA_AUDIT_ENGINE", "short": false },
        { "title": "Horodatage", "value": "$TIMESTAMP", "short": false },
        { "title": "Système", "value": "$HOSTNAME", "short": false }
      ],
      "footer": "NetSecurePro | Certification Continue Souveraine",
      "ts": $(date +%s)
    }
  ]
}
EOF
)

curl -s -X POST -H 'Content-type: application/json' \
    --data "$PAYLOAD" "$SLACK_WEBHOOK_URL" >/dev/null 2>&1 || \
    echo "⚠️ Impossible d’envoyer la notification Slack."
