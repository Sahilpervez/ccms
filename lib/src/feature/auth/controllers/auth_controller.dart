import 'dart:convert';
import 'dart:developer';

import 'package:ccms/src/feature/auth/views/enrollment_details_screen.dart';
import 'package:ccms/src/feature/auth/views/login.dart';
import 'package:ccms/src/feature/auth/views/set_password_screen.dart';
import 'package:ccms/src/feature/auth/views/verify_email_screen.dart';
import 'package:ccms/src/feature/home/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../global/controller/shared_prefs_controller.dart';
import '../../../global/providers/common_providers.dart';
import '../../../models/student.dart';
import '../../../res/strings.dart';
import '../../../utils/snackbar_service.dart';
import '../repository/auth_repository.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthController(authRepo: authRepo, ref: ref);
});

class AuthController extends StateNotifier<bool> {
  AuthController({required AuthRepo authRepo, required Ref ref})
      : _authRepo = authRepo,
        _ref = ref,
        super(false);

  final AuthRepo _authRepo;
  final Ref _ref;

  Future<void> registerEnrollmentNumber(
      {required String enrollmentNumber, required BuildContext context}) async {
    if (!state) {
      state = true;
      String enrollnum = enrollmentNumber;
      String result = enrollnum.replaceAll("/", "");
      print("enrollnum =  $result");

      _authRepo
          .registerEnrollmentNumber(enrollmentNumber: result)
          .then((response) {
        if (response != null) {
          final res = jsonDecode(response.body);
          print(res);
          final otpSentSuccess = res['success'];
          if (otpSentSuccess != null && otpSentSuccess == true) {
            if (res["body"]["message"] == "Signup") {
              SnackBarService.showSnackBar(
                  context: context,
                  message: SnackBarMessages.enrollmentNumberFound);
              state = false;
              context.push(EnrollmentDetailsScreen.routePath, extra: {
                "enrollment_number": enrollmentNumber,
                "name": (res["body"]['name'] == null)?"There" : (res["body"]['name'] as String),
              });
            } else if (res["body"]["message"] == "Login") {
              state = false;
              context.go(LoginScreen.routePath,extra: {
                "email" : res['body']['email'] as String
              });
            }
          } else {
            SnackBarService.showSnackBar(
                context: context,
                message: SnackBarMessages.enrollmentNumberNotFound);
          }
        }
      });
      // context.push(EnrollmentDetailsScreen.routePath, extra: {
      //   "enrollment_number": enrollmentNumber,
      //   "name": "Alam Sahilpervez"
      // });
      await Future.delayed(const Duration(seconds: 3));
      state = false;
    }
  }

  Future<void> verifyEmail(
      {required String email, required String enrollmentNumber ,required BuildContext context}) async {
    state = true;
    context.go(SetPasswordScreen.routePath,
        extra: {"email": email, "enrollmentNumber" : enrollmentNumber,"name": "John Doe"});
    state = false;
    return;
    _authRepo.verifyEmail(email: email).then((response) {
      if (response != null) {
        try {
          final data = jsonDecode(response.body);
          final emailVerifiedSuccess = data['success'];
          if (emailVerifiedSuccess) {
            SnackBarService.showSnackBar(
                context: context,
                message: SnackBarMessages.emailVerificationSuccess);
          } else {
            SnackBarService.showSnackBar(
                context: context,
                message: SnackBarMessages.emailVerificationFailed);
            return;
          }
          return ;

          final token = data['token'];

          if (token != null) {
            _ref.read(sharedPrefsControllerPovider).setCookie(cookie: token);
            _ref.read(authTokenProvider.notifier).update((state) => token);
          }
          final user = Student.fromJson(data['user']);
          if ("${user.firstName} ${user.lastName}".isNotEmpty) {
            _ref.read(sharedPrefsControllerPovider).setUser(user: user);
            _ref.read(currentUserProvider.notifier).update((state) => user);
            // TODO : Implement Navigation
            // context.go(RicozAppView.routePath);
            context.go(SetPasswordScreen.routePath, extra: {
              "email": email,
            });
          } else {
            // the user does not have a name
            // navigate to the screen where a name can be entered.
            state = false;
            // TODO: Implement Navigation
            // context.push(NameInputView.routePath);
            context.go(SetPasswordScreen.routePath, extra: {
              "email": email,
            });
          }
        } catch (e) {
          log(FailureMessage.jsonParsingFailed, name: LogLabel.auth);
        }
      }
    });
    context.go(SetPasswordScreen.routePath,
        extra: {"email": email, "name": "John Doe"});
    state = false;
  }

  Future<void> sendVerificationMail(
      {required String email,required String enrollmentNumber, required BuildContext context}) async {
    if (!state) {
      state = true;
      String enrollnum = enrollmentNumber;
      String result = enrollnum.replaceAll("/", "");
      print("enrollnum =  $result");
      _authRepo.sendVerificationMail(email: email,enrollmentNumber: result).then((response) {
        if (response != null) {
          final res = jsonDecode(response.body);
          // status of response
          final status = res['success'];

          if (status == true) {
            SnackBarService.showSnackBar(
                context: context, message: SnackBarMessages.emailSendSuccess);
            context.push(VerifyEmailScreen.routePath, extra: {"email": email,"enrollmentNumber": enrollnum});
          } else {
            SnackBarService.showSnackBar(
                context: context, message: SnackBarMessages.emailSendFailed);
          }
        }
      });
    }
    // context.push(VerifyEmailScreen.routePath, extra: {"email": email});
    state = false;
  }

  Future<void> setPassword(
      {required String password,
      required String email,
      required String enrollmentNumber,
      required BuildContext context}) async {
        log("$enrollmentNumber, $email, $password", name: "ENROLLMENT NUMBER INSIDE SET PASSWORD");
        String enrollnum = enrollmentNumber;
      String result = enrollnum.replaceAll("/", "");
      print("enrollnum =  $result");
    if (!state) {
      state = true;
      _authRepo.setPassword(password: password, email: email,enrollmentNumber: result).then((response) {
        if (response != null) {
          final res = jsonDecode(response.body);

          final status = res['success'];

          if (status == true) {
            SnackBarService.showSnackBar(
                context: context, message: SnackBarMessages.passwordSetSuccess);
            context.push(HomeView.routePath);
            final token = res['token'];
            if (token != null) {
              _ref.read(sharedPrefsControllerPovider).setCookie(cookie: token);
              _ref.read(authTokenProvider.notifier).update((state) => token);
            }
            log(token,name: "TOKEN");
          } else {
            SnackBarService.showSnackBar(
                context: context, message: "${res['body']['message']}");
            state = false;
            return;
          }
        }
      });
    }
    state = false;
   }

  Future<void> login({required BuildContext context, required String email, required String password})async{
    if(!state){
      state = true;
      _authRepo.login(email: email, password: password).then((response){
        if(response != null){
          // Response have some body
          final res = jsonDecode(response.body);

          final status = res['success'];

          if(status != null && status == true){
            state = false;
            final body = res['body'];
            
            log(body['student'].toString(),name: "AUTH LOGIN BODY");
            _ref.read(authTokenProvider.notifier).update((state) {
              return body["token"];
            },);
            _ref.read(sharedPrefsControllerPovider).setCookie(cookie: body['token']);
            _ref.read(currentUserProvider.notifier).update((state) {
              return Student.fromMap(body['student']);
            },);

            _ref.read(sharedPrefsControllerPovider).setUser(user: Student.fromMap(body['student']));
            state = false;
            // return;
            SnackBarService.showSnackBar(context: context, message: SnackBarMessages.loginSuccess);
            context.go(HomeView.routePath);
          }else if(status == null || status == false){
            SnackBarService.showSnackBar(context: context, message: res["error"]);
            state = false;
          }
          return;
        }else{
          // Failure occured
          SnackBarService.showSnackBar(context: context, message: SnackBarMessages.loginFailure);
          state = false;
          return;
        }
      });
    }
  }

  Future<void> signOut({BuildContext? context}) async {
    _ref.read(authTokenProvider.notifier).update((state) => null);
    _ref.read(currentUserProvider.notifier).update((state) => null);
    _ref.read(sharedPrefsControllerPovider).clear();
    if (context != null) {
      // TODO : Implement Navigation
      // context.go(LoginView.routePath);
    }
  }
}
