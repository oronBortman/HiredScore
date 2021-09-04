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

