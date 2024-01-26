class ProfileModel {
  int? status;
  Data? data;

  ProfileModel({this.status, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  dynamic parentId;
  dynamic b2bSubadminId;
  int? salesExecutiveAdminId;
  int? pharmacyCode;
  dynamic msdCode;
  String? name;
  String? vendorName;
  String? mobile;
  String? emailId;
  dynamic emailVerifiedAt;
  dynamic countryId;
  int? stateId;
  int? cityId;
  int? areaId;
  int? userId;
  int? costCenterId;
  String? address;
  String? pincode;
  String? pancard;
  String? pancardNumber;
  String? addressProof;
  String? aadharFront;
  String? aadharBack;
  String? chequeImage;
  String? gstNumber;
  dynamic gstImage;
  String? bankName;
  String? ifsc;
  String? accountNumber;
  dynamic message;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? encPharmacyId;
  String? encUserId;
  String? pancardImg;
  String? addressProofImg;
  String? aadharFrontImg;
  String? aadharBackImg;
  String? chequeImg;
  dynamic gstImg;
  String? createAt;
  StateDataa? state;
  CityDataa? city;
  AreaDataa? area;
  CostCenter? costCenter;

  Data(
      {this.id,
        this.parentId,
        this.b2bSubadminId,
        this.salesExecutiveAdminId,
        this.pharmacyCode,
        this.msdCode,
        this.name,
        this.vendorName,
        this.mobile,
        this.emailId,
        this.emailVerifiedAt,
        this.countryId,
        this.stateId,
        this.cityId,
        this.areaId,
        this.userId,
        this.costCenterId,
        this.address,
        this.pincode,
        this.pancard,
        this.pancardNumber,
        this.addressProof,
        this.aadharFront,
        this.aadharBack,
        this.chequeImage,
        this.gstNumber,
        this.gstImage,
        this.bankName,
        this.ifsc,
        this.accountNumber,
        this.message,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.encPharmacyId,
        this.encUserId,
        this.pancardImg,
        this.addressProofImg,
        this.aadharFrontImg,
        this.aadharBackImg,
        this.chequeImg,
        this.gstImg,
        this.createAt,
        this.state,
        this.city,
        this.area,
        this.costCenter});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    b2bSubadminId = json['b2b_subadmin_id'];
    salesExecutiveAdminId = json['sales_executive_admin_id'];
    pharmacyCode = json['pharmacy_code'];
    msdCode = json['msd_code'];
    name = json['name'];
    vendorName = json['vendor_name'];
    mobile = json['mobile'];
    emailId = json['email_id'];
    emailVerifiedAt = json['email_verified_at'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    userId = json['user_id'];
    costCenterId = json['cost_center_id'];
    address = json['address'];
    pincode = json['pincode'];
    pancard = json['pancard'];
    pancardNumber = json['pancard_number'];
    addressProof = json['address_proof'];
    aadharFront = json['aadhar_front'];
    aadharBack = json['aadhar_back'];
    chequeImage = json['cheque_image'];
    gstNumber = json['gst_number'];
    gstImage = json['gst_image'];
    bankName = json['bank_name'];
    ifsc = json['ifsc'];
    accountNumber = json['account_number'];
    message = json['message'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    encPharmacyId = json['enc_pharmacy_id'];
    encUserId = json['enc_user_id'];
    pancardImg = json['pancard_img'];
    addressProofImg = json['address_proof_img'];
    aadharFrontImg = json['aadhar_front_img'];
    aadharBackImg = json['aadhar_back_img'];
    chequeImg = json['cheque_img'];
    gstImg = json['gst_img'];
    createAt = json['create_at'];
    state = json['state'] != null ? new StateDataa.fromJson(json['state']) : null;
    city = json['city'] != null ? new CityDataa.fromJson(json['city']) : null;
    area = json['area'] != null ? new AreaDataa.fromJson(json['area']) : null;
    costCenter = json['cost_center'] != null
        ? new CostCenter.fromJson(json['cost_center'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['b2b_subadmin_id'] = this.b2bSubadminId;
    data['sales_executive_admin_id'] = this.salesExecutiveAdminId;
    data['pharmacy_code'] = this.pharmacyCode;
    data['msd_code'] = this.msdCode;
    data['name'] = this.name;
    data['vendor_name'] = this.vendorName;
    data['mobile'] = this.mobile;
    data['email_id'] = this.emailId;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['user_id'] = this.userId;
    data['cost_center_id'] = this.costCenterId;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['pancard'] = this.pancard;
    data['pancard_number'] = this.pancardNumber;
    data['address_proof'] = this.addressProof;
    data['aadhar_front'] = this.aadharFront;
    data['aadhar_back'] = this.aadharBack;
    data['cheque_image'] = this.chequeImage;
    data['gst_number'] = this.gstNumber;
    data['gst_image'] = this.gstImage;
    data['bank_name'] = this.bankName;
    data['ifsc'] = this.ifsc;
    data['account_number'] = this.accountNumber;
    data['message'] = this.message;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['enc_pharmacy_id'] = this.encPharmacyId;
    data['enc_user_id'] = this.encUserId;
    data['pancard_img'] = this.pancardImg;
    data['address_proof_img'] = this.addressProofImg;
    data['aadhar_front_img'] = this.aadharFrontImg;
    data['aadhar_back_img'] = this.aadharBackImg;
    data['cheque_img'] = this.chequeImg;
    data['gst_img'] = this.gstImg;
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
    if (this.costCenter != null) {
      data['cost_center'] = this.costCenter!.toJson();
    }
    return data;
  }
}

class StateDataa {
  int? id;
  String? stateName;
  String? encStateId;
  String? createAt;

  StateDataa({this.id, this.stateName, this.encStateId, this.createAt});

  StateDataa.fromJson(Map<String, dynamic> json) {
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

class CityDataa {
  int? id;
  String? cityName;
  String? encCityId;
  String? createAt;

  CityDataa({this.id, this.cityName, this.encCityId, this.createAt});

  CityDataa.fromJson(Map<String, dynamic> json) {
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

class AreaDataa {
  int? id;
  String? areaName;
  String? encAreaId;
  String? createAt;

  AreaDataa({this.id, this.areaName, this.encAreaId, this.createAt});

  AreaDataa.fromJson(Map<String, dynamic> json) {
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

class CostCenter {
  int? id;
  int? userId;
  int? stateId;
  int? sufalamStateId;
  String? sufalamStateName;
  int? cityId;
  int? sufalamCityId;
  String? sufalamCityName;
  int? areaId;
  int? sufalamAreaId;
  String? sufalamAreaName;
  int? sufalamBranchId;
  String? branchCode;
  String? branchName;
  String? latitude;
  String? longitude;
  dynamic emailId;
  String? contactNo;
  String? integrationBranchCode;
  String? address;
  dynamic description;
  int? isProcessingLocation;
  int? isShowinMobileApp;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? encCostCenterId;
  String? encUserId;
  String? createAt;

  CostCenter(
      {this.id,
        this.userId,
        this.stateId,
        this.sufalamStateId,
        this.sufalamStateName,
        this.cityId,
        this.sufalamCityId,
        this.sufalamCityName,
        this.areaId,
        this.sufalamAreaId,
        this.sufalamAreaName,
        this.sufalamBranchId,
        this.branchCode,
        this.branchName,
        this.latitude,
        this.longitude,
        this.emailId,
        this.contactNo,
        this.integrationBranchCode,
        this.address,
        this.description,
        this.isProcessingLocation,
        this.isShowinMobileApp,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.encCostCenterId,
        this.encUserId,
        this.createAt});

  CostCenter.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    stateId = json['state_id'];
    sufalamStateId = json['sufalam_state_id'];
    sufalamStateName = json['sufalam_state_name'];
    cityId = json['city_id'];
    sufalamCityId = json['sufalam_city_id'];
    sufalamCityName = json['sufalam_city_name'];
    areaId = json['area_id'];
    sufalamAreaId = json['sufalam_area_id'];
    sufalamAreaName = json['sufalam_area_name'];
    sufalamBranchId = json['sufalam_branch_id'];
    branchCode = json['branch_code'];
    branchName = json['branch_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    emailId = json['email_id'];
    contactNo = json['contact_no'];
    integrationBranchCode = json['integration_branch_code'];
    address = json['address'];
    description = json['description'];
    isProcessingLocation = json['is_processing_location'];
    isShowinMobileApp = json['is_showin_mobile_app'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    encCostCenterId = json['enc_cost_center_id'];
    encUserId = json['enc_user_id'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['state_id'] = this.stateId;
    data['sufalam_state_id'] = this.sufalamStateId;
    data['sufalam_state_name'] = this.sufalamStateName;
    data['city_id'] = this.cityId;
    data['sufalam_city_id'] = this.sufalamCityId;
    data['sufalam_city_name'] = this.sufalamCityName;
    data['area_id'] = this.areaId;
    data['sufalam_area_id'] = this.sufalamAreaId;
    data['sufalam_area_name'] = this.sufalamAreaName;
    data['sufalam_branch_id'] = this.sufalamBranchId;
    data['branch_code'] = this.branchCode;
    data['branch_name'] = this.branchName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['email_id'] = this.emailId;
    data['contact_no'] = this.contactNo;
    data['integration_branch_code'] = this.integrationBranchCode;
    data['address'] = this.address;
    data['description'] = this.description;
    data['is_processing_location'] = this.isProcessingLocation;
    data['is_showin_mobile_app'] = this.isShowinMobileApp;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['enc_cost_center_id'] = this.encCostCenterId;
    data['enc_user_id'] = this.encUserId;
    data['create_at'] = this.createAt;
    return data;
  }
}