class MobileNumberModel {
  int? status;
  List<MobileData>? mobileData;

  MobileNumberModel({this.status, this.mobileData});

  MobileNumberModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      mobileData = <MobileData>[];
      json['data'].forEach((v) {
        mobileData!.add(new MobileData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.mobileData != null) {
      data['data'] = this.mobileData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MobileData {
  int? id;
  dynamic mobileNo;
  String? name;
  dynamic encPharmacyPatientId;
  dynamic createAt;

  MobileData(
      {this.id,
        this.mobileNo,
        this.name,
        this.encPharmacyPatientId,
        this.createAt});

  MobileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobileNo = json['mobile_no'];
    name = json['name'];
    encPharmacyPatientId = json['enc_pharmacy_patient_id'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mobile_no'] = this.mobileNo;
    data['name'] = this.name;
    data['enc_pharmacy_patient_id'] = this.encPharmacyPatientId;
    data['create_at'] = this.createAt;
    return data;
  }
}