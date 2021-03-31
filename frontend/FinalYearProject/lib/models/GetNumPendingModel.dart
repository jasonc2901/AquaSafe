class GetNumPendingModel {
  String status;
  int reportsPendingResponse;

  GetNumPendingModel({this.status, this.reportsPendingResponse});

  GetNumPendingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    reportsPendingResponse = json['reports_pending_response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['reports_pending_response'] = this.reportsPendingResponse;
    return data;
  }
}
