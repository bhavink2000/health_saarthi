class UserModel {
  int? status;
  String? accessToken;
  String? tokenType;
  Data? data;
  int? expiresIn;

  UserModel(
      {this.status,
        this.accessToken,
        this.tokenType,
        this.data,
        this.expiresIn});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['expires_in'] = this.expiresIn;
    return data;
  }
}

class Data {
  int? id;
  dynamic parentId;
  dynamic b2bSubadminId;
  int? salesExecutiveAdminId;
  int? pharmacyCode;
  String? msdCode;
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
  String? bankName;
  String? ifsc;
  String? accountNumber;
  dynamic message;
  int? status;
  dynamic deletedAt;
  String? createAt;
  String? updateAt;
  String? encPharmacyId;
  String? encUserId;

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
        this.bankName,
        this.ifsc,
        this.accountNumber,
        this.message,
        this.status,
        this.deletedAt,
        this.createAt,
        this.updateAt,
        this.encPharmacyId,
        this.encUserId});

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
    bankName = json['bank_name'];
    ifsc = json['ifsc'];
    accountNumber = json['account_number'];
    message = json['message'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createAt = json['create_at'];
    updateAt = json['update_at'];
    encPharmacyId = json['enc_pharmacy_id'];
    encUserId = json['enc_user_id'];
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
    data['bank_name'] = this.bankName;
    data['ifsc'] = this.ifsc;
    data['account_number'] = this.accountNumber;
    data['message'] = this.message;
    data['status'] = this.status;
    data['deleted_at'] = this.deletedAt;
    data['create_at'] = this.createAt;
    data['update_at'] = this.updateAt;
    data['enc_pharmacy_id'] = this.encPharmacyId;
    data['enc_user_id'] = this.encUserId;
    return data;
  }
}