#!/data/data/com.termux/files/usr/bin/bash

# Nom du script: exec_html.sh
# Rôle: Lance un serveur HTTP minimaliste pour ouvrir la documentation HTML localement.

echo "--------------------------------------------------------"
echo "  🚀 Lancement du Serveur de Documentation Souveraine   "
echo "--------------------------------------------------------"

# 1. Vérification de Python (pour le serveur HTTP)
if ! command -v python &> /dev/null
then
    echo "ERREUR: Python n'est pas installé ou n'est pas dans le PATH."
    echo "Veuillez exécuter: pkg install python"
    exit 1
fi

# 2. Définition des Fichiers et Port
HTML_FILE="index_activation_complete.html" # Le fichier principal de la vitrine
REPORT_FILE="gemini_core_v2.7/cert/dependency_report_v2.7.html" # Le rapport d'audit
PORT=8000

# Vérification de la présence des fichiers critiques (ajustez si les chemins sont différents)
if [ ! -f "$HTML_FILE" ] && [ ! -f "$REPORT_FILE" ]; then
    echo "ERREUR: Fichiers de documentation critiques introuvables."
    echo "Assurez-vous que '$HTML_FILE' et '$REPORT_FILE' existent dans les chemins attendus."
    exit 1
fi

echo "Documentation HTML principale: $HTML_FILE"
echo "Rapport de Certification V2.7 R1: $REPORT_FILE"
echo "Port du serveur local: $PORT"

# 3. Fonction pour Ouvrir le Navigateur
open_browser() {
    # Détecte le type de système et ouvre l'URL correspondante.
    # Dans Termux, cela dépend souvent d'un navigateur installé et de l'outil 'termux-open'.
    URL="http://127.0.0.1:$PORT/$HTML_FILE"
    
    echo "Ouverture automatique de la page dans le navigateur (peut nécessiter 'termux-open' ou un environnement graphique)."
    echo "Si l'ouverture échoue, veuillez copier/coller l'URL suivante dans votre navigateur:"
    echo "  -> $URL"
    
    # Tentative d'ouverture pour les environnements mobiles (Termux)
    if command -v termux-open &> /dev/null; then
        termux-open "$URL" &
    else
        # Tentative pour les environnements Linux/macOS standards (pour la flexibilité)
        if command -v xdg-open &> /dev/null; then
            xdg-open "$URL" &
        elif command -v open &> /dev/null; then
            open "$URL" &
        fi
    fi
}

# 4. Lancement du Serveur en Arrière-Plan et Ouverture
echo "Démarrage du serveur Python SimpleHTTP sur le port $PORT..."
# Utilisation de 'nohup' et '&' pour lancer en arrière-plan et ne pas bloquer le terminal
nohup python -m http.server $PORT > /dev/null 2>&1 &

# Attendre un instant que le serveur démarre
sleep 2

# Ouvrir le navigateur
open_browser

# 5. Message de Clôture
SERVER_PID=$! # Récupère le PID du dernier processus lancé en arrière-plan
echo "Serveur démarré (PID: $SERVER_PID). Appuyez sur [Ctrl+C] ou [kill $SERVER_PID] pour l'arrêter."
echo "--------------------------------------------------------"

# Garder le terminal ouvert pour la surveillance (optionnel, mais utile pour voir le PID)
wait $SERVER_PID


