class TodayDealModel {
  int? status;
  List<TodayData>? todayData;

  TodayDealModel({this.status, this.todayData});

  TodayDealModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      todayData = <TodayData>[];
      json['data'].forEach((v) {
        todayData!.add(new TodayData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.todayData != null) {
      data['data'] = this.todayData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TodayData {
  int? id;
  int? stateId;
  int? cityId;
  int? areaId;
  dynamic costCenterId;
  int? userId;
  dynamic b2bSubadminId;
  dynamic pharmacyIds;
  String? applyForTypeId;
  int? applyForTestType;
  dynamic testManagementsId;
  int? applyForPackageType;
  dynamic testPackageManagementsId;
  int? applyForProfileType;
  dynamic testProfileManagementsId;
  int? discountTypeId;
  String? discountTypeValue;
  String? fromDate;
  String? toDate;
  dynamic offerCode;
  dynamic title;
  dynamic minAmount;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? encSchemeId;
  String? createAt;

  TodayData(
      {this.id,
        this.stateId,
        this.cityId,
        this.areaId,
        this.costCenterId,
        this.userId,
        this.b2bSubadminId,
        this.pharmacyIds,
        this.applyForTypeId,
        this.applyForTestType,
        this.testManagementsId,
        this.applyForPackageType,
        this.testPackageManagementsId,
        this.applyForProfileType,
        this.testProfileManagementsId,
        this.discountTypeId,
        this.discountTypeValue,
        this.fromDate,
        this.toDate,
        this.offerCode,
        this.title,
        this.minAmount,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.encSchemeId,
        this.createAt});

  TodayData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    costCenterId = json['cost_center_id'];
    userId = json['user_id'];
    b2bSubadminId = json['b2b_subadmin_id'];
    pharmacyIds = json['pharmacy_ids'];
    applyForTypeId = json['apply_for_type_id'];
    applyForTestType = json['apply_for_test_type'];
    testManagementsId = json['test_managements_id'];
    applyForPackageType = json['apply_for_package_type'];
    testPackageManagementsId = json['test_package_managements_id'];
    applyForProfileType = json['apply_for_profile_type'];
    testProfileManagementsId = json['test_profile_managements_id'];
    discountTypeId = json['discount_type_id'];
    discountTypeValue = json['discount_type_value'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    offerCode = json['offer_code'];
    title = json['title'];
    minAmount = json['min_amount'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    encSchemeId = json['enc_scheme_id'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['cost_center_id'] = this.costCenterId;
    data['user_id'] = this.userId;
    data['b2b_subadmin_id'] = this.b2bSubadminId;
    data['pharmacy_ids'] = this.pharmacyIds;
    data['apply_for_type_id'] = this.applyForTypeId;
    data['apply_for_test_type'] = this.applyForTestType;
    data['test_managements_id'] = this.testManagementsId;
    data['apply_for_package_type'] = this.applyForPackageType;
    data['test_package_managements_id'] = this.testPackageManagementsId;
    data['apply_for_profile_type'] = this.applyForProfileType;
    data['test_profile_managements_id'] = this.testProfileManagementsId;
    data['discount_type_id'] = this.discountTypeId;
    data['discount_type_value'] = this.discountTypeValue;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['offer_code'] = this.offerCode;
    data['title'] = this.title;
    data['min_amount'] = this.minAmount;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['enc_scheme_id'] = this.encSchemeId;
    data['create_at'] = this.createAt;
    return data;
  }
}