from flask import Blueprint
from flask_restful import Api
from resources.newsResource import newsResource
from resources.waterBodiesResource import WaterBodiesResource
from resources.userReportResource import UserReportResource
from resources.getNumReportsResource import GetNumReportsResource
from resources.bugReportResource import UserBugReportResource
from resources.volunteerResource import VolunteerSignUpResource
from resources.getNumVolunteersResource import GetNumVolunteersResource
from resources.getNumResponsePending import GetNumResponsePending


api_bp = Blueprint('api', __name__)
api = Api(api_bp)

# Route
api.add_resource(newsResource, '/articles')
api.add_resource(WaterBodiesResource, '/waterBodies')
api.add_resource(UserReportResource, '/userReports')
api.add_resource(GetNumResponsePending, '/getNumPending')
api.add_resource(GetNumReportsResource, '/getNumReports')
api.add_resource(UserBugReportResource, '/bugReports')
api.add_resource(VolunteerSignUpResource, '/volunteerList')
api.add_resource(GetNumVolunteersResource, '/getNumVolunteers')
