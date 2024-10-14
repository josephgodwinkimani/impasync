from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

@app.route('/sync', methods=['POST'])
def run_imapsync():
    data = request.get_json()
    if not data or 'source' not in data or 'destination' not in data:
        return jsonify({"error": "Please provide source and destination."}), 400

    source = data['source']
    destination = data['destination']
    
    command = [
        'imapsync',
        '--host1', source['host'],
        '--user1', source['user'],
        '--pass1', source['password'],
        '--host2', destination['host'],
        '--user2', destination['user'],
        '--pass2', destination['password']
    ]

    try:
        result = subprocess.run(command, capture_output=True, text=True)
        
        if result.returncode != 0:
            return jsonify({"error": result.stderr}), 500
        
        return jsonify({"output": result.stdout}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)