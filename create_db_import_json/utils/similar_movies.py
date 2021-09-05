from variables import constants
from variables.constants import MOVIE_CATEGORIES, HOSTNAME, DB_USER, DB_PASSWD, DB_NAME
from utils.handling_db_tables_functions import *


def get_similar_movies_by_category(name_single, name_plural, weight):
    category_id = f'{name_single}_id'
    movies_category = f'movies_{name_plural}'

    return f"""SELECT S.movie_id, ( C.sum2 / GREATEST(
    count(*),
    (SELECT count(*) FROM {movies_category} WHERE movie_id = @movie_id))) *  {weight}  as sum
    FROM {movies_category} S
		INNER JOIN (
		SELECT movie_id, count(*) as sum2
		FROM {movies_category}
		WHERE {category_id} IN (
			SELECT {category_id}
			FROM {movies_category}
			WHERE movie_id = @movie_id) AND movie_id != @movie_id
		GROUP BY movie_id
	) C ON S.movie_id = C.movie_id GROUP BY S.movie_id
    """


def build_query_similar_movies(movie_id):
    query = f"""SELECT movie_id, SUM(sum) AS 'Total'
                FROM("""
    for category in MOVIE_CATEGORIES:
        name_single = category[0]
        name_plural = category[1]
        weight = category[2]
        query += get_similar_movies_by_category(name_single,name_plural,weight)
        if category != MOVIE_CATEGORIES[-1]:
            query += "Union All\n"
    query += ")categories  "
    query += "GROUP BY movie_id ORDER BY Total DESC LIMIT 3;"
    return query


def get_similar_movies(movie_id):
    query = build_query_similar_movies(movie_id)
    try:
        globals_variables.db = create_db_connection(HOSTNAME, DB_USER, DB_PASSWD)
        globals_variables.cursor = globals_variables.db.cursor(buffered=True)
        use_db(DB_NAME)
        sql_execute(f"SET @movie_id = {movie_id};")
        similar_movies = sql_execute_ret(query)
        res_list = [x[0] for x in similar_movies]
        return res_list
    except Exception as error:
        print(error)
    finally:
        globals_variables.cursor.close()
        globals_variables.db.close()

