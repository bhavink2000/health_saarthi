class AppTextHelper{

  var appVersion = '2.05';

  var patientName = 'The name field is required.';
  var patientMobile = 'The mobile no field is required.';

  var selectDocuments = 'Select at least one document update';
  var notUpdateUser = 'Not updatable for this user';

//------>>>>> cart screen
  var couponCode = 'Enter coupon code';
  var cartEmpty = 'There is no item in cart.';
  var selectLocation = 'Please select location';
  var setLocation = 'Please set location';

//----->>>>> user status check
  var inAccount = 'Your account is currently inactive. \nPlease contact support for assistance.';


  var internetProblem = "Unable to connect. \nPlease verify your internet connection and try again";
  var serverError = "Server Issue:\nWe're on it! Please bear with us";
  var internalServerError = 'Our server is temporarily unavailable.\nPlease check back shortly';

//----->>>>> forgot password
  var enterMobileNo = 'Enter mobile number';
  var enterOTP = 'Enter OTP';
  var resendOTP = 'Unable to resend OTP';
  var enterPassword = 'Enter password';
  var enterCPassword = 'Enter confirm password';
  var enterCPNotMatch = 'Password & Confirm password not match';

//----->>>>> pagination check
  var firstPage = 'Already on first page';
  var lastPage = 'Already on last page';

//----->>>>> for chart
  var selectYear = 'Please select year';
  var selectMonth = 'Please select month';
  var selectDay = 'Please select day';

//----->>>>> location check
  var selectState = 'The state id field is required.';
  var selectCity = 'The city id field is required.';
  var selectArea = 'The area id field is required.';
  var selectBranch = 'The cost center id field is required.';

//----->>>>> document check
  var panCardSelect = 'Please select PAN card img';
  var addressSelect = 'Please select address proof';
  var aadhaarCardFSelect = 'Please select aadhaar card front';
  var aadhaarCardBSelect = 'Please select aadhaar card back';
  var chequeImgSelect = 'Please select cheque img';
  var gstImgSelect = 'Please select GST img';
}

class ValidationText{
  static String vendorName = 'Enter vendor name';
  static String emailId = 'Enter a email';
  static String emailValidation = 'email id must contain at least one special character';
  static String pharmacyName = 'Enter pharmacy name';
  static String mobileNumber = 'Enter mobile number';

  static String stateSelect = 'Select a state';
  static String citySelect = 'Select a city';
  static String branchSelect = 'Select a branch';
  static String areaSelect = 'Select a area';

  static String salesExecutive = 'Select a sales executive';
  static String address = 'Enter address';

  static String gstLength = 'Enter must be 15 characters long';
  static String bankName = 'Enter bank name';
  static String beneficiaryNm = 'Enter beneficiary name';
}