/// Contains all the strings used accross the app.
/// Avoid hard coding strings.
/// All the strings must be added in this file.
/// ```dart
/// class AppStrings{
///  static const appName = "Riverpod app template";
///}
///```

class AppStrings{
  static const appName = "Riverpod app template";
}

class FailureMessage {
  static const getRequestMessage = "GET REQUEST FAILED";
  static const postRequestMessage = "POST REQUEST FAILED";
  static const putRequestMessage = "PUT REQUEST FAILED";
  static const deleteRequestMessage = "DELETE REQUEST FAILED";
  

  static const jsonParsingFailed = "FAILED TO PARSE JSON RESPONSE";

  static const authTokenEmpty = "AUTH TOKEN EMPTY";
}

class SnackBarMessages {

  static const enrollmentNumberFound = "Enrollment Number Found";
  static const enrollmentNumberNotFound = "Enrollment Number Not Found";

  static const productLoadSuccess = "Products Loaded Successfully";
  static const productLoadFailed = "Failed To Load Products";

  static const emailSendSuccess = "Email Sent Successfully";
  static const emailSendFailed = "Failed to Send Email";

  static const emailVerificationSuccess = "Email Verification Successful";
  static const emailVerificationFailed = "Email Verification Failed";

  static const userUpdateSuccess = "User update Successful";
  static const userUpdateFailed = "User update Failed";

  static const passwordSetSuccess = "Password Set Successful";
  static const passwordSetFailed = "Password Set Failed";

  static const loginSuccess = "Login Successfull";
  static const loginFailure = "Login Failed";
  static const incorrectPassword = "Password is Incorrect";
  

  static const nameCannotBeEmpty = "Name Can't be empty";
}

class LogLabel {
  static const product = "PRODUCT";
  static const auth = "AUTH";
  static const httpGet = "HTTP/GET";
  static const httpPost = "HTTP/POST";
  static const httpPut = "HTTP/PUT";
  static const httpDelete = "HTTP/DELETE";
  static const sharedPrefs = "SHARED_PREFERENCES";
}