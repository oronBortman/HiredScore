import json

from utils.create_table_functions import create_movies_table, create_categories_tables
from variables.constants import *
from utils.handling_db_tables_functions import *


def iterate_on_category(data, elem_category, category, movie_id):
    for i in data[category]:
        category_val = data[category][i].replace('"', '\\"')
        if not check_if_category_exists(category, category_val):
            insert_category_val(category, category_val)
        category_id = get_category_id(category, category_val)
        insert_to_movies_category(elem_category, category, movie_id, category_id)


def show_data_val(data, key_name):
    print(key_name + ":\n" + " " + data[key_name])


def check_if_key_exists(data, keys):
    for key in keys:
        if key not in data:
            return False
    return True


def add_details_to_movie(data, movie_details):
    movie_values = []
    for movie_detail in movie_details:
        detail_val = "NULL"
        if data[movie_detail] != "":
            detail_val = '"' + data[movie_detail].replace('"', '\\"') + '"'
        movie_values.append(detail_val)
    title, release_date, movie_box_office_revenue, plot_summary, feature_length = movie_values
    movie_id = insert_movie_to_movies_table(title, release_date, movie_box_office_revenue, plot_summary, feature_length)
    return movie_id


def import_json_to_db():
    movie_categories = list(map(lambda x: x[1], MOVIE_CATEGORIES))
    keys = MOVIE_DETAILS + movie_categories
    with open(JSON_FILE) as f:
        for line in f:
            data = json.loads(line)
            if not check_if_key_exists(data, keys):
                continue
            movie_id = add_details_to_movie(data, MOVIE_DETAILS)
            for elem_category, category in MOVIE_CATEGORIES:
                iterate_on_category(data, elem_category, category, movie_id)


def create_db_and_import_json():
    try:
        globals_variables.db = create_db_connection(HOSTNAME, DB_USER, DB_PASSWD)
        globals_variables.cursor = globals_variables.db.cursor(buffered=True)
        drop_db(DB_NAME)
        create_db(DB_NAME)
        use_db(DB_NAME)
        create_movies_table()
        create_categories_tables()
        import_json_to_db()
        globals_variables.db.commit()
    except Exception as error:
        print(error)
    finally:
        globals_variables.cursor.close()
        globals_variables.db.close()