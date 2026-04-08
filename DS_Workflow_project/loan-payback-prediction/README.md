**🏦 Loan Payback Prediction — End-to-End Machine Learning Project**

This project predicts whether a loan applicant will repay the loan or default, using financial and demographic features.
It demonstrates a complete end-to-end Data Science & Machine Learning workflow, from data exploration to model selection and evaluation.


**🚀 Project Highlights**


Complete Data Science & Machine Learning workflow

Extensive Exploratory Data Analysis (EDA)

Data preprocessing and feature engineering

Handling class imbalance using SMOTE

Multiple machine learning models trained and tuned

Hyperparameter tuning using RandomizedSearchCV

Model evaluation using Accuracy, Precision, Recall, F1-score, and ROC–AUC

Final model comparison and best model selection


**📂 Dataset**


Kaggle Playground Series – Season 5 Episode 11

🔗 https://www.kaggle.com/competitions/playground-series-s5e11

⚠ Note:
Due to GitHub file size restrictions, the dataset is not included in this repository.

Please download the dataset from Kaggle and place it in your working directory before running the notebook.

**🧠 Project Workflow**


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

**🔍 Machine Learning Models Implemented**


Model	Hyperparameter Tuning	Status

Logistic Regression	✔	Completed

Random Forest	✔	Completed

XGBoost	✔	Completed

CatBoost	✔	Best Model


🏆 Best Performing Model

After training and tuning all models, CatBoost achieved the best overall performance with a strong balance between precision and recall, making it ideal for reducing false negatives in loan default prediction.

**📦 Model File Notice**

⚠ The Random Forest pickle file could not be uploaded due to GitHub size limitations.

You can recreate it by running the notebook.
All tuned hyperparameters are already included.

❗ Important Note for Making Predictions

The dataset contains an id column that must NOT be used during model training or prediction.

Recommended Prediction Workflow

Drop the id column

Pass the remaining features to the trained model

Add the id column back after prediction (if required)

**🧪 Example Prediction Function**


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

**📊 Results Summary**

Model Performance Comparison
All models were tuned using RandomizedSearchCV to identify the optimal hyperparameters before evaluation.
The table below summarizes the performance of each optimized model:

Model	Validation Accuracy	Precision	Recall	F1-Score	ROC–AUC	Test Accuracy	Key Strength
Logistic Regression	0.8571	0.9394	0.8777	0.9075	0.911	0.8269	Simple baseline, high precision
Random Forest	0.8812	0.9273	0.9238	0.9255	0.907	0.8151	Higher recall than LR, fewer false negatives
XGBoost	0.8788	0.9285	0.9191	0.9237	0.907	0.8215	Balanced precision & recall, stable boosting
CatBoost	0.8899	0.9240	0.9395	0.9316	0.911	0.8148	Best recall & lowest false negatives



**🔮 Future Improvements**


Probability calibration for better risk scoring

Deployment using FastAPI or Streamlit

Feature selection to further reduce overfitting

**👤 Author**


Peyal Bepari

M.Tech (Control Systems) — Jadavpur University
First Class with Distinction

