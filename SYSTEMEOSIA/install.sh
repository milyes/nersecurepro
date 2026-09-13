#!/bin/bash
# SYSTEMEOSIA — Installation CI/CD souveraine
# Auteur : Zoubirou Mohammed Ilyes | ORCID : 0009-0007-7571-3178

echo "🔁 Initialisation de SYSTEMEOSIA..."

# 📦 Étape 1 : Vérification des dépendances
REQUIRED=("python" "git" "curl" "coreutils" "tree")
for pkg in "${REQUIRED[@]}"; do
  if ! command -v "$pkg" &> /dev/null; then
    echo "📦 Installation de $pkg..."
    pkg install "$pkg" -y
  else
    echo "✅ $pkg déjà installé."
  fi
done

# 📂 Étape 2 : Initialisation des dossiers
mkdir -p archive logs cockpit/activated attestation/qr
echo "📁 Dossiers rituels prêts."

# 🧪 Étape 3 : Scellage initial
HASH=$(sha256sum IA22_architecture.md | awk '{print $1}')
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
SEAL="$TIMESTAMP | SHA256: $HASH | Signature: DZROUGE | Capsule: SYSTEMEOSIA"

echo "$SEAL" >> seal_history.log
echo "✅ Scellage effectué : $SEAL"

# 📜 Étape 4 : Génération du manifest.json
cat > manifest.json <<EOF
{
  "capsule": "SYSTEMEOSIA",
  "author": "Zoubirou Mohammed Ilyes",
  "orcid": "0009-0007-7571-3178",
  "timestamp": "$TIMESTAMP",
  "hash": "$HASH",
  "signature": "DZROUGE",
  "log": "seal_history.log"
}
EOF
echo "📦 manifest.json généré."

# 🏁 Fin
echo "🎯 Capsule SYSTEMEOSIA activée et scellée souverainement."
