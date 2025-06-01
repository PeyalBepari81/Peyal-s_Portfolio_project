DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id VARCHAR(6),
    type     VARCHAR(10),
    title    VARCHAR(250),
    director VARCHAR(550),
    casts      VARCHAR(1050),
    country   VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

SELECT * FROM netflix;

-- Count the Number of Movies vs TV Shows

SELECT type,COUNT(type)
FROM netflix
group by type ;
--or
SELECT type,COUNT(*)
FROM netflix
GROUP BY 1;

--Find the Most Common Rating for Movies and TV Shows

With RankedRatings AS (
    SELECT 
        type,
        rating,
        rating_count,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS rank
    FROM (SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix
    GROUP BY type, rating)
)
SELECT 
    type,
    rating AS most_frequent_rating
FROM RankedRatings
WHERE rank = 1;

-- List All Movies Released in a Specific Year (e.g., 2020)

SELECT title FROM netflix
WHERE release_year =2020 AND type = 'Movie';

--Find the Top 5 indivisual Countries with the Most Content on Netflix

SELECT country, COUNT(show_id) AS total_content
FROM netflix
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;

--Identify the Longest Movie
SELECT *
FROM netflix
WHERE type = 'Movie' and duration is not null
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC

--Find content added in the last 5 years
SELECT * FROM netflix
WHERE TO_DATE(date_added, 'Month DD,YYYY') >= CURRENT_DATE - INTERVAL '5 years'

--Find all the movies/TV shows by director 'Rajiv Chilaka'!
SELECT *
FROM
(SELECT *,UNNEST(STRING_TO_ARRAY(director, ',')) as director_name
FROM 
netflix
)
WHERE 
	director_name = 'Rajiv Chilaka'

-- OR
SELECT *
FROM netflix
WHERE director  LIKE '%%Rajiv Chilaka%%'

-- List all TV shows with more than 5 seasons
SELECT *
FROM netflix
WHERE type = 'TV Show'
AND SPLIT_PART(duration,' ',1):: INT >5;

--Count the number of content items in each genre
SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
	COUNT(*) as total_content
FROM netflix
GROUP BY 1

--Find each year and the average numbers of content release by India on netflix.
-- return top 5 year with highest avg content release !
SELECT 
	country,
	release_year,
	COUNT(show_id) as total_release,
	ROUND(COUNT(show_id)::numeric/(SELECT COUNT(show_id) FROM netflix WHERE country = 'India')::numeric * 100 ,2) as avg_release	
FROM netflix
WHERE country = 'India'
GROUP BY country, 2
ORDER BY avg_release DESC 
LIMIT 5

-- List all movies that are documentaries
SELECT * FROM netflix
WHERE listed_in LIKE '%Documentaries%'


-- Find all content without a director

SELECT * FROM netflix
WHERE director IS NULL


-- Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT * FROM netflix
WHERE 
	casts LIKE '%Salman Khan%'
	AND 
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10

-- Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) as actor,
	COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

--Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
--the description field. Label content containing these keywords as 'Bad' and all other 
--content as 'Good'. Count how many items fall into each category.
SELECT 
    category,
	TYPE,
    COUNT(*) AS content_count
FROM (
    SELECT 
		*,
        CASE 
            WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix
) AS categorized_content
GROUP BY 1,2
ORDER BY 2


