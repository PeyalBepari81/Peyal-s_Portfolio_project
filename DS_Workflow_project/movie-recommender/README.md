
# 🎬 Movie Recommendation System
 

---

##  Project Overview

This project is a content-based movie recommendation system that suggests similar movies based on their features such as genres, keywords, cast, crew, and overview.

The goal of this project is to understand how Natural Language Processing (NLP) techniques can be applied to build a recommendation system and deploy it as an interactive web application.

---

##  Live Demo

👉 https://peyal-sportfolioproject-pahy3f9buhwqpw47xcaiiz.streamlit.app/

---

##  Problem Statement

With a large number of movies available, it becomes difficult for users to find relevant content.  
This project aims to solve that problem by recommending movies that are similar in content to a selected movie.

---

##  Approach

The recommendation system is built using a content-based filtering approach:

- Selected important features:
  - genres
  - keywords
  - cast
  - crew
  - overview  

- Performed preprocessing:
  - Removed missing values  
  - Parsed JSON columns  
  - Extracted key information (top cast, director, etc.)  
  - Combined all features into a single "tags" column  

- Applied NLP techniques:
  - Converted text into vectors using CountVectorizer  
  - Calculated similarity using cosine similarity  

- Optimization:
  - Reduced similarity matrix using top-K approach to make deployment efficient  

---

##  Tech Stack

- Python  
- Pandas  
- Scikit-learn  
- Streamlit  

---

##  Features

- Search movie by name  
- Get top 5 similar movie recommendations  
- Interactive UI (click on recommended movies to explore further)  
- Fast performance using optimized similarity data  

---

##  Result

The system successfully recommends movies that share similar content such as genre, theme, and cast.

Example:
- Input: Avatar  
- Output: Titan A.E., Independence Day, Aliens, etc.  

---

##  Limitations

- No user personalization (same recommendations for everyone)  
- Depends only on content (no user behavior data)  
- Recommendations may vary due to optimization (top-K reduction)  

---

## 🔮 Future Improvements

- Add movie posters and ratings  
- Implement collaborative filtering  
- Improve search with typo handling  
- Enhance UI for better user experience  

---

##  Project Structure
movie-recommender
app.py
movies.pkl
similarity_reduced.pkl
requirements.txt
README.md


---

## 🙌 Conclusion

This project helped me understand the complete pipeline of building a recommendation system, from data preprocessing and NLP to deployment and optimization.

---

If you found this project useful, feel free to explore and give feedback!

.
.
.
.
.
.
.
.

## 👤 Author

**Peyal Bepari**  
Masters in Control Systems Engineering  
Bachelor’s in Electronics and Instrumentation  
