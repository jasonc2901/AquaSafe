from flask import request, jsonify
from flask_restful import Resource
import json
from config import host, password, user, database
import psycopg2
import smtplib
from string import Template
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText


class UserBugReportResource(Resource):

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

            query_string = "SELECT * from bug_reports WHERE username LIKE '{}'".format(
                username)

            query.execute(query_string)

            user_reports = query.fetchall()

            # Creates a list to store the user reports
            returned_user_reports = []

            for row in user_reports:
                user_name = row[0]
                subj = row[1]
                body = row[2]
                frequency = row[3]
                date = row[4]

                report_obj = {
                    "Username": user_name,
                    "Subject": subj,
                    "Body": body,
                    "Frequency": frequency,
                    "Date": date
                }

                returned_user_reports.append(report_obj)

        except (Exception, psycopg2.DatabaseError) as error:
            print(error)

        finally:
            if conn is not None:
                conn.close()

        if(len(returned_user_reports) == 0):
            return {"status": "success", "reports": "no previous reports"}
        else:
            return {"status": "success", "reports": returned_user_reports}

    def post(self):
        # extract variables from the post request
        username = request.args.get('username', type=str)
        subject = request.args.get('subject', type=str)
        body = request.args.get('body', type=str)
        frequency = request.args.get('frequency', type=str)
        date = request.args.get('date', type=str)
        emailAddress = request.args.get('email', type=str)

        # construct a user object
        report = {
            "username": username,
            "subject": subject,
            "body": body,
            "frequency": frequency,
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
            query_string = "INSERT INTO bug_reports (username, subject, body, frequency, date) VALUES ('{}','{}','{}','{}', '{}');".format(
                username, subject, body, frequency, date)
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

        return {"status": 200, "response": "Record inserted successfully into bug_reports table", "report": report}


def sendConfirmationEmail(emailAddress, username):
    # login details
    MY_ADDRESS = 'apikey'
    PASSWORD = 'API_KEY_HERE'

    # set up the SMTP server
    s = smtplib.SMTP(host='SMTP_HERE', port=25)
    s.starttls()
    s.login(MY_ADDRESS, PASSWORD)

    # create message object instance
    msg = MIMEMultipart()

    # initialise the message that will be sent to the user
    message = """
    Hi {}, \n
    Thank you for submitting a bug report. Your feedback helps us to make our app better every day. \n\n Kind Regards,\nAquaSafe.
    """.format(username)

    # setup the parameters of the message
    msg['From'] = "FROM_ADDRESS_HERE"
    msg['To'] = emailAddress
    msg['Subject'] = "Bug Report Submitted!"

    # add in the message body
    msg.attach(MIMEText(message, 'plain'))

    # send the email
    s.sendmail(msg['From'], msg['To'], msg.as_string())

    # close connection to server
    s.quit()
