class GetNumVolunteersModel {
  String status;
  int volunteersInArea;

  GetNumVolunteersModel({this.status, this.volunteersInArea});

  GetNumVolunteersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    volunteersInArea = json['volunteers_in_area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['volunteers_in_area'] = this.volunteersInArea;
    return data;
  }
}
