import streamlit as st
import pickle
import pandas as pd

# ---------------- PAGE CONFIG ----------------
st.set_page_config(page_title="Movie Recommender", layout="wide")

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
.search-title {
    text-align:center;
    color:white;
    font-size:22px;
}
.movie-card {
    background-color: #141414;
    padding: 20px;
    border-radius: 12px;
    text-align: center;
    color: white;
    font-weight: bold;
    transition: 0.3s;
    height: 120px;
}
.movie-card:hover {
    transform: scale(1.08);
    background-color: #292929;
}
</style>
""", unsafe_allow_html=True)

# ---------------- LOAD DATA ----------------
movies = pickle.load(open('DS_Workflow_project/movie-recommender/movies.pkl', 'rb'))
similarity = pickle.load(open('DS_Workflow_project/movie-recommender/similarity_reduced.pkl', 'rb'))

# ---------------- RECOMMEND FUNCTION (UPDATED) ----------------
def recommend(movie):
    index = movies[movies['title'] == movie].index[0]
    
    # already sorted in reduced file
    movies_list = similarity[index][:5]
    
    return [movies.iloc[i[0]].title for i in movies_list]

# ---------------- UI ----------------

# Title
st.markdown("<h1>🎬 Movie Recommender</h1>", unsafe_allow_html=True)
st.markdown("<p class='search-title'>Find movies similar to your favorite ones</p>", unsafe_allow_html=True)

st.markdown("---")

# 🔍 SEARCH BOX (better UX)
selected_movie = st.selectbox(
    "🔍 Search for a movie",
    movies['title'].values,
    index=None,
    placeholder="Type movie name like Avatar, Batman..."
)

st.markdown("---")

# ---------------- RESULTS (AUTO, NO BUTTON) ----------------
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
st.markdown("<p style='text-align:center; color:gray;'>Made with ❤️ using Streamlit</p>", unsafe_allow_html=True)
