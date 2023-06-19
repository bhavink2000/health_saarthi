import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  int status;
  Data data;

  CartModel({
    required this.status,
    required this.data,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  String grossAmount;
  String netAmount;
  CartItems cartItems;
  List<GlobalSettingSlot> globalSettingTestSlot;
  List<GlobalSettingSlot> globalSettingPackageSlot;
  List<GlobalSettingSlot> globalSettingProfileSlot;

  Data({
    required this.grossAmount,
    required this.netAmount,
    required this.cartItems,
    required this.globalSettingTestSlot,
    required this.globalSettingPackageSlot,
    required this.globalSettingProfileSlot,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    grossAmount: json["gross_amount"],
    netAmount: json["net_amount"],
    cartItems: CartItems.fromJson(json["cart_items"]),
    globalSettingTestSlot: List<GlobalSettingSlot>.from(json["GlobalSettingTestSlot"].map((x) => GlobalSettingSlot.fromJson(x))),
    globalSettingPackageSlot: List<GlobalSettingSlot>.from(json["GlobalSettingPackageSlot"].map((x) => GlobalSettingSlot.fromJson(x))),
    globalSettingProfileSlot: List<GlobalSettingSlot>.from(json["GlobalSettingProfileSlot"].map((x) => GlobalSettingSlot.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "gross_amount": grossAmount,
    "net_amount": netAmount,
    "cart_items": cartItems.toJson(),
    "GlobalSettingTestSlot": List<dynamic>.from(globalSettingTestSlot.map((x) => x.toJson())),
    "GlobalSettingPackageSlot": List<dynamic>.from(globalSettingPackageSlot.map((x) => x.toJson())),
    "GlobalSettingProfileSlot": List<dynamic>.from(globalSettingProfileSlot.map((x) => x.toJson())),
  };
}

class CartItems {
  int id;
  int pharmacyId;
  dynamic pharmacyPatientId;
  dynamic grossAmount;
  dynamic discountAmount;
  dynamic promoCode;
  dynamic promoCodeAmount;
  dynamic visitingCharge;
  dynamic netAmount;
  dynamic testDiscountTypeId;
  dynamic testDiscountValue;
  dynamic packageDiscountTypeId;
  dynamic packageDiscountValue;
  dynamic profileDiscountValue;
  dynamic profileDiscountTypeId;
  dynamic pharmacyTestLockDiscountValue;
  dynamic pharmacyPackageLockDiscountValue;
  dynamic pharmacyProfileLockDiscountValue;
  dynamic b2BSubadminTestLockDiscountValue;
  dynamic b2BSubadminPackageLockDiscountValue;
  dynamic b2BSubadminProfileLockDiscountValue;
  dynamic prescription;
  dynamic collectionDate;
  dynamic remarks;
  DateTime createdAt;
  DateTime updatedAt;
  String encCartId;
  String createAt;
  List<Item> testItems;
  List<Item> packageItems;
  List<Item> profileItems;

  CartItems({
    required this.id,
    required this.pharmacyId,
    this.pharmacyPatientId,
    this.grossAmount,
    this.discountAmount,
    this.promoCode,
    this.promoCodeAmount,
    this.visitingCharge,
    this.netAmount,
    this.testDiscountTypeId,
    this.testDiscountValue,
    this.packageDiscountTypeId,
    this.packageDiscountValue,
    this.profileDiscountValue,
    this.profileDiscountTypeId,
    this.pharmacyTestLockDiscountValue,
    this.pharmacyPackageLockDiscountValue,
    this.pharmacyProfileLockDiscountValue,
    this.b2BSubadminTestLockDiscountValue,
    this.b2BSubadminPackageLockDiscountValue,
    this.b2BSubadminProfileLockDiscountValue,
    this.prescription,
    this.collectionDate,
    this.remarks,
    required this.createdAt,
    required this.updatedAt,
    required this.encCartId,
    required this.createAt,
    required this.testItems,
    required this.packageItems,
    required this.profileItems,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) => CartItems(
    id: json["id"],
    pharmacyId: json["pharmacy_id"],
    pharmacyPatientId: json["pharmacy_patient_id"],
    grossAmount: json["gross_amount"],
    discountAmount: json["discount_amount"],
    promoCode: json["promo_code"],
    promoCodeAmount: json["promo_code_amount"],
    visitingCharge: json["visiting_charge"],
    netAmount: json["net_amount"],
    testDiscountTypeId: json["test_discount_type_id"],
    testDiscountValue: json["test_discount_value"],
    packageDiscountTypeId: json["package_discount_type_id"],
    packageDiscountValue: json["package_discount_value"],
    profileDiscountValue: json["profile_discount_value"],
    profileDiscountTypeId: json["profile_discount_type_id"],
    pharmacyTestLockDiscountValue: json["pharmacy_test_lock_discount_value"],
    pharmacyPackageLockDiscountValue: json["pharmacy_package_lock_discount_value"],
    pharmacyProfileLockDiscountValue: json["pharmacy_profile_lock_discount_value"],
    b2BSubadminTestLockDiscountValue: json["b2b_subadmin_test_lock_discount_value"],
    b2BSubadminPackageLockDiscountValue: json["b2b_subadmin_package_lock_discount_value"],
    b2BSubadminProfileLockDiscountValue: json["b2b_subadmin_profile_lock_discount_value"],
    prescription: json["prescription"],
    collectionDate: json["collection_date"],
    remarks: json["remarks"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    encCartId: json["enc_cart_id"],
    createAt: json["create_at"],
    testItems: List<Item>.from(json["test_items"].map((x) => Item.fromJson(x))),
    packageItems: List<Item>.from(json["package_items"].map((x) => Item.fromJson(x))),
    profileItems: List<Item>.from(json["profile_items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pharmacy_id": pharmacyId,
    "pharmacy_patient_id": pharmacyPatientId,
    "gross_amount": grossAmount,
    "discount_amount": discountAmount,
    "promo_code": promoCode,
    "promo_code_amount": promoCodeAmount,
    "visiting_charge": visitingCharge,
    "net_amount": netAmount,
    "test_discount_type_id": testDiscountTypeId,
    "test_discount_value": testDiscountValue,
    "package_discount_type_id": packageDiscountTypeId,
    "package_discount_value": packageDiscountValue,
    "profile_discount_value": profileDiscountValue,
    "profile_discount_type_id": profileDiscountTypeId,
    "pharmacy_test_lock_discount_value": pharmacyTestLockDiscountValue,
    "pharmacy_package_lock_discount_value": pharmacyPackageLockDiscountValue,
    "pharmacy_profile_lock_discount_value": pharmacyProfileLockDiscountValue,
    "b2b_subadmin_test_lock_discount_value": b2BSubadminTestLockDiscountValue,
    "b2b_subadmin_package_lock_discount_value": b2BSubadminPackageLockDiscountValue,
    "b2b_subadmin_profile_lock_discount_value": b2BSubadminProfileLockDiscountValue,
    "prescription": prescription,
    "collection_date": collectionDate,
    "remarks": remarks,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "enc_cart_id": encCartId,
    "create_at": createAt,
    "test_items": List<dynamic>.from(testItems.map((x) => x.toJson())),
    "package_items": List<dynamic>.from(packageItems.map((x) => x.toJson())),
    "profile_items": List<dynamic>.from(profileItems.map((x) => x.toJson())),
  };
}

class Item {
  int id;
  int pharmacyId;
  int cartId;
  int testManagementsId;
  DateTime createdAt;
  DateTime updatedAt;
  String encCartItemId;
  String createAt;
  ItemInfo? packageItemInfo;
  ItemInfo? profileItemInfo;
  ItemInfo? testItemInfo;

  Item({
    required this.id,
    required this.pharmacyId,
    required this.cartId,
    required this.testManagementsId,
    required this.createdAt,
    required this.updatedAt,
    required this.encCartItemId,
    required this.createAt,
    this.packageItemInfo,
    this.profileItemInfo,
    this.testItemInfo,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    pharmacyId: json["pharmacy_id"],
    cartId: json["cart_id"],
    testManagementsId: json["test_managements_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    encCartItemId: json["enc_cart_item_id"],
    createAt: json["create_at"],
    packageItemInfo: json["package_item_info"] == null ? null : ItemInfo.fromJson(json["package_item_info"]),
    profileItemInfo: json["profile_item_info"] == null ? null : ItemInfo.fromJson(json["profile_item_info"]),
    testItemInfo: json["test_item_info"] == null ? null : ItemInfo.fromJson(json["test_item_info"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pharmacy_id": pharmacyId,
    "cart_id": cartId,
    "test_managements_id": testManagementsId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "enc_cart_item_id": encCartItemId,
    "create_at": createAt,
    "package_item_info": packageItemInfo?.toJson(),
    "profile_item_info": profileItemInfo?.toJson(),
    "test_item_info": testItemInfo?.toJson(),
  };
}

class ItemInfo {
  int id;
  int costCenterId;
  dynamic userId;
  int stateId;
  int cityId;
  int areaId;
  int sufalamServiceId;
  String serviceCode;
  String serviceName;
  String applicableGender;
  int isPackage;
  int isProfile;
  String? tatDays;
  String tatHours;
  String? tatMinutes;
  String serviceClassification;
  String collect;
  String specimenVolume;
  String specimenPreparation;
  String storageTemperature;
  String? maxDiscountPercentageAllow;
  dynamic vendorServiceCode;
  String patientPreparation;
  int isPopularPackage;
  dynamic popularPackageSerialNumber;
  String? serviceImage;
  dynamic serviceImage1;
  dynamic serviceImage2;
  String orderingInfo;
  String reported;
  String notes;
  String limitation;
  String mrpAmount;
  String b2BDiscountPercentage;
  String b2BDiscountAmount;
  String totalAmount;
  String discountAmount;
  String netAmount;
  String visitorAmount;
  int isB2BB2CPrice;
  dynamic displayPrice;
  int isAppRegistrationAllow;
  int isMobileNoCompulsoryinRegistration;
  int isHomeVisitNotApplicable;
  int isAddressCompulsoryinRegistration;
  dynamic serviceDescription;
  String clinicalReference;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String encTestManagementId;
  String createAt;
  String mrp;

  ItemInfo({
    required this.id,
    required this.costCenterId,
    this.userId,
    required this.stateId,
    required this.cityId,
    required this.areaId,
    required this.sufalamServiceId,
    required this.serviceCode,
    required this.serviceName,
    required this.applicableGender,
    required this.isPackage,
    required this.isProfile,
    this.tatDays,
    required this.tatHours,
    this.tatMinutes,
    required this.serviceClassification,
    required this.collect,
    required this.specimenVolume,
    required this.specimenPreparation,
    required this.storageTemperature,
    this.maxDiscountPercentageAllow,
    this.vendorServiceCode,
    required this.patientPreparation,
    required this.isPopularPackage,
    this.popularPackageSerialNumber,
    this.serviceImage,
    this.serviceImage1,
    this.serviceImage2,
    required this.orderingInfo,
    required this.reported,
    required this.notes,
    required this.limitation,
    required this.mrpAmount,
    required this.b2BDiscountPercentage,
    required this.b2BDiscountAmount,
    required this.totalAmount,
    required this.discountAmount,
    required this.netAmount,
    required this.visitorAmount,
    required this.isB2BB2CPrice,
    this.displayPrice,
    required this.isAppRegistrationAllow,
    required this.isMobileNoCompulsoryinRegistration,
    required this.isHomeVisitNotApplicable,
    required this.isAddressCompulsoryinRegistration,
    this.serviceDescription,
    required this.clinicalReference,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.encTestManagementId,
    required this.createAt,
    required this.mrp,
  });

  factory ItemInfo.fromJson(Map<String, dynamic> json) => ItemInfo(
    id: json["id"],
    costCenterId: json["cost_center_id"],
    userId: json["user_id"],
    stateId: json["state_id"],
    cityId: json["city_id"],
    areaId: json["area_id"],
    sufalamServiceId: json["sufalam_service_id"],
    serviceCode: json["service_code"],
    serviceName: json["service_name"],
    applicableGender: json["applicable_gender"],
    isPackage: json["is_package"],
    isProfile: json["is_profile"],
    tatDays: json["tat_days"],
    tatHours: json["tat_hours"],
    tatMinutes: json["tat_minutes"],
    serviceClassification: json["service_classification"],
    collect: json["collect"],
    specimenVolume: json["specimen_volume"],
    specimenPreparation: json["specimen_preparation"],
    storageTemperature: json["storage_temperature"],
    maxDiscountPercentageAllow: json["max_discount_percentage_allow"],
    vendorServiceCode: json["vendor_service_code"],
    patientPreparation: json["patient_preparation"],
    isPopularPackage: json["is_popular_package"],
    popularPackageSerialNumber: json["popular_package_serial_number"],
    serviceImage: json["service_image"],
    serviceImage1: json["service_image_1"],
    serviceImage2: json["service_image_2"],
    orderingInfo: json["ordering_info"],
    reported: json["reported"],
    notes: json["notes"],
    limitation: json["limitation"],
    mrpAmount: json["mrp_amount"],
    b2BDiscountPercentage: json["b2b_discount_percentage"],
    b2BDiscountAmount: json["b2b_discount_amount"],
    totalAmount: json["total_amount"],
    discountAmount: json["discount_amount"],
    netAmount: json["net_amount"],
    visitorAmount: json["visitor_amount"],
    isB2BB2CPrice: json["is_b2b_b2c_price"],
    displayPrice: json["display_price"],
    isAppRegistrationAllow: json["is_app_registration_allow"],
    isMobileNoCompulsoryinRegistration: json["is_mobile_no_compulsoryin_registration"],
    isHomeVisitNotApplicable: json["is_home_visit_not_applicable"],
    isAddressCompulsoryinRegistration: json["is_address_compulsoryin_registration"],
    serviceDescription: json["service_description"],
    clinicalReference: json["clinical_reference"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    encTestManagementId: json["enc_test_management_id"],
    createAt: json["create_at"],
    mrp: json["mrp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cost_center_id": costCenterId,
    "user_id": userId,
    "state_id": stateId,
    "city_id": cityId,
    "area_id": areaId,
    "sufalam_service_id": sufalamServiceId,
    "service_code": serviceCode,
    "service_name": serviceName,
    "applicable_gender": applicableGender,
    "is_package": isPackage,
    "is_profile": isProfile,
    "tat_days": tatDays,
    "tat_hours": tatHours,
    "tat_minutes": tatMinutes,
    "service_classification": serviceClassification,
    "collect": collect,
    "specimen_volume": specimenVolume,
    "specimen_preparation": specimenPreparation,
    "storage_temperature": storageTemperature,
    "max_discount_percentage_allow": maxDiscountPercentageAllow,
    "vendor_service_code": vendorServiceCode,
    "patient_preparation": patientPreparation,
    "is_popular_package": isPopularPackage,
    "popular_package_serial_number": popularPackageSerialNumber,
    "service_image": serviceImage,
    "service_image_1": serviceImage1,
    "service_image_2": serviceImage2,
    "ordering_info": orderingInfo,
    "reported": reported,
    "notes": notes,
    "limitation": limitation,
    "mrp_amount": mrpAmount,
    "b2b_discount_percentage": b2BDiscountPercentage,
    "b2b_discount_amount": b2BDiscountAmount,
    "total_amount": totalAmount,
    "discount_amount": discountAmount,
    "net_amount": netAmount,
    "visitor_amount": visitorAmount,
    "is_b2b_b2c_price": isB2BB2CPrice,
    "display_price": displayPrice,
    "is_app_registration_allow": isAppRegistrationAllow,
    "is_mobile_no_compulsoryin_registration": isMobileNoCompulsoryinRegistration,
    "is_home_visit_not_applicable": isHomeVisitNotApplicable,
    "is_address_compulsoryin_registration": isAddressCompulsoryinRegistration,
    "service_description": serviceDescription,
    "clinical_reference": clinicalReference,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "enc_test_management_id": encTestManagementId,
    "create_at": createAt,
    "mrp": mrp,
  };
}

class GlobalSettingSlot {
  int id;
  int globalSettingId;
  String slotValue;
  int slotType;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String encGlobalSettingSlotId;
  String createAt;

  GlobalSettingSlot({
    required this.id,
    required this.globalSettingId,
    required this.slotValue,
    required this.slotType,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.encGlobalSettingSlotId,
    required this.createAt,
  });

  factory GlobalSettingSlot.fromJson(Map<String, dynamic> json) => GlobalSettingSlot(
    id: json["id"],
    globalSettingId: json["global_setting_id"],
    slotValue: json["slot_value"],
    slotType: json["slot_type"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    encGlobalSettingSlotId: json["enc_global_setting_slot_id"],
    createAt: json["create_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "global_setting_id": globalSettingId,
    "slot_value": slotValue,
    "slot_type": slotType,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "enc_global_setting_slot_id": encGlobalSettingSlotId,
    "create_at": createAt,
  };
}