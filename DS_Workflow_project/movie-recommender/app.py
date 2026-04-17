import streamlit as st
import pickle
import pandas as pd

# ---------------- PAGE CONFIG ----------------
st.set_page_config(page_title="Movie Recommender", layout="wide")

# ---------------- SESSION STATE ----------------
if "current_movie" not in st.session_state:
    st.session_state.current_movie = None

# ---------------- CUSTOM CSS (NETFLIX STYLE) ----------------
st.markdown("""
<style>
body {
    background-color: #0e1117;
}
.main {
    background-color: #0e1117;
}
h1 {
    text-align: center;
    color: #E50914;
    font-size: 50px;
}
.movie-card {
    background-color: #1c1c1c;
    padding: 15px;
    border-radius: 10px;
    text-align: center;
    color: white;
    font-weight: bold;
    transition: 0.3s;
}
.movie-card:hover {
    transform: scale(1.05);
    background-color: #292929;
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

# Title
st.markdown("<h1>🎬 Movie Recommender</h1>", unsafe_allow_html=True)

st.markdown("<p style='text-align:center; color:white;'>Find movies similar to your favorite ones</p>", unsafe_allow_html=True)

st.markdown("---")

# Dropdown centered
col1, col2, col3 = st.columns([1,2,1])

with col2:
    selected_movie = st.selectbox(
        "🎥 Select a Movie",
        movies['title'].values
    )

# Button centered
col1, col2, col3 = st.columns([1,1,1])

with col2:
    recommend_btn = st.button("🚀 Recommend Movies")

st.markdown("---")

# ---------------- RESULTS ----------------
if recommend_btn:
    st.session_state.current_movie = selected_movie

# Show recommendations if movie exists
if st.session_state.current_movie:

    recommendations = recommend(st.session_state.current_movie)

    st.markdown(f"<h3 style='color:white;'>Top Recommendations for {st.session_state.current_movie}</h3>", unsafe_allow_html=True)

    col1, col2, col3, col4, col5 = st.columns(5)
    cols = [col1, col2, col3, col4, col5]

    for i in range(5):
        with cols[i]:
            # CLICKABLE BUTTON instead of static card
            if st.button(recommendations[i], key=f"{recommendations[i]}_{i}"):
                st.session_state.current_movie = recommendations[i]
                st.experimental_rerun()

# ---------------- FOOTER ----------------
st.markdown("---")
st.markdown("<p style='text-align:center; color:gray;'>Made with ❤️ using Streamlit</p>", unsafe_allow_html=True)
