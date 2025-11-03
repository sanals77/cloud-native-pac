from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.get("/healthz")
def health():
    return jsonify({"status": "ok"}), 200

@app.get("/readyz")
def ready():
    return jsonify({"ready": True}), 200

@app.get("/")
def hello():
    return jsonify({"message": "Hello from API", "version": os.getenv("APP_VERSION", "dev")})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.getenv("PORT", 8080)))

