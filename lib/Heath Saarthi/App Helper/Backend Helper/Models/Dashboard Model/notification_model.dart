class NotificationModel {
  int? status;
  List<Data>? data;

  NotificationModel({this.status, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  int? pharmacyId;
  int? bookingDetailId;
  int? requestManagementsId;
  String? title;
  String? message;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? encId;
  String? createAt;

  Data(
      {this.id,
        this.pharmacyId,
        this.bookingDetailId,
        this.requestManagementsId,
        this.title,
        this.message,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.encId,
        this.createAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pharmacyId = json['pharmacy_id'];
    bookingDetailId = json['booking_detail_id'];
    requestManagementsId = json['request_managements_id'];
    title = json['title'];
    message = json['message'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    encId = json['enc_id'];
    createAt = json['create_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pharmacy_id'] = this.pharmacyId;
    data['booking_detail_id'] = this.bookingDetailId;
    data['request_managements_id'] = this.requestManagementsId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['enc_id'] = this.encId;
    data['create_at'] = this.createAt;
    return data;
  }
}