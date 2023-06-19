class CityModel {
  int? status;
  List<CityData>? data;

  CityModel({this.status, this.data});

  CityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CityData>[];
      json['data'].forEach((v) {
        data!.add(new CityData.fromJson(v));
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

class CityData {
  int? id;
  int? sufalamCityId;
  String? cityName;
  String? encCityId;
  String? createAt;

  CityData(
      {this.id,
        this.sufalamCityId,
        this.cityName,
        this.encCityId,
        this.createAt});

  CityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sufalamCityId = json['sufalam_city_id'];
    cityName = json['city_name'];
    encCityId = json['enc_city_id'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sufalam_city_id'] = this.sufalamCityId;
    data['city_name'] = this.cityName;
    data['enc_city_id'] = this.encCityId;
    data['create_at'] = this.createAt;
    return data;
  }
}