class QRCodeModel {
  dynamic status;
  String? massage;
  Data? data;

  QRCodeModel({this.status, this.massage, this.data});

  QRCodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    massage = json['massage'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['massage'] = this.massage;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  dynamic parentId;
  int? b2bSubadminId;
  int? salesExecutiveAdminId;
  int? pharmacyCode;
  dynamic msdCode;
  String? name;
  String? vendorName;
  String? mobile;
  dynamic otp;
  dynamic otpVerifiedAt;
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
  String? qrcodeImage;
  dynamic message;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? qrcodeImagePath;
  String? qrcodeImageBase;
  String? encPharmacyId;
  String? encUserId;
  String? pancardImg;
  String? addressProofImg;
  String? aadharFrontImg;
  String? aadharBackImg;
  String? chequeImg;
  dynamic gstImg;
  String? pancardDownload;
  String? addressProofDownload;
  String? aadharFrontDownload;
  String? aadharBackDownload;
  String? chequeDownload;
  dynamic gstDownload;
  String? createAt;

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
        this.otp,
        this.otpVerifiedAt,
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
        this.qrcodeImage,
        this.message,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.qrcodeImagePath,
        this.qrcodeImageBase,
        this.encPharmacyId,
        this.encUserId,
        this.pancardImg,
        this.addressProofImg,
        this.aadharFrontImg,
        this.aadharBackImg,
        this.chequeImg,
        this.gstImg,
        this.pancardDownload,
        this.addressProofDownload,
        this.aadharFrontDownload,
        this.aadharBackDownload,
        this.chequeDownload,
        this.gstDownload,
        this.createAt});

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
    otp = json['otp'];
    otpVerifiedAt = json['otp_verified_at'];
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
    qrcodeImage = json['qrcode_image'];
    message = json['message'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    qrcodeImagePath = json['qrcode_image_path'];
    qrcodeImageBase = json['qrcode_image_base'];
    encPharmacyId = json['enc_pharmacy_id'];
    encUserId = json['enc_user_id'];
    pancardImg = json['pancard_img'];
    addressProofImg = json['address_proof_img'];
    aadharFrontImg = json['aadhar_front_img'];
    aadharBackImg = json['aadhar_back_img'];
    chequeImg = json['cheque_img'];
    gstImg = json['gst_img'];
    pancardDownload = json['pancard_download'];
    addressProofDownload = json['address_proof_download'];
    aadharFrontDownload = json['aadhar_front_download'];
    aadharBackDownload = json['aadhar_back_download'];
    chequeDownload = json['cheque_download'];
    gstDownload = json['gst_download'];
    createAt = json['create_at'];
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
    data['otp'] = this.otp;
    data['otp_verified_at'] = this.otpVerifiedAt;
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
    data['qrcode_image'] = this.qrcodeImage;
    data['message'] = this.message;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['qrcode_image_path'] = this.qrcodeImagePath;
    data['qrcode_image_base'] = this.qrcodeImageBase;
    data['enc_pharmacy_id'] = this.encPharmacyId;
    data['enc_user_id'] = this.encUserId;
    data['pancard_img'] = this.pancardImg;
    data['address_proof_img'] = this.addressProofImg;
    data['aadhar_front_img'] = this.aadharFrontImg;
    data['aadhar_back_img'] = this.aadharBackImg;
    data['cheque_img'] = this.chequeImg;
    data['gst_img'] = this.gstImg;
    data['pancard_download'] = this.pancardDownload;
    data['address_proof_download'] = this.addressProofDownload;
    data['aadhar_front_download'] = this.aadharFrontDownload;
    data['aadhar_back_download'] = this.aadharBackDownload;
    data['cheque_download'] = this.chequeDownload;
    data['gst_download'] = this.gstDownload;
    data['create_at'] = this.createAt;
    return data;
  }
}