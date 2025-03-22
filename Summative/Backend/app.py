import fastapi
import joblib
import numpy as np
from pydantic import BaseModel, Field

app = fastapi.FastAPI()

# Load the trained model
model = joblib.load("models/linear_regression.pkl")

# Define request data model
class InputData(BaseModel):
    hours_studied: float = Field(..., ge=1, le=12)
    previous_scores: float = Field(..., ge=0, le=100)
    extracurricular_activities: float
    sleep_hours: float = Field(..., ge=4, le=10)
    sample_question_papers_practiced: float = Field(..., ge=0, le=10)


@app.post("/predict")
def predict(data: InputData):
    features = np.array([[ 
        data.hours_studied, 
        data.previous_scores, 
        data.extracurricular_activities, 
        data.sleep_hours, 
        data.sample_question_papers_practiced 
    ]])

    prediction = model.predict(features)
    return {"predicted_performance_index": prediction[0]}
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=5000)