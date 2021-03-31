class RiverModel {
  int status;
  List<Rivers> rivers;

  RiverModel({this.status, this.rivers});

  RiverModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['waterBodies'] != null) {
      rivers = new List<Rivers>();
      json['waterBodies'].forEach((v) {
        rivers.add(new Rivers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.rivers != null) {
      data['waterBodies'] = this.rivers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rivers {
  String name;
  String location;
  String length;
  String lAT;
  String lON;
  String description;
  String imageUrl;
  String pollutionStatus;
  List<dynamic> additionalInformation;

  Rivers(
      {this.name,
      this.location,
      this.length,
      this.lAT,
      this.lON,
      this.description,
      this.imageUrl,
      this.pollutionStatus,
      this.additionalInformation});

  Rivers.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    location = json['Location'];
    length = json['Length'];
    lAT = json['LAT'];
    lON = json['LON'];
    description = json['Description'];
    imageUrl = json['ImageURL'];
    pollutionStatus = json['Status'];
    additionalInformation = json["AdditionalInfo"] as List;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Location'] = this.location;
    data['Length'] = this.length;
    data['LAT'] = this.lAT;
    data['LON'] = this.lON;
    data['Description'] = this.description;
    data['ImageURL'] = this.imageUrl;
    data['Status'] = this.pollutionStatus;
    data['AdditionalInfo'] = this.additionalInformation;
    return data;
  }
}
