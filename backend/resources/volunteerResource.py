from flask import request, jsonify
from flask_restful import Resource
import json
from config import host, password, user, database
import psycopg2
import smtplib
from string import Template
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


class VolunteerSignUpResource(Resource):

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

            query_string = "SELECT * from volunteer_table"

            query.execute(query_string)

            volunteer_list = query.fetchall()

            # Creates a list to store the user reports
            returned_volunteer_list = []

            for row in volunteer_list:
                user_name = row[0]
                location = row[1]
                date = row[2]

                volunteer_obj = {
                    "Username": user_name,
                    "Location": location,
                    "Date": date
                }

                returned_volunteer_list.append(volunteer_obj)

        except (Exception, psycopg2.DatabaseError) as error:
            print(error)

        finally:
            if conn is not None:
                conn.close()

        if(len(returned_volunteer_list) == 0):
            return {"status": "success", "volunteers": "no volunteers"}
        else:
            return {"status": "success", "volunteers": returned_volunteer_list}

    def post(self):
        # extract variables from the post request
        username = request.args.get('username', type=str)
        location = request.args.get('location', type=str)
        date = request.args.get('date', type=str)
        emailAddress = request.args.get('email', type=str)

        # construct a user object
        volunteer = {
            "username": username,
            "location": location,
            "date": date
        }

        try:
            # this is where we get the connection string
            conn = psycopg2.connect(
                host=host,
                database=database,
                user=user,
                password=password)

            # create a query cursor
            query = conn.cursor()

            # execute the INSERT SQL statement
            query_string = "INSERT INTO volunteer_table (username, location, date) VALUES ('{}','{}','{}');".format(
                username, location, date)
            query.execute(query_string)

            # commit the changes
            conn.commit()

            # close the communication with the PostgreSQL
            query.close()

        except (Exception, psycopg2.DatabaseError) as error:
            print(error)

        finally:
            if conn is not None:
                conn.close()
                # send email to user
                sendConfirmationEmail(emailAddress, username)

        return {"status": 200, "response": "Record inserted successfully into volunteer_table", "report": volunteer}


def sendConfirmationEmail(emailAddress, username):
    # login details
    MY_ADDRESS = 'apikey'
    PASSWORD = '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'

    # set up the SMTP server
    s = smtplib.SMTP(host='smtp.sendgrid.net', port=25)
    s.starttls()
    s.login(MY_ADDRESS, PASSWORD)

    # create message object instance
    msg = MIMEMultipart()

    # initialise the message that will be sent to the user
    message = """
    Hi {}, \n
    Thank you for signing up to AquaSafe's water cleanup program. We will be in touch soon with more information \n\n Kind Regards,\nAquaSafe.
    """.format(username)

    # setup the parameters of the message
    msg['From'] = "aquasafeni@gmail.com"
    msg['To'] = emailAddress
    msg['Subject'] = "Volunteer Signed Up!"

    # add in the message body
    msg.attach(MIMEText(message, 'plain'))

    # send the email
    s.sendmail(msg['From'], msg['To'], msg.as_string())

    # close connection to server
    s.quit()
