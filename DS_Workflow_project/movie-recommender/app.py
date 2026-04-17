import streamlit as st
import pickle
import pandas as pd

# ---------------- PAGE CONFIG ----------------
st.set_page_config(page_title="Movie Recommender", layout="wide")

# ---------------- CUSTOM CSS ----------------
st.markdown("""
<style>

/* -------- GLOBAL -------- */
html, body, [data-testid="stAppViewContainer"] {
    background-color: #0b0b0b;
    color: white;
    font-family: 'Segoe UI', sans-serif;
}

/* Remove padding */
.block-container {
    padding-top: 1rem;
}

/* -------- TITLE -------- */
h1 {
    text-align: center;
    color: #E50914;
    font-size: 52px;
    font-weight: bold;
}

/* -------- SUBTITLE -------- */
.search-title {
    text-align: center;
    color: #b3b3b3;
    font-size: 18px;
    margin-bottom: 20px;
}

/* -------- SEARCH BOX (BRIGHT) -------- */
div[data-baseweb="select"] > div {
    background-color: #262626 !important;
    border: 2px solid #E50914 !important;
    border-radius: 10px !important;
    box-shadow: 0 0 10px rgba(229, 9, 20, 0.3);
}

div[data-baseweb="select"] span {
    color: white !important;
    font-weight: 500;
}

/* Hover */
div[data-baseweb="select"]:hover > div {
    background-color: #2f2f2f !important;
    border: 2px solid #ff1e1e !important;
}

/* Focus glow */
div[data-baseweb="select"]:focus-within > div {
    border: 2px solid #ff1e1e !important;
    box-shadow: 0 0 15px rgba(229, 9, 20, 0.6);
}

/* Dropdown */
ul[role="listbox"] {
    background-color: #1a1a1a !important;
    border: 1px solid #E50914;
}

/* -------- MOVIE CARDS -------- */
.movie-card {
    background-color: #141414;
    padding: 20px;
    border-radius: 12px;
    text-align: center;
    color: white;
    font-weight: 600;
    transition: all 0.3s ease;
    height: 120px;
    border: 1px solid #222;
}

/* Hover effect */
.movie-card:hover {
    transform: scale(1.08);
    background-color: #1f1f1f;
    border: 1px solid #E50914;
    box-shadow: 0 4px 20px rgba(229,9,20,0.3);
}

/* -------- FOOTER -------- */
.footer {
    text-align: center;
    color: gray;
    margin-top: 20px;
    font-size: 14px;
}

/* -------- SCROLLBAR -------- */
::-webkit-scrollbar {
    width: 8px;
}
::-webkit-scrollbar-track {
    background: #0b0b0b;
}
::-webkit-scrollbar-thumb {
    background: #333;
    border-radius: 10px;
}

</style>
""", unsafe_allow_html=True)

# ---------------- LOAD DATA ----------------
movies = pickle.load(open('DS_Workflow_project/movie-recommender/movies.pkl', 'rb'))
similarity = pickle.load(open('DS_Workflow_project/movie-recommender/similarity_reduced.pkl', 'rb'))

# ---------------- RECOMMEND FUNCTION ----------------
def recommend(movie):
    index = movies[movies['title'] == movie].index[0]
    movies_list = similarity[index][:5]   # already sorted
    return [movies.iloc[i[0]].title for i in movies_list]

# ---------------- UI ----------------

# Title
st.markdown("<h1>🎬 Movie Recommender</h1>", unsafe_allow_html=True)
st.markdown("<p class='search-title'>Discover movies you'll love</p>", unsafe_allow_html=True)

st.markdown("---")

# 🔍 SEARCH BOX
selected_movie = st.selectbox(
    "🔍 Search Movie (Start typing...)",
    movies['title'].values,
    index=None,
    placeholder="Type movie name like Avatar, Batman..."
)

st.markdown("---")

# ---------------- RESULTS ----------------
if selected_movie:

    with st.spinner("Finding best movies for you..."):
        recommendations = recommend(selected_movie)

    st.markdown("<h3 style='color:white;'>Top Recommendations</h3>", unsafe_allow_html=True)

    col1, col2, col3, col4, col5 = st.columns(5)
    cols = [col1, col2, col3, col4, col5]

    for i in range(5):
        with cols[i]:
            st.markdown(f"""
            <div class="movie-card">
                🎥 {recommendations[i]}
            </div>
            """, unsafe_allow_html=True)

# ---------------- FOOTER ----------------
st.markdown("---")
st.markdown("<p class='footer'>Made with ❤️ using Streamlit</p>", unsafe_allow_html=True)
