from flask import request, jsonify
from flask_restful import Resource
import json
from config import host, password, user, database
import psycopg2


class GetNumReportsResource(Resource):

    def get(self):

        username = request.args.get('username', type=str)

        try:
            # this is where we get the connection string
            conn = psycopg2.connect(
                host=host,
                database=database,
                user=user,
                password=password)

             # create a query cursor
            query = conn.cursor()

            query_string = "SELECT COUNT(username) from user_reports WHERE username LIKE '{}'".format(
                username)

            query.execute(query_string)

            count_response = query.fetchall()

            

            for row in count_response:
                count = row[0]
            

        except (Exception, psycopg2.DatabaseError) as error:
            print(error)

        finally:
            if conn is not None:
                conn.close()

        if(len(count_response) == 0):
            return {"status": "success", "reports": "0"}
        else:
            return {"status": "success", "reports": count}