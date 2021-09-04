SELECT * from movies ORDER BY id ASC;
SELECT * from movies WHERE id = '2';
SELECT * from genres ORDER BY id ASC;
SELECT * from movies_genres ORDER BY movie_id ASC;
SELECT * from languages ORDER BY id ASC;
SELECT * from movies_languages ORDER BY movie_id ASC;
SELECT * from countries ORDER BY id ASC;
SELECT * from movies_countries ORDER BY movie_id ASC;

SELECT genre_id FROM movies_genres
UNION ALL
SELECT id FROM genres;

#movie_id 2 genres: 1,2,3,4,5
#movie_id 11 genres: 1,2,3,20,21
# Category: genres
#SELECT * FROM movies WHERE title = "Gang";
#, count(*) AS categoryNums
SET @movie_id = 2;

SELECT movie_id, SUM(sum) AS 'Total'
FROM
(
	SELECT movie_id, (count(*)/(SELECT count(*) FROM movies_genres WHERE movie_id = @movie_id) * 0.5) as sum
	FROM movies_genres
	WHERE genre_id IN (
		SELECT genre_id
		FROM movies_genres
		WHERE movie_id = @movie_id) AND movie_id != @movie_id
	GROUP BY movie_id
	UNION ALL
	SELECT movie_id, (count(*)/(SELECT count(*) FROM movies_languages WHERE movie_id = @movie_id) * 0.3 )as sum
	FROM movies_languages
	WHERE language_id IN (
		SELECT language_id
		FROM movies_languages
		WHERE movie_id = @movie_id) AND movie_id != @movie_id
	GROUP BY movie_id
	UNION ALL
	SELECT movie_id, (count(*)/(SELECT count(*) FROM movies_countries WHERE movie_id = @movie_id) * 0.2) as sum
	FROM movies_countries
	WHERE country_id IN (
		SELECT country_id
		FROM movies_countries
		WHERE movie_id = @movie_id) AND movie_id != @movie_id
	GROUP BY movie_id
) a
GROUP BY movie_id;

SET @movie_id = 50;

SELECT * 
FROM genres as c
INNER Join movies_genres as mc ON c.id = mc.genre_id AND mc.movie_id=@movie_id
UNION ALL
SELECT * 
FROM languages as c
INNER Join movies_languages as mc ON c.id = mc.language_id AND mc.movie_id=@movie_id
UNION ALL
SELECT * 
FROM countries as c
INNER Join movies_countries as mc ON c.id = mc.country_id AND mc.movie_id=@movie_id;

SET @movie_id = 2;

SELECT * 
FROM genres as c
INNER Join movies_genres as mc ON c.id = mc.genre_id AND mc.movie_id=@movie_id
UNION ALL
SELECT * 
FROM languages as c
INNER Join movies_languages as mc ON c.id = mc.language_id AND mc.movie_id=@movie_id
UNION ALL
SELECT * 
FROM countries as c
INNER Join movies_countries as mc ON c.id = mc.country_id AND mc.movie_id=@movie_id;


SELECT movie_id, count(*)
FROM movies_genres as m1
INNER JOIN movies_genres as m2 
	ON 
/*
# For every category:
1. get the movie category values
	(make sure the movies aren't with the id of the movie)
	1. count the number of the category values
	2. get the movies with the same category values 
    3. sum how much category values are the same for each movie
    4. calculate the sum / number of category values of the movie
    
1. get the movie genres   
2. get the movie languages
3. get the movie countries
points:
50 - categories
35 - languages
15 - countries
*/
