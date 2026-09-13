from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

@app.route('/execute', methods=['POST'])
def execute():
    data = request.get_json()
    cmd = data.get("command", "")
    try:
        result = subprocess.getoutput(cmd)
        return jsonify({"output": result})
    except Exception as e:
        return jsonify({"output": f"Erreur: {str(e)}"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
