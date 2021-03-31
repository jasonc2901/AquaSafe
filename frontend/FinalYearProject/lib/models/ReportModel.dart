class ReportModel {
  int status;
  String response;
  Report report;

  ReportModel({this.status, this.response, this.report});

  ReportModel.fromJson(Map<String, dynamic> json) {
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
  String subject;
  String body;
  String date;
  String pending;

  Report({this.username, this.subject, this.body, this.date, this.pending});

  Report.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    subject = json['subject'];
    body = json['body'];
    date = json['date'];
    pending = json['pending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['subject'] = this.subject;
    data['body'] = this.body;
    data['date'] = this.date;
    data['pending'] = this.pending;
    return data;
  }
}
