import 'base.dart';

class EndPoints {
  static const _base = BasePaths.baseUrl;

  static const getUser = "$_base/user";
  static const login = "$_base/auth/studentLogin";

  static const lookupByEnrollmentNo = "$_base/auth/enrollmentNumber";
  static const studentLogin = "$_base/auth/studentLogin";
  
  static const verifyOtp = "$_base/verification";
  static const sendVerificationMail = "$_base/auth/studentMailVerify";
  static const setPassword = "$_base/auth/studentSignup";

  static const getProducts = "$_base/products";
  static const addProductsToCart = "$_base/cart/post";
  static const removeProductsToCart = "$_base/cart/delete";
  static const getProductsFromCart = "$_base/cart/get";

  static const register = "$_base/registration";

  static const verification = "$_base/verification";

  static const upadteUser = "$_base/me/update/info";

  static const home = "$_base/home";
  static const getSingleProduct = "$_base/product/";
  static const getEvents = "$_base/events/";
  static const getClubs = "$_base/clubs/";

  static const privacyPolicy = "https://ricoz.in/privacy-policy";
  static const termsOfService = "https://ricoz.in/termsandconditions";
}
