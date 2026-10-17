import mysql.connector
from flask import current_app, g


def get_db():
    """One MySQL connection per request, stored in flask.g."""
    if "db" not in g:
        cfg = current_app.config
        g.db = mysql.connector.connect(
            host=cfg["DB_HOST"],
            port=cfg["DB_PORT"],
            database=cfg["DB_NAME"],
            user=cfg["DB_USER"],
            password=cfg["DB_PASSWORD"],
            charset="utf8mb4",
            autocommit=False,
        )
    return g.db


def close_db(e=None):
    db = g.pop("db", None)
    if db is not None:
        db.close()


def query(sql, params=None, one=False):
    """Run a SELECT and return rows as dicts (or one dict / None)."""
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(sql, params)
        rows = cursor.fetchall()
    finally:
        cursor.close()
    if one:
        return rows[0] if rows else None
    return rows


def execute(sql, params=None):
    """Run INSERT / UPDATE / DELETE, commit and return lastrowid."""
    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute(sql, params)
        db.commit()
        return cursor.lastrowid
    except mysql.connector.Error:
        db.rollback()
        raise
    finally:
        cursor.close()


def init_app(app):
    app.teardown_appcontext(close_db)
