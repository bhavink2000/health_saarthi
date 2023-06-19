class PatientModel {
  int? status;
  PatientData? patientData;

  PatientModel({this.status, this.patientData});

  PatientModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    patientData = json['data'] != null ? new PatientData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.patientData != null) {
      data['data'] = this.patientData!.toJson();
    }
    return data;
  }
}

class PatientData {
  int? id;
  int? pharmacyId;
  String? name;
  String? emailId;
  String? mobileNo;
  int? gender;
  String? dateOfBirth;
  String? age;
  int? stateId;
  int? cityId;
  int? areaId;
  String? pincode;
  String? address;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<String>? genderList;
  String? encPharmacyId;
  String? encPharmacyPatientId;
  String? createAt;
  State? state;
  City? city;
  Area? area;

  PatientData(
      {this.id,
        this.pharmacyId,
        this.name,
        this.emailId,
        this.mobileNo,
        this.gender,
        this.dateOfBirth,
        this.age,
        this.stateId,
        this.cityId,
        this.areaId,
        this.pincode,
        this.address,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.genderList,
        this.encPharmacyId,
        this.encPharmacyPatientId,
        this.createAt,
        this.state,
        this.city,
        this.area});

  PatientData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacyId = json['pharmacy_id'];
    name = json['name'];
    emailId = json['email_id'];
    mobileNo = json['mobile_no'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    age = json['age'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    pincode = json['pincode'];
    address = json['address'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    genderList = json['gender_list'].cast<String>();
    encPharmacyId = json['enc_pharmacy_id'];
    encPharmacyPatientId = json['enc_pharmacy_patient_id'];
    createAt = json['create_at'];
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pharmacy_id'] = this.pharmacyId;
    data['name'] = this.name;
    data['email_id'] = this.emailId;
    data['mobile_no'] = this.mobileNo;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['age'] = this.age;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['pincode'] = this.pincode;
    data['address'] = this.address;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['gender_list'] = this.genderList;
    data['enc_pharmacy_id'] = this.encPharmacyId;
    data['enc_pharmacy_patient_id'] = this.encPharmacyPatientId;
    data['create_at'] = this.createAt;
    if (this.state != null) {
      data['state'] = this.state!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.area != null) {
      data['area'] = this.area!.toJson();
    }
    return data;
  }
}

class State {
  int? id;
  String? stateName;
  String? encStateId;
  String? createAt;

  State({this.id, this.stateName, this.encStateId, this.createAt});

  State.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateName = json['state_name'];
    encStateId = json['enc_state_id'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_name'] = this.stateName;
    data['enc_state_id'] = this.encStateId;
    data['create_at'] = this.createAt;
    return data;
  }
}

class City {
  int? id;
  String? cityName;
  String? encCityId;
  String? createAt;

  City({this.id, this.cityName, this.encCityId, this.createAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['city_name'];
    encCityId = json['enc_city_id'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_name'] = this.cityName;
    data['enc_city_id'] = this.encCityId;
    data['create_at'] = this.createAt;
    return data;
  }
}

class Area {
  int? id;
  String? areaName;
  String? encAreaId;
  String? createAt;

  Area({this.id, this.areaName, this.encAreaId, this.createAt});

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    areaName = json['area_name'];
    encAreaId = json['enc_area_id'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['area_name'] = this.areaName;
    data['enc_area_id'] = this.encAreaId;
    data['create_at'] = this.createAt;
    return data;
  }
}