class BannerModel {
  int? status;
  List<Data>? data;

  BannerModel({this.status, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  int? stateId;
  int? cityId;
  int? areaId;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? encBannerId;
  String? createAt;

  Data(
      {this.id,
        this.stateId,
        this.cityId,
        this.areaId,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.encBannerId,
        this.createAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    encBannerId = json['enc_banner_id'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['enc_banner_id'] = this.encBannerId;
    data['create_at'] = this.createAt;
    return data;
  }
}