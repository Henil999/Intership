import 'dart:ffi';

import 'package:placement_app/data/api/api.dart';
import 'package:placement_app/data/models/company.dart';
import 'package:placement_app/data/models/login_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyRepo {
  late API _api;
  late SharedPreferences _prefs;
  LoginUser? _loggedUser;

  LoginUser? get loggedUser => _loggedUser ??= _getUser();

  CompanyRepo(SharedPreferences prefs, {LoginUser? user}) {
    _api = API();
    _prefs = prefs;
    _loggedUser = user;
  }

  static Future<CompanyRepo> init() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    var user = p.getString("user");
    if (user != null) return CompanyRepo(p, user: LoginUser.fromJson(user));
    return CompanyRepo(p);
  }

  Future<List<CompanyModel>> getAllCompanies() async {
    if (loggedUser == null) return [];
    final res = await _api.getAllCompanies(loggedUser!);
    return res;
  }

  Future<CompanyModel?> getCompany(int companyRefId) async {
    if (loggedUser == null) return null;
    final res = await _api.getCompany(loggedUser!, companyRefId);
    return res;
  }

  Future<List<CompanyModel>> getAppliedCompanies() async {
    if (loggedUser == null) return [];
    final res = await _api.getAppliedCompanies(loggedUser!);
    return res;
  }

  Future<Map<String, dynamic>> applyCompany(int companyRefId) async {
    if (loggedUser == null) return {};
    final res = await _api.applyCompany(loggedUser!, companyRefId);
    return res;
  }

  Future<List<CompanyModel>> searchCompany(String query) async {
    if (loggedUser == null) return [];
    final res = await _api.searchCompanies(loggedUser!, query);
    return res;
  }

  LoginUser? _getUser() {
    final user = _prefs.getString("user");

    return user != null ? LoginUser.fromJson(user) : null;
  }
}
