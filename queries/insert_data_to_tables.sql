
#1. Insert a new movie

#1.1 Insert to the movies table
#INSERT INTO movies (title, release_date, movie_box_office_revenue, plot_summary, feature_length) VALUES ("The Flock4", "2000-04-14", NULL , "Beautiful movie", NULL );
#SET @last_movie_id = LAST_INSERT_ID();
#1.2 For every country:
#1.2.1 Insert to countries table
#INSERT INTO countries (name) VALUES ("Israel");
#SET @last_country_id = LAST_INSERT_ID();
#1.2.2 Insert to countries_movies table
#INSERT INTO movies_countries (movie_id, country_id) VALUES (@last_movie_id, @last_country_id);
#INSERT INTO movies_countries (movie_id, country_id) VALUES (@last_movie_id, @last_country_id);

#1.3 For every genre:
#1.3.1 Insert to genres table
#INSERT INTO genres (name) VALUES ("Comedy");
#1.3.2 Insert to genres_movies table
#INSERT INTO genres_movies (movie_id, genre_id) VALUES ();

#1.3 For every language:
#1.3.1 Insert to languages table
#INSERT INTO languages (name) VALUES ("Hebrew");
#1.3.2 Insert to languages_movies table
#INSERT INTO languages_movies (movie_id, language_id) VALUES ();


