from utils.import_json_to_db_functions import *
from utils.similar_movies import get_similar_movies


if __name__ == '__main__':
    # create_db_and_import_json()
    movie_id = 2
    similar_movies_ids = get_similar_movies(movie_id)
    print(similar_movies_ids)


