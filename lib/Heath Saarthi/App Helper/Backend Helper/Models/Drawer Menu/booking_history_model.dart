class BookingHistoryModel {
  int? status;
  BookingData? bookingData;

  BookingHistoryModel({this.status, this.bookingData});

  BookingHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bookingData = json['data'] != null ? new BookingData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.bookingData != null) {
      data['data'] = this.bookingData!.toJson();
    }
    return data;
  }
}

class BookingData {
  List<BookingItems>? bookingItems;

  BookingData({this.bookingItems});

  BookingData.fromJson(Map<String, dynamic> json) {
    if (json['booking_items'] != null) {
      bookingItems = <BookingItems>[];
      json['booking_items'].forEach((v) {
        bookingItems!.add(new BookingItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookingItems != null) {
      data['booking_items'] =
          this.bookingItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingItems {
  int? id;
  int? bookingDetailId;
  int? pharmacyId;
  int? testManagementId;
  String? serviceName;
  String? serviceCode;
  String? mrpAmount;
  int? isApplyDiscount;
  int? isApplyPromoOffer;
  int? testType;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? encBookingItemId;
  String? createDate;
  String? createTime;

  BookingItems(
      {this.id,
        this.bookingDetailId,
        this.pharmacyId,
        this.testManagementId,
        this.serviceName,
        this.serviceCode,
        this.mrpAmount,
        this.isApplyDiscount,
        this.isApplyPromoOffer,
        this.testType,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.encBookingItemId,
        this.createDate,
        this.createTime});

  BookingItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingDetailId = json['booking_detail_id'];
    pharmacyId = json['pharmacy_id'];
    testManagementId = json['test_management_id'];
    serviceName = json['service_name'];
    serviceCode = json['service_code'];
    mrpAmount = json['mrp_amount'];
    isApplyDiscount = json['is_apply_discount'];
    isApplyPromoOffer = json['is_apply_promo_offer'];
    testType = json['test_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    encBookingItemId = json['enc_booking_item_id'];
    createDate = json['create_date'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_detail_id'] = this.bookingDetailId;
    data['pharmacy_id'] = this.pharmacyId;
    data['test_management_id'] = this.testManagementId;
    data['service_name'] = this.serviceName;
    data['service_code'] = this.serviceCode;
    data['mrp_amount'] = this.mrpAmount;
    data['is_apply_discount'] = this.isApplyDiscount;
    data['is_apply_promo_offer'] = this.isApplyPromoOffer;
    data['test_type'] = this.testType;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['enc_booking_item_id'] = this.encBookingItemId;
    data['create_date'] = this.createDate;
    data['create_time'] = this.createTime;
    return data;
  }
}

class Data {
  List<BookingItems>? bookingItems;

  Data({this.bookingItems});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['booking_items'] != null) {
      bookingItems = <BookingItems>[];
      json['booking_items'].forEach((v) {
        bookingItems!.add(new BookingItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookingItems != null) {
      data['booking_items'] =
          this.bookingItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


