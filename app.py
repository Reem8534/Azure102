from flask import Flask, request, jsonify
from flask.logging import create_logger
import logging

import pandas as pd
from sklearn.preprocessing import StandardScaler
import joblib

app = Flask(__name__)
LOG = create_logger(app)
LOG.setLevel(logging.INFO)

def scale(payload):
    """Scales Payload"""
    LOG.info("Scaling Payload: %s", payload)
    scaler = StandardScaler().fit(payload)
    scaled_adhoc_predict = scaler.transform(payload)
    return scaled_adhoc_predict

@app.route("/")
def home():
    html = "<h3>Sklearn Prediction Home</h3>"
    return html  # Removed .format(format)

@app.route("/predict", methods=['POST'])
def predict():
    """Performs an sklearn prediction

    Expects JSON input like:
    {
        "CHAS": {"0": 0},
        "RM": {"0": 6.575},
        "TAX": {"0": 296.0},
        "PTRATIO": {"0": 15.3},
        "B": {"0": 396.9},
        "LSTAT": {"0": 4.98}
    }

    Returns:
    {
        "prediction": [20.35373177134412]
    }
    """
    try:
        clf = joblib.load("boston_housing_prediction.joblib")
    except Exception as e:
        LOG.error("Failed to load model: %s", e)
        return "Model not loaded", 500

    json_payload = request.json
    LOG.info("JSON payload: %s", json_payload)

    inference_payload = pd.DataFrame(json_payload)
    LOG.info("Inference payload DataFrame:\n%s", inference_payload)

    scaled_payload = scale(inference_payload)
    prediction = list(clf.predict(scaled_payload))
    LOG.info("Prediction: %s", prediction)

    return jsonify({'prediction': prediction})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)
