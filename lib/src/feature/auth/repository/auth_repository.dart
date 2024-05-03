import 'dart:convert';
import 'dart:developer';

import 'package:ccms/src/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import '../../../res/endpoints.dart';
import '../../../res/strings.dart';

final authRepoProvider = Provider((ref) {
  final api = ref.watch(networkRepoProvider);
  return AuthRepo(api: api);
});

class AuthRepo {
  final NetworkRepo _api;

  AuthRepo({required NetworkRepo api}) : _api = api;

  Future<Response?> registerEnrollmentNumber(
      {required String enrollmentNumber}) async {
    final body = {
      "enrollmentNumber": enrollmentNumber,
    };
    final result = await _api.postRequest(
        url: Endpoints.lookupByEnrollmentNo, body: body, requireAuth: false);
    return result.fold(
      (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
      (Response response) {
        return response;
      },
    );
  }

  Future<Response?> verifyEmail({required String email}) async {
    final body = {
      "email": email,
    };

    final result = await _api.postRequest(
        url: Endpoints.verification, body: body, requireAuth: false);
    return result.fold(
      (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
      (Response response) => response,
    );
  }

  Future<Response?> sendVerificationMail({required String email,required String enrollmentNumber}) async {
    final body = {
      "email": email,
      "enrollmentNumber" : enrollmentNumber
    };
    final result = await _api.postRequest(
        url: Endpoints.sendVerificationMail, body: body, requireAuth: false);

    return result.fold(
      (Failure failure) {
        log(
          failure.message,
          name: LogLabel.auth,
        );
        return null;
      },
      (Response response) => response,
    );
  }

  Future<Response?> setPassword(
      {required String password, required String email,required String enrollmentNumber}) async {
    final body = {
      "email": email,
      "password": password,
      "enrollmentNumber" : enrollmentNumber
    };

    final result = await _api.postRequest(
      url: Endpoints.setPassword,
      body: body,
      requireAuth: false,
    );
    return result.fold((Failure failure) {
      log(failure.message, name: LogLabel.auth);
      return null;
    }, (Response response) => response);
  }

  Future<Response?> login(
      {required String email, required String password}) async {
    final body = {
      "email": email,
      "password": password,
    };

    final result = await _api.postRequest(
        url: Endpoints.studentLogin, body: body, requireAuth: false);

    return result.fold((Failure failure) {
      log(
        failure.message,
        name: LogLabel.auth,
      );
      return null;
    }, (Response response) {
      return response;
    });
  }

  Future<void> signOut() async {}
}
