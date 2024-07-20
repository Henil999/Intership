import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:placement_app/data/models/company.dart';
import 'package:placement_app/data/models/login_user.dart';
import 'package:dio/dio.dart';
import 'package:placement_app/data/models/user.dart';

class API {
  final baseUrl = "http://65.2.29.222:5000";
  // final baseUrl = "http://0.0.0.0:5000";
  // final baseUrl = "http://10.0.2.2:5000";
  late Dio dio;

  static final API _instance = API._internal();
  factory API() {
    return _instance;
  }

  API._internal() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      validateStatus: (i) => true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));
  }

  String getImageUrl(String path) => "$baseUrl/image?fileName=$path";

  Future<LoginUser?> loginUser(String email, String password) async {
    try {
      final res = await dio.post("/login",
          data: {"email": email, "password": password},
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));
      if (res.statusCode != 200) return null;

      return LoginUser(
          userId: res.data['userId'],
          email: res.data['email'],
          token: res.data['token'],
          role: res.data['role']);
    } catch (e) {
      debugPrint("Error Login: $e");
      return null;
    }
  }

  Future<bool> validateToken(LoginUser user) async {
    try {
      final res =
          await dio.post("/validate-token", data: user.toJson(), options: _options());

      if (res.statusCode != 200) return false;

      return true;
    } catch (e) {
      debugPrint("Error Validate: $e");
      return false;
    }
  }

  Future<bool> forgetPassword(String email) async {
    try {
      final res = await dio.post("/forgot-password", data: {"email": email});

      if (res.statusCode != 200) return false;

      return true;
    } catch (e) {
      debugPrint("Error ForgetPass: $e");
      return false;
    }
  }

  Future<bool> changePassword(LoginUser user, String newPass, String oldPass) async {
    try {
      final res = await dio.post("/change-password",
          data: {"oldPassword": oldPass, "newPassword": newPass},
          options: _options(user: user));

      if (res.statusCode != 200) return false;

      return true;
    } catch (e) {
      debugPrint("Error ForgetPass: $e");
      return false;
    }
  }

  Future<bool> getAllUsers(LoginUser user) async {
    try {
      final res = await dio.get("/get-all-users",
          queryParameters: {"q": "all"}, options: _options(user: user));

      if (res.statusCode != 200) return false;

      return true;
    } catch (e) {
      debugPrint("Error ForgetPass: $e");
      return false;
    }
  }

  Future<List<CompanyModel>> searchCompanies(LoginUser user, String query) async {
    try {
      final res = await dio.get("/get-all-companies",
          queryParameters: {"q": query}, options: _options(user: user));

      if (res.statusCode != 200) return [];

      return res.data.map<CompanyModel>((e) => CompanyModel.fromMap(e)).toList();
    } catch (e) {
      debugPrint("Error Search Companies: $e");
      return [];
    }
  }

  Future<List<CompanyModel>> getAllCompanies(LoginUser user) async {
    try {
      final res = await dio.get("/get-all-companies", options: _options(user: user));

      if (res.statusCode != 200) return [];
      return res.data['companies']
          .map<CompanyModel>((e) => CompanyModel.fromMap(e))
          .toList();
    } catch (e) {
      debugPrint("Error Get All Companies: $e");
      return [];
    }
  }

  Future<CompanyModel?> getCompany(LoginUser user, int companyRefId) async {
    try {
      final res = await dio.get("/company-profile",
          options: _options(user: user), queryParameters: {"refId": companyRefId});

      if (res.statusCode != 200) return null;

      return CompanyModel.fromMap(res.data['company']);
    } catch (e) {
      debugPrint("Error Get Companies: $e");
      return null;
    }
  }

  Future<List<CompanyModel>> getAppliedCompanies(LoginUser user) async {
    try {
      final res = await dio.get("/applied-companies", options: _options(user: user));

      if (res.statusCode != 200) return [];

      List<int> ids =
          res.data['appliedCompanies'].map<int>((e) => e['companyRefId'] as int).toList();

      var r = await Future.wait(ids.map((e) => getCompany(user, e)));
      return r.where((element) => element != null).toList().map((e) => e!).toList();
    } catch (e) {
      debugPrint("Error Get All Companies: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> applyCompany(LoginUser user, int companyRefId) async {
    try {
      final res = await dio.post("/apply",
          data: {"refId": companyRefId}, options: _options(user: user));

      debugPrint("Applied Company: ${res.data}");

      print(res.statusCode);
      if (res.statusCode == 422) {
        return res.data;
      }
      if (res.statusCode == 200) {
        return res.data;
      }
      if (res.statusCode == 400) {
        return res.data;
      } else {
        return {};
      }
    } catch (e) {
      debugPrint("Error Apply Company: $e");
      return {};
    }
  }

  Future<String?> uploadImage(LoginUser user, String filePath) async {
    try {
      FormData formData = FormData.fromMap({
        "profile": await MultipartFile.fromFile(filePath,
            filename: filePath.split('/').last,
            // filename: fileName,
            contentType: MediaType("image", filePath.split(".").last)),
      });

      final res = await dio.post("/profile-picture",
          data: formData, options: _options(user: user));

      if (res.statusCode != 200) return null;
      return res.data['prifilePicture'];
    } catch (e) {
      debugPrint("Error Upload Image: $e");
      return null;
    }
  }

  Future<bool> updateUser(LoginUser user, Map<String, dynamic> userData) async {
    try {
      userData['profileUpdated'] = true;
      final res = await dio.post("/update-user",
          data: {"updateFields": userData}, options: _options(user: user));
      if (res.statusCode != 200) return false;
      return true;
    } catch (e) {
      debugPrint("Error Update User Profile: $e");
      return false;
    }
  }

  Future<bool> isProfileUpdated(LoginUser user) async {
    try {
      final res = await dio.get("/get-user",
          data: {'userId': user.userId}, options: _options(user: user));
      if (res.statusCode != 200) return false;

      return res.data['userDetail']['profileUpdated'] ?? false;
    } catch (e) {
      debugPrint("Error Profile updated: $e");
      return false;
    }
  }

  Future<Student?> getStudent(LoginUser user) async {
    try {
      final res = await dio.get("/get-user",
          data: {'userId': user.userId}, options: _options(user: user));
      if (res.statusCode != 200) return null;

      return Student.fromMap(res.data['userDetail']);
    } catch (e) {
      debugPrint("Error Get Student: $e");
      return null;
    }
  }

  Options _options({LoginUser? user}) => Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        if (user != null) "token": user.token,
        if (user != null) "email": user.email,
      });
}
