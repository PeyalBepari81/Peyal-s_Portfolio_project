select*
from swiggy.swiggy;
ALTER TABLE swiggy ADD COLUMN order_no SERIAL PRIMARY KEY; 
select count(ID)
from swiggy.swiggy;

-- Retrieve all restaurant details sorted by highest rating.
SELECT Restaurant,Average_ratings
from swiggy.swiggy
ORDER BY Average_ratings DESC;

-- Count the number of restaurants in each city.

SELECT City , count(Restaurant)
from swiggy.swiggy
GROUP BY City
ORDER BY count(Restaurant) DESC;

-- List all unique food types available in the dataset.(NOT POSSIBLE TO FIND OUT EXACT UNIQUE FOOD BUT CAN GET AN IDEA)
SELECT Restaurant , count(Food_type)
from swiggy.swiggy
GROUP BY Restaurant
ORDER BY count(Food_type) DESC;

-- Find the total number of restaurants in each area.
SELECT Area , count(Restaurant)
from swiggy.swiggy
GROUP BY Area
ORDER BY count(Restaurant) DESC;
-- Identify the top 10 most popular restaurants based on total ratings.
SELECT Restaurant ,SUM(Total_ratings)
from swiggy.swiggy
GROUP BY  Restaurant 
ORDER BY SUM(Total_ratings) DESC
LIMIT 10;
-- Find the average price of a meal in each city.
SELECT City,AVG(price)
FROM swiggy.swiggy
GROUP BY City
ORDER BY AVG(Restaurant) DESC;
-- Identify the most expensive and cheapest restaurants in each city. 
(SELECT Restaurant, Price 
 FROM swiggy.swiggy 
 WHERE Price = (SELECT MAX(Price) FROM swiggy.swiggy) 
 LIMIT 1)

UNION ALL

(SELECT Restaurant, Price 
 FROM swiggy.swiggy 
 WHERE Price = (SELECT MIN(Price) FROM swiggy.swiggy) 
 LIMIT 1);
 
 -- Find the most common food type in each city.
WITH RankedFood AS (
    SELECT City, Food_Type, COUNT(*) AS Food_Count,
           RANK() OVER (PARTITION BY City ORDER BY COUNT(*) DESC) AS rnk
    FROM swiggy.swiggy
    GROUP BY City, Food_Type
)
SELECT City, Food_Type, Food_Count
FROM RankedFood
WHERE rnk = 1;

 -- Find the average delivery time per city.
 
 SELECT City,AVG(Delivery_time) as Delivery_time_min
 FROM swiggy.swiggy
 group by City;
 
-- Identify which city has the fastest and slowest average delivery time. 
 (SELECT City,Delivery_time
 FROM swiggy.swiggy 
 WHERE Delivery_time = (SELECT MAX(Delivery_time) FROM swiggy.swiggy) 
 LIMIT 1)

UNION ALL

(SELECT City,Delivery_time 
 FROM swiggy.swiggy 
 WHERE Delivery_time = (SELECT MIN(Delivery_time) FROM swiggy.swiggy) 
 LIMIT 1);
 
 -- Check if higher-priced restaurants have better ratings.
 
 SELECT 
    CASE 
        WHEN Price >= (SELECT AVG(Price) FROM swiggy.swiggy) THEN 'High Price'
        ELSE 'Low Price'
    END AS Price_Category,
    ROUND(AVG(Average_ratings), 2) AS Avg_Rating
FROM swiggy.swiggy
GROUP BY Price_Category;

-- Find the top 5 food types with the highest average ratings.
SELECT Food_type, Average_ratings
FROM swiggy.swiggy
WHERE Average_ratings = (select MAX(Average_ratings) FROM swiggy.swiggy)
group by Food_type,Average_ratings
limit 5;

-- or
SELECT Food_Type, AVG(Average_ratings) AS Avg_Rating
FROM swiggy.swiggy
GROUP BY Food_Type
ORDER BY AVG(Average_ratings) DESC
LIMIT 5;
-- Identify the top-rated restaurant in each city.
WITH RankedRestaurants AS (
    SELECT 
        City, 
        Restaurant, 
        Average_ratings, 
        RANK() OVER (PARTITION BY City ORDER BY Average_ratings DESC) AS rnk
    FROM swiggy.swiggy
)
SELECT City, Restaurant,Average_ratings
FROM RankedRestaurants
WHERE rnk = 1;

-- Find restaurants where the price is above the city’s average price.

SELECT Restaurant, Price 
FROM swiggy.swiggy 
WHERE Price >= (SELECT AVG(Price) FROM swiggy.swiggy) ;

-- Analyze how food type influences delivery time.

SELECT Food_type, AVG(Delivery_time) AS AVG_TIME_IN_MIN
FROM swiggy.swiggy 
GROUP BY Food_type
ORDER BY AVG(Delivery_time) DESC ;

-- Identify areas with the highest concentration of highly rated restaurant
SELECT Area,COUNT(Restaurant)
FROM swiggy.swiggy 
WHERE Average_ratings >= 4.5       -- (SELECT AVG(Average_ratings) FROM swiggy.swiggy)
GROUP BY Area
ORDER BY COUNT(Restaurant) DESC ;


-- Determine if expensive restaurants receive more orders based on total ratings.
SELECT 
CASE WHEN Price >= (SELECT AVG(Price) FROM swiggy.swiggy) THEN 'expensive'
	 WHEN Price = (SELECT AVG(Price) FROM swiggy.swiggy) THEN 'buget_friendly'
	 ELSE 'pocket_friendly'
END  AS resturant_tag,
SUM(Total_ratings) as total_order,
AVG(Average_ratings)as avg_rating
From swiggy.swiggy
GROUP BY resturant_tag
order by total_order;


-- Rank cities based on restaurant availability and average-rating;
WITH rankedcity AS
(SELECT City,AVG(Average_ratings) AS avg_rating,COUNT(Restaurant) AS total_no_resturant,
RANK() OVER(PARTITION BY City ORDER BY COUNT(Restaurant) DESC) AS rnk
FROM swiggy.swiggy
GROUP BY City)

SELECT City,avg_rating,total_no_resturant
FROM rankedcity
WHERE rnk = 1;

WITH rankedcity AS (
    SELECT 
        City,
        AVG(Average_ratings) AS avg_rating,
        COUNT(Restaurant) AS total_no_restaurant,
        RANK() OVER(PARTITION BY City ORDER BY COUNT(Restaurant) DESC) AS rnk
    FROM swiggy.swiggy
    GROUP BY City
)
SELECT City, avg_rating, total_no_restaurant
FROM rankedcity
WHERE rnk = 1;


-- Find restaurants that have both high ratings and fast delivery times.
SELECT 
    Restaurant, 
    Area, 
    City, 
    Average_ratings, 
    Delivery_time
FROM swiggy.swiggy
WHERE Average_ratings >= 4.5
AND Delivery_time <= 30
ORDER BY Average_ratings DESC, Delivery_time ASC;
