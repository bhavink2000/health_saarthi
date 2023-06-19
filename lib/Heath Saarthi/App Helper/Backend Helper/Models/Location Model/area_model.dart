class AreaModel {
  int? status;
  List<AreaData>? data;

  AreaModel({this.status, this.data});

  AreaModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <AreaData>[];
      json['data'].forEach((v) {
        data!.add(new AreaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AreaData {
  int? id;
  int? sufalamAreaId;
  String? areaName;
  String? encAreaId;
  String? createAt;

  AreaData(
      {this.id,
        this.sufalamAreaId,
        this.areaName,
        this.encAreaId,
        this.createAt});

  AreaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sufalamAreaId = json['sufalam_area_id'];
    areaName = json['area_name'];
    encAreaId = json['enc_area_id'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sufalam_area_id'] = this.sufalamAreaId;
    data['area_name'] = this.areaName;
    data['enc_area_id'] = this.encAreaId;
    data['create_at'] = this.createAt;
    return data;
  }
}