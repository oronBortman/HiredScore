SET @movie_id = 2;
SELECT movie_id, SUM(sum) AS 'Total'
FROM
(
	SELECT S.movie_id, ( C.sum2 / GREATEST(
    count(*),
    (SELECT count(*) FROM movies_genres WHERE movie_id = @movie_id))) *  0.5  as sum
    FROM movies_genres S
		INNER JOIN (
		SELECT movie_id, count(*) as sum2
		FROM movies_genres
		WHERE genre_id IN (
			SELECT genre_id
			FROM movies_genres
			WHERE movie_id = @movie_id) AND movie_id != @movie_id
		GROUP BY movie_id
	) C ON S.movie_id = C.movie_id GROUP BY S.movie_id
	UNION ALL
	SELECT S.movie_id, ( C.sum2 / GREATEST(
    count(*),
    (SELECT count(*) FROM movies_languages WHERE movie_id = @movie_id))) *  0.3  as sum
    FROM movies_languages S
		INNER JOIN (
		SELECT movie_id, count(*) as sum2
		FROM movies_languages
		WHERE language_id IN (
			SELECT language_id
			FROM movies_languages
			WHERE movie_id = @movie_id) AND movie_id != @movie_id
		GROUP BY movie_id
	) C ON S.movie_id = C.movie_id GROUP BY S.movie_id
	UNION ALL
	SELECT S.movie_id, ( C.sum2 / GREATEST(
    count(*),
    (SELECT count(*) FROM movies_countries WHERE movie_id = @movie_id))) *  0.2  as sum
    FROM movies_countries S
		INNER JOIN (
		SELECT movie_id, count(*) as sum2
		FROM movies_countries
		WHERE country_id IN (
			SELECT country_id
			FROM movies_countries
			WHERE movie_id = @movie_id) AND movie_id != @movie_id
		GROUP BY movie_id
	) C ON S.movie_id = C.movie_id GROUP BY S.movie_id
) a;
