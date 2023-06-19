class BookOrderConfirmModel {
  int? status;
  String? message;
  Data? data;

  BookOrderConfirmModel({this.status, this.message, this.data});

  BookOrderConfirmModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? pharmacyPatientId;
  String? collectionDate;
  String? remark;
  int? netAmount;
  int? totalPromoOfferAmount;
  int? totalDiscountAmount;
  int? grossAmount;
  dynamic promoOfferValue;
  dynamic promoOfferType;
  dynamic promoOfferCode;
  dynamic schemeId;
  int? totalTestAmount;
  String? testAmount;
  dynamic totalPackageAmount;
  dynamic packageAmount;
  dynamic totalProfileAmount;
  dynamic profileAmount;
  int? testDiscountTypeId;
  String? testDiscountValue;
  dynamic packageDiscountTypeId;
  dynamic packageDiscountValue;
  dynamic profileDiscountTypeId;
  dynamic profileDiscountValue;
  int? bookingCode;
  int? pharmacyId;
  int? isApplyDiscountTable;
  int? testDiscountManagemenId;
  String? pharmacyTestLockDiscountValue;
  dynamic b2bSubadminTestLockDiscount;
  String? pharmacyPackageLockDiscountValue;
  dynamic b2bSubadminPackageLockDiscount;
  String? pharmacyProfileLockDiscountValue;
  dynamic b2bSubadminProfileLockDiscount;
  int? b2bSubadminDiscountAmount;
  int? pharmacyDiscountAmount;
  int? totalReportAmount;
  String? prescription;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? encBookingDetailId;
  String? createAt;

  Data(
      {this.pharmacyPatientId,
        this.collectionDate,
        this.remark,
        this.netAmount,
        this.totalPromoOfferAmount,
        this.totalDiscountAmount,
        this.grossAmount,
        this.promoOfferValue,
        this.promoOfferType,
        this.promoOfferCode,
        this.schemeId,
        this.totalTestAmount,
        this.testAmount,
        this.totalPackageAmount,
        this.packageAmount,
        this.totalProfileAmount,
        this.profileAmount,
        this.testDiscountTypeId,
        this.testDiscountValue,
        this.packageDiscountTypeId,
        this.packageDiscountValue,
        this.profileDiscountTypeId,
        this.profileDiscountValue,
        this.bookingCode,
        this.pharmacyId,
        this.isApplyDiscountTable,
        this.testDiscountManagemenId,
        this.pharmacyTestLockDiscountValue,
        this.b2bSubadminTestLockDiscount,
        this.pharmacyPackageLockDiscountValue,
        this.b2bSubadminPackageLockDiscount,
        this.pharmacyProfileLockDiscountValue,
        this.b2bSubadminProfileLockDiscount,
        this.b2bSubadminDiscountAmount,
        this.pharmacyDiscountAmount,
        this.totalReportAmount,
        this.prescription,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.encBookingDetailId,
        this.createAt});

  Data.fromJson(Map<String, dynamic> json) {
    pharmacyPatientId = json['pharmacy_patient_id'];
    collectionDate = json['collection_date'];
    remark = json['remark'];
    netAmount = json['net_amount'];
    totalPromoOfferAmount = json['total_promo_offer_amount'];
    totalDiscountAmount = json['total_discount_amount'];
    grossAmount = json['gross_amount'];
    promoOfferValue = json['promo_offer_value'];
    promoOfferType = json['promo_offer_type'];
    promoOfferCode = json['promo_offer_code'];
    schemeId = json['scheme_id'];
    totalTestAmount = json['total_test_amount'];
    testAmount = json['test_amount'];
    totalPackageAmount = json['total_package_amount'];
    packageAmount = json['package_amount'];
    totalProfileAmount = json['total_profile_amount'];
    profileAmount = json['profile_amount'];
    testDiscountTypeId = json['test_discount_type_id'];
    testDiscountValue = json['test_discount_value'];
    packageDiscountTypeId = json['package_discount_type_id'];
    packageDiscountValue = json['package_discount_value'];
    profileDiscountTypeId = json['profile_discount_type_id'];
    profileDiscountValue = json['profile_discount_value'];
    bookingCode = json['booking_code'];
    pharmacyId = json['pharmacy_id'];
    isApplyDiscountTable = json['is_apply_discount_table'];
    testDiscountManagemenId = json['test_discount_managemen_id'];
    pharmacyTestLockDiscountValue = json['pharmacy_test_lock_discount_value'];
    b2bSubadminTestLockDiscount = json['b2b_subadmin_test_lock_discount'];
    pharmacyPackageLockDiscountValue =
    json['pharmacy_package_lock_discount_value'];
    b2bSubadminPackageLockDiscount = json['b2b_subadmin_package_lock_discount'];
    pharmacyProfileLockDiscountValue =
    json['pharmacy_profile_lock_discount_value'];
    b2bSubadminProfileLockDiscount = json['b2b_subadmin_profile_lock_discount'];
    b2bSubadminDiscountAmount = json['b2b_subadmin_discount_amount'];
    pharmacyDiscountAmount = json['pharmacy_discount_amount'];
    totalReportAmount = json['total_report_amount'];
    prescription = json['prescription'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    encBookingDetailId = json['enc_booking_detail_id'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['pharmacy_patient_id'] = this.pharmacyPatientId;
    data['collection_date'] = this.collectionDate;
    data['remark'] = this.remark;
    data['net_amount'] = this.netAmount;
    data['total_promo_offer_amount'] = this.totalPromoOfferAmount;
    data['total_discount_amount'] = this.totalDiscountAmount;
    data['gross_amount'] = this.grossAmount;
    data['promo_offer_value'] = this.promoOfferValue;
    data['promo_offer_type'] = this.promoOfferType;
    data['promo_offer_code'] = this.promoOfferCode;
    data['scheme_id'] = this.schemeId;
    data['total_test_amount'] = this.totalTestAmount;
    data['test_amount'] = this.testAmount;
    data['total_package_amount'] = this.totalPackageAmount;
    data['package_amount'] = this.packageAmount;
    data['total_profile_amount'] = this.totalProfileAmount;
    data['profile_amount'] = this.profileAmount;
    data['test_discount_type_id'] = this.testDiscountTypeId;
    data['test_discount_value'] = this.testDiscountValue;
    data['package_discount_type_id'] = this.packageDiscountTypeId;
    data['package_discount_value'] = this.packageDiscountValue;
    data['profile_discount_type_id'] = this.profileDiscountTypeId;
    data['profile_discount_value'] = this.profileDiscountValue;
    data['booking_code'] = this.bookingCode;
    data['pharmacy_id'] = this.pharmacyId;
    data['is_apply_discount_table'] = this.isApplyDiscountTable;
    data['test_discount_managemen_id'] = this.testDiscountManagemenId;
    data['pharmacy_test_lock_discount_value'] =
        this.pharmacyTestLockDiscountValue;
    data['b2b_subadmin_test_lock_discount'] = this.b2bSubadminTestLockDiscount;
    data['pharmacy_package_lock_discount_value'] =
        this.pharmacyPackageLockDiscountValue;
    data['b2b_subadmin_package_lock_discount'] =
        this.b2bSubadminPackageLockDiscount;
    data['pharmacy_profile_lock_discount_value'] =
        this.pharmacyProfileLockDiscountValue;
    data['b2b_subadmin_profile_lock_discount'] =
        this.b2bSubadminProfileLockDiscount;
    data['b2b_subadmin_discount_amount'] = this.b2bSubadminDiscountAmount;
    data['pharmacy_discount_amount'] = this.pharmacyDiscountAmount;
    data['total_report_amount'] = this.totalReportAmount;
    data['prescription'] = this.prescription;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['enc_booking_detail_id'] = this.encBookingDetailId;
    data['create_at'] = this.createAt;
    return data;
  }
}