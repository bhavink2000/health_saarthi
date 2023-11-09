
class ApiUrls{

  //static String mainUrls = 'http://hssawpl.com/api/v1/'; // live url
  static String mainUrls = 'https://hs.windzoon.in/api/v1/'; //demo url


  static String loginUrl = '${mainUrls}pharmacy/login';
  static String logoutUrl = '${mainUrls}pharmacy/logout';

  static String addDeviceUrl = '${mainUrls}pharmacy/add-device-token';
  static String deleteDeviceUrl = '${mainUrls}pharmacy/delete-device-token';

  static String profileUrls = '${mainUrls}pharmacy/get-profile-data';
  static String updateProfileUrls = '${mainUrls}pharmacy/update-profile-data';

  static String popularPackage = '${mainUrls}pharmacy/get-popular-package';

  static String signUpUrl = '${mainUrls}pharmacy/register';
  static String forgotPasswordUrl = '${mainUrls}pharmacy/forgot-password';
  static String changePasswordUrl = '${mainUrls}pharmacy/change-password';

  static String sendOtpUrl = '${mainUrls}pharmacy/send-forgot-password-otp';
  static String reSendOtpUrl = '${mainUrls}pharmacy/send-forgot-password-otp';
  static String verifyOtpUrl = '${mainUrls}pharmacy/verify-forgot-password-otp';

  static String b2b_Saless_Url = '${mainUrls}pharmacy/get-b2b-subadmin-list';
  static String stateUrl = '${mainUrls}pharmacy/get-state-list';
  static String cityUrl = '${mainUrls}pharmacy/get-cities-from-state/';
  static String areaUrl = '${mainUrls}pharmacy/get-areas-from-state-and-city/';
  static String branchUrl = '${mainUrls}pharmacy/get-branches/';

  static String testListUrls = '${mainUrls}pharmacy/get-test-details-list';
  static String testItemDetailsUrls = '${mainUrls}pharmacy/get-test-detail-by-id/';
  static String packageListUrls = '${mainUrls}pharmacy/get-package-details-list';
  static String packageItemDetailsUrls = '${mainUrls}pharmacy/get-package-detail-by-id/';

  static String addItemsUrls = '${mainUrls}pharmacy/add-item-to-cart';
  static String removeItemsUrls = '${mainUrls}pharmacy/remove-item-from-cart';
  static String cartItemsUrls = '${mainUrls}pharmacy/cart-items-list';
  static String cartCalculationUrls = '${mainUrls}pharmacy/cart-calculation';

  static String mobileNumberListUrls = '${mainUrls}pharmacy/patient-search-from-mobile-no';
  static String patientProfileUrls = '${mainUrls}pharmacy/get-pharmacy-patient-by-id';
  static String bookOrderUrls = '${mainUrls}pharmacy/book-an-order';

  static String bookingHistoryUrls = '${mainUrls}pharmacy/get-booking-history';
  static String attachPrescriptionUrls = '${mainUrls}pharmacy/attach-prescription-and-book-order';
  static String instantBookingUrls = '${mainUrls}pharmacy/instant-book';

  static String todayDealUrls = '${mainUrls}pharmacy/get-todays-deals';
  static String todayDealDetailsUrls = '${mainUrls}pharmacy/todays-deals-lists';
  static String bannerUrls = '${mainUrls}pharmacy/get-banners-list';

  static String notificationUrls = '${mainUrls}pharmacy/get-notifications-list';

  static String dayReportUrls = '${mainUrls}pharmacy/get-daily-report';
  static String monthReportUrls = '${mainUrls}pharmacy/get-month-report';
  static String yearReportUrls = '${mainUrls}pharmacy/get-year-report';

  static String contactUsUrls = '${mainUrls}pharmacy/contact-info';
  static String supportUrls = '${mainUrls}pharmacy/support';
  static String referralPharmacyUrls = '${mainUrls}pharmacy/pharmacy-referral';
  static String globalSearchUrls = '${mainUrls}pharmacy/master-search';
  static String faqsUrls = '${mainUrls}pharmacy/faqs';
  static String requestManagementUrls = '${mainUrls}pharmacy/post-request-management';

  static String qrCodeUrl = '${mainUrls}pharmacy/download-qr-code';
}

// Live app changes

/*
(2.0 live on 11-10-2023)
(2.01 live on 30-10-2023) -> add multiple prescription / show cart price in bottom
(2.02 live on 02-11-2023) -> QR code design change/ add prescription in cart booking

  */



//var url = 'http://3.6.102.7/mobile-app/healthsaarthi.apk';
//var url = 'https://healthsaarthi.windzoon.in/app-release.apk';
//var url = 'https://drive.google.com/uc?id=1RG3CAPiwiFlFATUlIIwhk0RrbEU4PgVP&export=download';
//var url = 'http://hssawpl.com/mobile-app/healthsaarthi.apk';