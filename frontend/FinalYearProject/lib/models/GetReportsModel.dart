class GetReportsModel {
  String status;
  List<Reports> reports;

  GetReportsModel({this.status, this.reports});

  GetReportsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['reports'] != null) {
      reports = new List<Reports>();
      json['reports'].forEach((v) {
        reports.add(new Reports.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.reports != null) {
      data['reports'] = this.reports.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reports {
  String username;
  String subject;
  String body;
  String date;

  Reports({this.username, this.subject, this.body, this.date});

  Reports.fromJson(Map<String, dynamic> json) {
    username = json['Username'];
    subject = json['Subject'];
    body = json['Body'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Username'] = this.username;
    data['Subject'] = this.subject;
    data['Body'] = this.body;
    data['Date'] = this.date;
    return data;
  }
}
