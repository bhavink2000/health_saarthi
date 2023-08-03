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
  int? bookingCode;
  int? pharmacyPatientId;
  String? grossAmount;
  String? netAmount;
  String? pharmacyDiscountAmount;
  String? createdAt;
  String? encBookingDetailId;
  String? createAt;
  PharmacyPatient? pharmacyPatient;

  BookingItems(
      {this.id,
        this.bookingCode,
        this.pharmacyPatientId,
        this.grossAmount,
        this.netAmount,
        this.pharmacyDiscountAmount,
        this.createdAt,
        this.encBookingDetailId,
        this.createAt,
        this.pharmacyPatient});

  BookingItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingCode = json['booking_code'];
    pharmacyPatientId = json['pharmacy_patient_id'];
    grossAmount = json['gross_amount'];
    netAmount = json['net_amount'];
    pharmacyDiscountAmount = json['pharmacy_discount_amount'];
    createdAt = json['created_at'];
    encBookingDetailId = json['enc_booking_detail_id'];
    createAt = json['create_at'];
    pharmacyPatient = json['pharmacy_patient'] != null
        ? new PharmacyPatient.fromJson(json['pharmacy_patient'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_code'] = this.bookingCode;
    data['pharmacy_patient_id'] = this.pharmacyPatientId;
    data['gross_amount'] = this.grossAmount;
    data['net_amount'] = this.netAmount;
    data['pharmacy_discount_amount'] = this.pharmacyDiscountAmount;
    data['created_at'] = this.createdAt;
    data['enc_booking_detail_id'] = this.encBookingDetailId;
    data['create_at'] = this.createAt;
    if (this.pharmacyPatient != null) {
      data['pharmacy_patient'] = this.pharmacyPatient!.toJson();
    }
    return data;
  }
}

class PharmacyPatient {
  int? id;
  String? name;
  String? mobileNo;
  String? createdAt;
  String? encPharmacyPatientId;
  String? createAt;

  PharmacyPatient(
      {this.id,
        this.name,
        this.mobileNo,
        this.createdAt,
        this.encPharmacyPatientId,
        this.createAt});

  PharmacyPatient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    createdAt = json['created_at'];
    encPharmacyPatientId = json['enc_pharmacy_patient_id'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile_no'] = this.mobileNo;
    data['created_at'] = this.createdAt;
    data['enc_pharmacy_patient_id'] = this.encPharmacyPatientId;
    data['create_at'] = this.createAt;
    return data;
  }
}