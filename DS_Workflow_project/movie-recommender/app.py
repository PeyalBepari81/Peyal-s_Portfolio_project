import streamlit as st
import pickle
import pandas as pd

# ---------------- PAGE CONFIG ----------------
st.set_page_config(page_title="Movie Recommender", layout="wide")

# ---------------- SESSION STATE ----------------
if "current_movie" not in st.session_state:
    st.session_state.current_movie = None

# ---------------- CUSTOM CSS ----------------
st.markdown("""
<style>

/* GLOBAL */
html, body, [data-testid="stAppViewContainer"] {
    background-color: #0b0b0b;
    color: white;
    font-family: 'Segoe UI', sans-serif;
}

/* TITLE */
h1 {
    text-align: center;
    color: #E50914;
    font-size: 52px;
}

/* SEARCH HEADING */
.search-heading {
    text-align: center;
    color: white;
    font-size: 22px;
    font-weight: 600;
}

/* WHITE SEARCH BOX */
div[data-baseweb="select"] > div {
    background-color: white !important;
    border: 2px solid #E50914 !important;
    border-radius: 10px !important;
}

/* TEXT */
div[data-baseweb="select"] span {
    color: black !important;
}

/* MOVIE BUTTON STYLE */
.stButton > button {
    background-color: #141414;
    color: white;
    border-radius: 10px;
    border: 1px solid #333;
    height: 120px;
    width: 100%;
    font-weight: bold;
    transition: 0.3s;
}

.stButton > button:hover {
    background-color: #1f1f1f;
    border: 1px solid #E50914;
    transform: scale(1.05);
}

</style>
""", unsafe_allow_html=True)

# ---------------- LOAD DATA ----------------
movies = pickle.load(open('DS_Workflow_project/movie-recommender/movies.pkl', 'rb'))
similarity = pickle.load(open('DS_Workflow_project/movie-recommender/similarity_reduced.pkl', 'rb'))

# ---------------- RECOMMEND FUNCTION ----------------
def recommend(movie):
    index = movies[movies['title'] == movie].index[0]
    movies_list = similarity[index][:5]
    return [movies.iloc[i[0]].title for i in movies_list]

# ---------------- UI ----------------

st.markdown("<h1>🎬 Movie Recommender</h1>", unsafe_allow_html=True)
st.markdown("<div class='search-heading'>🔍 Search Movie</div>", unsafe_allow_html=True)

# SEARCH BOX
selected_movie = st.selectbox(
    "",
    movies['title'].values,
    index=None,
    placeholder="Type movie name like Avatar..."
)

# Update current movie
if selected_movie:
    st.session_state.current_movie = selected_movie

st.markdown("---")

# ---------------- SHOW RECOMMENDATIONS ----------------
if st.session_state.current_movie:

    st.markdown(f"### 🎥 Showing recommendations for: **{st.session_state.current_movie}**")

    recommendations = recommend(st.session_state.current_movie)

    cols = st.columns(5)

    for i in range(5):
        with cols[i]:
            if st.button(recommendations[i], key=recommendations[i]):
                st.session_state.current_movie = recommendations[i]
                st.rerun()
