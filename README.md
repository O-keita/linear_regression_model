# Student Performance Prediction 

## Mission
This project is dedicated to improving education in The Gambia through modern technology, leveraging Machine Learning (ML) and Artificial Intelligence (AI) to provide data-driven insights that enhance learning strategies. By analyzing key academic performance factors, this initiative aims to equip students, educators, and policymakers with tools to optimize study habits, improve teaching methods, and drive educational success through intelligent systems and predictive analytics.

EndpointLink: https://linear-regression-model-mlky.onrender.com/predict

Swagger UI Link: https://linear-regression-model-mlky.onrender.com/docs#/default/predict_predict_post

Demo Video Link: https://youtu.be/q6LNTgmegkk

## Dataset Description
The dataset explores the relationship between study habits, sleep patterns, extracurricular activities, and prior academic achievements with students' performance indices. This information helps in identifying key factors that contribute to success in academics, forming a strong foundation for personalized learning recommendations.

### Source
https://www.kaggle.com/datasets/nikhil7280/student-performance-multiple-linear-regression


## Dataset Characteristics
The dataset contains the following variables:
- **Hours Studied** - Time spent studying before an exam.
- **Previous Scores** - Past academic performance as an indicator of progress.
- **Extracurricular Activities** - Whether the student is engaged in activities outside academics.
- **Sleep Hours** - Amount of sleep before an exam.
- **Sample Question Papers Practiced** - The number of practice papers solved before an exam.
- **Performance Index** - The final outcome representing academic success.

## Data Richness
- **Volume**: The dataset contains sufficient records of 10000 entries(Rows) with 6 Columns to analyze academic performance trends.
- **Variety**: It captures diverse factors, including behavioral and academic influences, ensuring a holistic view of student performance.

## Visualizations
### 1. Correlation Heatmap
The **heatmap** below illustrates how each feature contributes to or correlates with the target variable, Performance Index:

- **Previous Scores** has the highest correlation value of **0.92**, indicating that prior academic performance is the strongest predictor of future performance. The positive correlation suggests that higher previous scores generally lead to higher performance indices.

- **Hours Studied** follows with a correlation of **0.37**, showing that increased study hours are associated with improved academic outcomes, though not as strongly as previous scores.

- **Extracurricular Activities** has the lowest correlation value of **0.02**. While its direct impact on the performance index is minimal, it still plays a role in a student's overall academic experience and well-being.


![download](https://github.com/user-attachments/assets/69e67d65-9200-4fb5-8684-daa31ac49646)




### 2. Boxplot Visualization

# Boxplot to show the distribution of our data

The boxplot below shows the graphical distribution of our student dataset, which helps us not only know the distribution of the dataset but also identify outliers that might hinder our predictions. As you can see, our data does not have any outliers, which would be points below the 25th percentile or above the 95th percentile. In the boxplot, we observe:

- Our highest **Hours Studied** is 9, indicating that the highest amount of time a student spends studying is 9 hours.

- The highest **previous score** is 99, showing that the best score a student has achieved is 99.

- The highest **sleep hours** is 9, which suggests that the maximum amount of sleep a student gets is 9 hours.

- The highest **sample questions practiced** is 10, indicating that the highest number of sample questions practiced by a student is 10.

On the other hand:

- The minimum **study hours** is 1, meaning the least amount of time spent on studying is 1 hour.

- The minimum **previous score** is 40, suggesting that the lowest score recorded by a student is 40.

- The minimum **sleep hours** is 4, meaning the least amount of sleep a student gets is 4 hours.

- The minimum **sample questions practiced** is 0, indicating that there are students who have not practiced any sample questions.

These values help us understand the overall spread and variability in the dataset, and knowing that there are no extreme outliers provides confidence in the integrity of the data.
![boxploy](https://github.com/user-attachments/assets/851e406d-063d-46be-ba7c-93f510104452)






## Potential Applications
- Personalized learning recommendations based on study patterns.
- Insights for educators to improve curriculum effectiveness.
- Research on the balance between extracurricular activities and academic success.
- Development of AI-driven tutoring systems to support students.
- Data-driven policymaking for educational reforms in The Gambia.

By leveraging this dataset, this project aims to refine educational strategies and improve student outcomes through data-driven insights and technological advancements.
---
# Running The App

### cloning the repo

```
git clone https://github.com/O-keita/linear_regression_model.git
```

### getting Started

```
cd Summative
```

### Run Backend

```
cd API
```

```
pip freeze -r requirements.txt
```

```
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

### Run FrontEnd

```
  cd ..
```
```
cd FlutterApp
```
```
flutter pub get
```
#### open IDE to run main.dart and select emulator
```
flutter run
```


## Thank You
