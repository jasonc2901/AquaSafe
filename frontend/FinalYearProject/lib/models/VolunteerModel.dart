class VolunteerModel {
  int status;
  String response;
  Report report;

  VolunteerModel({this.status, this.response, this.report});

  VolunteerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'];
    report =
        json['report'] != null ? new Report.fromJson(json['report']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['response'] = this.response;
    if (this.report != null) {
      data['report'] = this.report.toJson();
    }
    return data;
  }
}

class Report {
  String username;
  String location;
  String date;

  Report({this.username, this.location, this.date});

  Report.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    location = json['location'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['location'] = this.location;
    data['date'] = this.date;
    return data;
  }
}
