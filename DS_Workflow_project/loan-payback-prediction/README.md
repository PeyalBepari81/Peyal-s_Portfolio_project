🏦 Loan Payback Prediction — End-to-End Machine Learning Project

This project predicts whether a loan applicant will repay the loan or default, using financial and demographic features.
It demonstrates a complete end-to-end Data Science & Machine Learning workflow, from data exploration to model selection and evaluation.

🚀 Project Highlights

Complete Data Science & Machine Learning workflow

Extensive Exploratory Data Analysis (EDA)

Data preprocessing and feature engineering

Handling class imbalance using SMOTE

Multiple machine learning models trained and tuned

Hyperparameter tuning using RandomizedSearchCV

Model evaluation using Accuracy, Precision, Recall, F1-score, and ROC–AUC

Final model comparison and best model selection

📂 Dataset

Kaggle Playground Series – Season 5 Episode 11

🔗 https://www.kaggle.com/competitions/playground-series-s5e11

⚠ Note:
Due to GitHub file size restrictions, the dataset is not included in this repository.

Please download the dataset from Kaggle and place it in your working directory before running the notebook.

🧠 Project Workflow

Importing libraries and understanding the dataset

Exploratory Data Analysis (EDA)

Data cleaning and preprocessing

Feature engineering

Train–test split

Handling class imbalance using SMOTE

Model training

Hyperparameter tuning using RandomizedSearchCV

Model evaluation and comparison

Final conclusion

🔍 Machine Learning Models Implemented
Model	Hyperparameter Tuning	Status
Logistic Regression	✔	Completed
Random Forest	✔	Completed
XGBoost	✔	Completed
CatBoost	✔	Best Model
🏆 Best Performing Model

After training and tuning all models, CatBoost achieved the best overall performance with a strong balance between precision and recall, making it ideal for reducing false negatives in loan default prediction.

📦 Model File Notice

⚠ The Random Forest pickle file could not be uploaded due to GitHub size limitations.

You can recreate it by running the notebook.
All tuned hyperparameters are already included.

❗ Important Note for Making Predictions

The dataset contains an id column that must NOT be used during model training or prediction.

Recommended Prediction Workflow

Drop the id column

Pass the remaining features to the trained model

Add the id column back after prediction (if required)

🧪 Example Prediction Function


def make_prediction(df, model):

    ids = df['id']
    
    X = df.drop('id', axis=1)
    
    preds = model.predict(X)
    
    return pd.DataFrame({'id': ids, 'prediction': preds})

▶ How to Run This Project
Install dependencies
pip install -r requirements.txt

Launch Jupyter Notebook
jupyter notebook

Open the notebook
notebook/loan_payback.ipynb

📊 Results Summary

The complete performance comparison table is included in the notebook, along with:

Confusion Matrix

Classification Report

ROC–AUC score comparison

Key strengths and weaknesses of each model

🔮 Future Improvements

Probability calibration for better risk scoring

Deployment using FastAPI or Streamlit

Feature selection to further reduce overfitting

👤 Author

Peyal Bepari

M.Tech (Control Systems) — Jadavpur University
First Class with Distinction

