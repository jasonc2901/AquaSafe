class GetNumReportsModel {
  String status;
  int reports;

  GetNumReportsModel({this.status, this.reports});

  GetNumReportsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    reports = json['reports'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['reports'] = this.reports;
    return data;
  }
}
