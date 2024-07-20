import 'package:placement_app/data/api/api.dart';
import 'package:placement_app/data/models/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class UserRepo {
  late API _api;
  late SharedPreferences _prefs;
  UserRepo(SharedPreferences prefs) {
    _api = API();
    _prefs = prefs;
  }

  static Future<UserRepo> init() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    return UserRepo(p);
  }

  Future<LoginUser?> getUser() async {
    final user = _prefs.getString("user");

    if (user == null) return null;

    return LoginUser.fromJson(user);
  }

  Future<LoginUser?> loginUser(String email, String password) async {
    final user = await _api.loginUser(email, password);

    if (user == null) return null;

    await _prefs.setString("user", user.toJson());
    return user;
  }

  Future<bool> validateUser() async {
    try {
      final u = _prefs.getString("user");

      if (u == null) return false;

      return await _api.validateToken(LoginUser.fromJson(u));
    } catch (e) {
      return false;
    }
  }

  Future<bool> isProfileUpdated() async {
    try {
      final u = _prefs.getString("user");

      if (u == null) return false;

      return await _api.isProfileUpdated(LoginUser.fromJson(u));
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(Student student) async {
    try {
      final u = _prefs.getString("user");
      if (u == null) return false;

      return await _api.updateUser(LoginUser.fromJson(u), student.toMap());
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserFields(Map<String, dynamic> data) async {
    try {
      final u = _prefs.getString("user");
      if (u == null) return false;

      return await _api.updateUser(LoginUser.fromJson(u), data);
    } catch (e) {
      return false;
    }
  }

  Future<String?> uploadImage(String filePath) async {
    try {
      final u = _prefs.getString("user");
      if (u == null) return null;

      return await _api.uploadImage(LoginUser.fromJson(u), filePath);
    } catch (e) {
      return null;
    }
  }

  Future<Student?> getStudent() async {
    final u = _prefs.getString("user");
    if (u == null) return null;

    return await _api.getStudent(LoginUser.fromJson(u));
  }

  Future<bool> forgetPassword(String email) async {
    return await _api.forgetPassword(email);
  }

  Future<bool> changePassword(LoginUser user, String newPass, String oldPass) async {
    try {
      final u = _prefs.getString("user");
      if (u == null) return false;

      return await _api.changePassword(user, newPass, oldPass);
    } catch (e) {
      return false;
    }
  }

  Future<void> logout() async {
    await _prefs.remove("user");
  }
}
