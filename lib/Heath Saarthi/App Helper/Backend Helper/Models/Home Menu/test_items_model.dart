class TestItemsDetailsModel {
  dynamic status;
  Data? data;
  CartData? cartData;

  TestItemsDetailsModel({this.status, this.data, this.cartData});

  TestItemsDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    cartData = json['cartData'] != null
        ? new CartData.fromJson(json['cartData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.cartData != null) {
      data['cartData'] = this.cartData!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic costCenterId;
  dynamic userId;
  dynamic stateId;
  dynamic cityId;
  dynamic areaId;
  dynamic sufalamServiceId;
  String? serviceCode;
  String? serviceName;
  dynamic applicableGender;
  dynamic isPackage;
  dynamic isProfile;
  dynamic tatDays;
  dynamic tatHours;
  dynamic tatMinutes;
  String? serviceClassification;
  String? collect;
  String? specimenVolume;
  String? specimenPreparation;
  String? storageTemperature;
  dynamic maxDiscountPercentageAllow;
  dynamic vendorServiceCode;
  String? patientPreparation;
  dynamic isPopularPackage;
  dynamic popularPackageSerialNumber;
  String? serviceImage;
  dynamic serviceImage1;
  dynamic serviceImage2;
  String? orderingInfo;
  String? reported;
  String? notes;
  String? limitation;
  String? mrpAmount;
  String? b2bDiscountPercentage;
  String? b2bDiscountAmount;
  String? totalAmount;
  String? discountAmount;
  String? netAmount;
  String? visitorAmount;
  dynamic isB2bB2cPrice;
  dynamic displayPrice;
  dynamic isPriceUpdateByHsAdmin;
  dynamic isAppRegistrationAllow;
  dynamic isMobileNoCompulsoryinRegistration;
  dynamic isHomeVisitNotApplicable;
  dynamic isAddressCompulsoryinRegistration;
  String? serviceDescription;
  String? clinicalReference;
  dynamic status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? testList;
  String? encTestManagementId;
  String? createAt;
  dynamic bookedStatus;
  String? mrp;
  State? state;
  City? city;
  Area? area;

  Data(
      {this.id,
        this.costCenterId,
        this.userId,
        this.stateId,
        this.cityId,
        this.areaId,
        this.sufalamServiceId,
        this.serviceCode,
        this.serviceName,
        this.applicableGender,
        this.isPackage,
        this.isProfile,
        this.tatDays,
        this.tatHours,
        this.tatMinutes,
        this.serviceClassification,
        this.collect,
        this.specimenVolume,
        this.specimenPreparation,
        this.storageTemperature,
        this.maxDiscountPercentageAllow,
        this.vendorServiceCode,
        this.patientPreparation,
        this.isPopularPackage,
        this.popularPackageSerialNumber,
        this.serviceImage,
        this.serviceImage1,
        this.serviceImage2,
        this.orderingInfo,
        this.reported,
        this.notes,
        this.limitation,
        this.mrpAmount,
        this.b2bDiscountPercentage,
        this.b2bDiscountAmount,
        this.totalAmount,
        this.discountAmount,
        this.netAmount,
        this.visitorAmount,
        this.isB2bB2cPrice,
        this.displayPrice,
        this.isPriceUpdateByHsAdmin,
        this.isAppRegistrationAllow,
        this.isMobileNoCompulsoryinRegistration,
        this.isHomeVisitNotApplicable,
        this.isAddressCompulsoryinRegistration,
        this.serviceDescription,
        this.clinicalReference,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.testList,
        this.encTestManagementId,
        this.createAt,
        this.bookedStatus,
        this.mrp,
        this.state,
        this.city,
        this.area});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    costCenterId = json['cost_center_id'];
    userId = json['user_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    sufalamServiceId = json['sufalam_service_id'];
    serviceCode = json['service_code'];
    serviceName = json['service_name'];
    applicableGender = json['applicable_gender'];
    isPackage = json['is_package'];
    isProfile = json['is_profile'];
    tatDays = json['tat_days'];
    tatHours = json['tat_hours'];
    tatMinutes = json['tat_minutes'];
    serviceClassification = json['service_classification'];
    collect = json['collect'];
    specimenVolume = json['specimen_volume'];
    specimenPreparation = json['specimen_preparation'];
    storageTemperature = json['storage_temperature'];
    maxDiscountPercentageAllow = json['max_discount_percentage_allow'];
    vendorServiceCode = json['vendor_service_code'];
    patientPreparation = json['patient_preparation'];
    isPopularPackage = json['is_popular_package'];
    popularPackageSerialNumber = json['popular_package_serial_number'];
    serviceImage = json['service_image'];
    serviceImage1 = json['service_image_1'];
    serviceImage2 = json['service_image_2'];
    orderingInfo = json['ordering_info'];
    reported = json['reported'];
    notes = json['notes'];
    limitation = json['limitation'];
    mrpAmount = json['mrp_amount'];
    b2bDiscountPercentage = json['b2b_discount_percentage'];
    b2bDiscountAmount = json['b2b_discount_amount'];
    totalAmount = json['total_amount'];
    discountAmount = json['discount_amount'];
    netAmount = json['net_amount'];
    visitorAmount = json['visitor_amount'];
    isB2bB2cPrice = json['is_b2b_b2c_price'];
    displayPrice = json['display_price'];
    isPriceUpdateByHsAdmin = json['is_price_update_by_hs_admin'];
    isAppRegistrationAllow = json['is_app_registration_allow'];
    isMobileNoCompulsoryinRegistration =
    json['is_mobile_no_compulsoryin_registration'];
    isHomeVisitNotApplicable = json['is_home_visit_not_applicable'];
    isAddressCompulsoryinRegistration =
    json['is_address_compulsoryin_registration'];
    serviceDescription = json['service_description'];
    clinicalReference = json['clinical_reference'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    testList = json['testList'];
    encTestManagementId = json['enc_test_management_id'];
    createAt = json['create_at'];
    bookedStatus = json['booked_status'];
    mrp = json['mrp'];
    state = json['state'] != null ? new State.fromJson(json['state']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    area = json['area'] != null ? new Area.fromJson(json['area']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cost_center_id'] = this.costCenterId;
    data['user_id'] = this.userId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['sufalam_service_id'] = this.sufalamServiceId;
    data['service_code'] = this.serviceCode;
    data['service_name'] = this.serviceName;
    data['applicable_gender'] = this.applicableGender;
    data['is_package'] = this.isPackage;
    data['is_profile'] = this.isProfile;
    data['tat_days'] = this.tatDays;
    data['tat_hours'] = this.tatHours;
    data['tat_minutes'] = this.tatMinutes;
    data['service_classification'] = this.serviceClassification;
    data['collect'] = this.collect;
    data['specimen_volume'] = this.specimenVolume;
    data['specimen_preparation'] = this.specimenPreparation;
    data['storage_temperature'] = this.storageTemperature;
    data['max_discount_percentage_allow'] = this.maxDiscountPercentageAllow;
    data['vendor_service_code'] = this.vendorServiceCode;
    data['patient_preparation'] = this.patientPreparation;
    data['is_popular_package'] = this.isPopularPackage;
    data['popular_package_serial_number'] = this.popularPackageSerialNumber;
    data['service_image'] = this.serviceImage;
    data['service_image_1'] = this.serviceImage1;
    data['service_image_2'] = this.serviceImage2;
    data['ordering_info'] = this.orderingInfo;
    data['reported'] = this.reported;
    data['notes'] = this.notes;
    data['limitation'] = this.limitation;
    data['mrp_amount'] = this.mrpAmount;
    data['b2b_discount_percentage'] = this.b2bDiscountPercentage;
    data['b2b_discount_amount'] = this.b2bDiscountAmount;
    data['total_amount'] = this.totalAmount;
    data['discount_amount'] = this.discountAmount;
    data['net_amount'] = this.netAmount;
    data['visitor_amount'] = this.visitorAmount;
    data['is_b2b_b2c_price'] = this.isB2bB2cPrice;
    data['display_price'] = this.displayPrice;
    data['is_price_update_by_hs_admin'] = this.isPriceUpdateByHsAdmin;
    data['is_app_registration_allow'] = this.isAppRegistrationAllow;
    data['is_mobile_no_compulsoryin_registration'] =
        this.isMobileNoCompulsoryinRegistration;
    data['is_home_visit_not_applicable'] = this.isHomeVisitNotApplicable;
    data['is_address_compulsoryin_registration'] =
        this.isAddressCompulsoryinRegistration;
    data['service_description'] = this.serviceDescription;
    data['clinical_reference'] = this.clinicalReference;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['testList'] = this.testList;
    data['enc_test_management_id'] = this.encTestManagementId;
    data['create_at'] = this.createAt;
    data['booked_status'] = this.bookedStatus;
    data['mrp'] = this.mrp;
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
  dynamic id;
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
  dynamic id;
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
  dynamic id;
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

class CartData {
  dynamic count;
  dynamic amount;

  CartData({this.count, this.amount});

  CartData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['amount'] = this.amount;
    return data;
  }
}