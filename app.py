from flask import Flask, request, jsonify
import joblib
import numpy as np

app = Flask(__name__)

model = joblib.load("model.pkl")


@app.route("/")
def home():
    return "✅ The Diabetes Prediction API is running ..."


@app.route("/predict", methods=["POST"])
def predict():
    print("✅ /predict route hit!")  # Log in console
    data = request.get_json(force=True)
    print("📦 Received data:", data)
    features = np.array(data["features"]).reshape(1, -1)
    prediction = model.predict(features).tolist()
    print("🎯 Prediction:", prediction)
    return jsonify({"prediction": prediction})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
