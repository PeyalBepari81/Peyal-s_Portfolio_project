**🏦 Loan Payback Prediction — A Complete Machine Learning Workflow**

This project predicts whether a loan applicant will repay the loan or default, based on financial and demographic features.
The workflow covers end-to-end Data Science and Machine Learning, including EDA, preprocessing, class imbalance handling, model training, hyperparameter tuning (Randomized Search), and model comparison.


***📌 Key Highlights of the Project***

✔ Full Data Science Workflow
✔ Multiple ML models tested and tuned
✔ RandomizedSearchCV for hyperparameter tuning
✔ SMOTE applied to handle class imbalance
✔ Performance comparison using Accuracy, Precision, Recall, F1-Score & ROC–AUC
✔ Final conclusion and best model selection


***📂 Dataset***

The project uses the Kaggle Playground Series – Season 5 Episode 11 dataset:
🔗 https://www.kaggle.com/competitions/playground-series-s5e11

⚠ Due to GitHub file size restrictions, the dataset is not uploaded to this repository.
Please download it from Kaggle and place it in your working directory before running the notebook.


***🧠 Project Workflow***

Importing Libraries & Understanding the Dataset

Exploratory Data Analysis (EDA)

Data Cleaning & Preprocessing

Feature Engineering

Train–Test Split

Handling Class Imbalance using SMOTE

Model Training

Hyperparameter Tuning using RandomizedSearchCV

Model Evaluation & Comparison

Final Conclusion

***🔍 Machine Learning Models Implemented***
Model	Tuning	Status
Logistic Regression	✔	Completed
Random Forest	✔	Completed
XGBoost	✔	Completed
CatBoost	✔	Completed (Best Model)


***🏆 Best Performing Model***

After training and tuning all models, CatBoost delivered the highest performance, with balanced precision and recall — ideal for reducing false negatives in loan default prediction.


***📦 Model File Notice***

⚠ The Random Forest saved pickle file could not be uploaded due to GitHub size limits.
You can recreate it by running the notebook; the hyperparameters used during tuning are already included.

❗ Important Note for Users Who Want to Run Predictions

The dataset contains an id column that should not be used during model training or prediction.

When making predictions:

Drop the id column

Pass remaining features to the trained model

After prediction, add the id column back if required

Example recommendation for prediction function:

def make_prediction(df, model):
    ids = df['id']
    X = df.drop('id', axis=1)
    preds = model.predict(X)
    return pd.DataFrame({'id': ids, 'prediction': preds})


***🚀 How to Run This Project***
pip install -r requirements.txt
jupyter notebook


Then open:

notebook/loan_payback.ipynb


***📊 Results Summary (Short)***

The complete performance comparison table is included in the notebook, along with:

Confusion matrix

Classification report

AUC score comparison

Key strengths of each model



***🔮 Future Improvements***

Probability calibration for better risk scoring

Deployment using FastAPI / Streamlit

Feature selection to further reduce overfitting



***👤 Author — Peyal Bepari  
M.Tech (Control Systems, Jadavpur University — First Class with Distinction)  
B.E (Electronics & Instrumentation, Jadavpur University — Honors, First Class Distinction)  
Passionate about Data Science, ML & AI***



***⭐ If you find this project helpful, consider giving the repository a star!***
