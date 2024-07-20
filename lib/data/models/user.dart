// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:placement_app/data/models/academic_detail_model.dart';

class Student {
  String firstName;
  String lastName;
  String email;
  DateTime? dob;
  String? address;
  String? city;
  String? state;
  int phoneNumber;
  int? postalCode;
  String? profilePicture;

  AcademicDetailModel academicDetailModel;

  Student({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.dob,
    this.address,
    this.city,
    this.state,
    required this.phoneNumber,
    this.postalCode,
    this.profilePicture,
    required this.academicDetailModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dob': dob?.toIso8601String(),
      'address': address,
      'city': city,
      'state': state,
      'phoneNumber': phoneNumber,
      'postalCode': postalCode,
      'profilePicture': profilePicture,
    }..addAll(academicDetailModel.toMap());
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      dob: map['dob'] != null ? DateTime.tryParse(map['dob']) : null,
      address: map['address'] != null ? map['address'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      phoneNumber: map['phoneNumber'] as int,
      postalCode: map['postalCode'] != null ? map['postalCode'] as int : null,
      profilePicture:
          map['profilePicture'] != null ? map['profilePicture'] as String : null,
      academicDetailModel: AcademicDetailModel.fromMap(map),
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Student.empty() => Student(
        firstName: "",
        lastName: "",
        phoneNumber: 0,
        email: "",
        academicDetailModel: AcademicDetailModel.empty(),
      );

  Student copyWith({
    String? firstName,
    String? lastName,
    String? email,
    DateTime? dob,
    String? address,
    String? city,
    String? state,
    int? phoneNumber,
    int? postalCode,
    String? profilePicture,
    AcademicDetailModel? academicDetailModel,
  }) {
    return Student(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      postalCode: postalCode ?? this.postalCode,
      profilePicture: profilePicture ?? this.profilePicture,
      academicDetailModel: academicDetailModel ?? this.academicDetailModel,
    );
  }
}
