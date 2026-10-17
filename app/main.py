import mysql.connector
from flask import Blueprint, jsonify, render_template

from app.db import query

main = Blueprint("main", __name__)


@main.route("/")
def index():
    return render_template("index.html")


@main.route("/health")
def health():
    try:
        row = query("SELECT VERSION() AS version", one=True)
        return jsonify({"status": "ok", "mysql": row["version"]})
    except mysql.connector.Error as e:
        return jsonify({"status": "error", "detail": str(e)}), 500
