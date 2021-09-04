from utils.create_table_functions import *
from utils.import_json_to_db_functions import *


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


if __name__ == '__main__':
    create_db_and_import_json()


