from flask import request, jsonify
from flask_restful import Resource
import json
from config import host, password, user, database
import psycopg2


class GetNumVolunteersResource(Resource):

    def get(self):

        location = request.args.get('location', type=str)

        try:
            # this is where we get the connection string
            conn = psycopg2.connect(
                host=host,
                database=database,
                user=user,
                password=password)

            # create a query cursor
            query = conn.cursor()

            query_string = "SELECT COUNT(location) from volunteer_table WHERE location LIKE '{}'".format(
                location)

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
            return {"status": "success", "volunteers_in_area": "0"}
        else:
            return {"status": "success", "volunteers_in_area": count}
