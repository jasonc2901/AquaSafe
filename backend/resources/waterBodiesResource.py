from flask import request, jsonify
from flask_restful import Resource
import json

class WaterBodiesResource(Resource):

    def get(self):
        with open('resources/WaterBodies.json') as json_file:
            riversJson = json.loads(json_file.read())

            #if the user passes a specific country to search for
            #this variable will store it
            country = request.args.get('country', type = str)

            #Example search
            # /api/rivers?country='Ireland'

            #declare an empty array for the country specific response
            country_specific_response = []

            #if the search contains a country param
            if country:
                #if search is for NI add all matching rivers into the 
                #country specific response list
                if "NI" in country:
                    for river in riversJson['waterBodies']:
                        if river['Location'] == 'NI':
                            country_specific_response.append(river)

                #if search is for Ireland add all matching rivers into the 
                #country specific response list            
                elif 'Ireland' in country:
                    for river in riversJson['waterBodies']:
                        if river['Location'] == 'Ireland':
                            country_specific_response.append(river)
                
                #return the country specific response list
                return {"status": 200, "waterBodies": country_specific_response}

            #else return the full list of rivers from rivers.json
            return {"status": 200, "waterBodies": riversJson['waterBodies']}
