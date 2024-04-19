import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ccms/src/core/core.dart';
import 'package:ccms/src/global/repo/shared_prefs_repo.dart';
import 'package:ccms/src/models/student.dart';

final sharedPrefsControllerPovider = Provider((ref){
  final repo = ref.watch(sharedPrefsRepoProvider);
  return SharedPrefsController(repo: repo);
});


class SharedPrefsController {
  final SharedPrefsRepo _repo;

  SharedPrefsController({required SharedPrefsRepo repo}):_repo = repo;

  Future<String?> getCookie() async {
    return _repo.getCookie();
  }

  FutureVoid setCookie({required String cookie}) async {
    await _repo.setCookie(cookie);
  }

  Future<Student?> getUser() async {
    return _repo.getCurrentUser();
  }

  FutureVoid setUser({required Student user}) async {
    _repo.setCurrentUser(user);
  }

  FutureVoid clear() async {
    return _repo.clear();
  }
}