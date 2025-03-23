import fastapi
import joblib
import numpy as np
from pydantic import BaseModel, Field
from fastapi.middleware.cors import CORSMiddleware

app = fastapi.FastAPI()


origins = [
    "https://linear-regression-model-mlky.onrender.com",  # Your frontend URL
]


app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["GET", "POST"],
    allow_headers=["*"],
)

# Load the trained model
model = joblib.load("models/best_model.pkl")

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