import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AcademicDetailModel {
  String studentId;
  String institute;
  String dept;

  int? passingYrCurrent;

  int passingYr10;
  double percentage10;
  String board10;

  int? passingYr12;
  double? percentage12;
  String? board12;

  int? passingYrDiploma;
  double? percentageDiploma;
  double? cgpaDiploma;
  String? collegeDiploma;

  Map<String, String> semPercentage;

  List<String> skills = [];
  List<String> interestedRoles = [];
  String resumeUrl;
  AcademicDetailModel({
    required this.studentId,
    required this.institute,
    required this.dept,
    this.passingYrCurrent,
    required this.passingYr10,
    required this.percentage10,
    required this.board10,
    this.passingYr12,
    this.percentage12,
    this.board12,
    this.passingYrDiploma,
    this.percentageDiploma,
    this.cgpaDiploma,
    this.collegeDiploma,
    required this.semPercentage,
    required this.skills,
    required this.interestedRoles,
    required this.resumeUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studentId': studentId,
      'institute': institute,
      'dept': dept,
      'passingYrCurrent': passingYrCurrent,
      'passingYr10': passingYr10,
      'percentage10': percentage10,
      'board10': board10,
      'passingYr12': passingYr12,
      'percentage12': percentage12,
      'board12': board12,
      'passingYrDiploma': passingYrDiploma,
      'percentageDiploma': percentageDiploma,
      'cgpaDiploma': cgpaDiploma,
      'collegeDiploma': collegeDiploma,
      // 'semPercentage': semPercentage,
      'skills': skills,
      'interestedRoles': interestedRoles,
      'resumeUrl': resumeUrl,
    }..addAll(semPercentage.map((key, value) => MapEntry("${key}Percentage", value)));
  }

  factory AcademicDetailModel.fromMap(Map<String, dynamic> map) {
    return AcademicDetailModel(
      studentId: map['studentId'] as String,
      institute: map['institute'] as String,
      dept: map['dept'] as String,
      passingYrCurrent:
          map['passingYrCurrent'] != null ? map['passingYrCurrent'] as int : 0,
      passingYr10: map['passingYr10'] ?? 0,
      percentage10: (map['percentage10'] as int?)?.toDouble() ?? 0.0,
      board10: map['board10'] as String,
      passingYr12: map['passingYr12'] != null ? map['passingYr12'] as int : null,
      percentage12:
          map['percentage12'] != null ? (map['percentage12'] as int?)?.toDouble() : null,
      board12: map['board12'] != null ? map['board12'] as String : null,
      passingYrDiploma:
          map['passingYrDiploma'] != null ? map['passingYrDiploma'] as int : null,
      percentageDiploma: map['percentageDiploma'] != null
          ? (map['percentageDiploma'] as int?)?.toDouble()
          : null,
      cgpaDiploma:
          map['cgpaDiploma'] != null ? (map['cgpaDiploma'] as int?)?.toDouble() : null,
      collegeDiploma:
          map['collegeDiploma'] != null ? map['collegeDiploma'] as String : null,
      semPercentage: Map<String, String>.fromEntries(map.entries
          .where((e) =>
              (e.value.runtimeType == String) &&
              e.key.startsWith("sem") &&
              e.key.endsWith("Percentage"))
          .map((e) => MapEntry(e.key, e.value as String))),
      skills: List<String>.from((map['skills'] as List)),
      interestedRoles: List<String>.from((map['interestedRoles'] as List)),
      resumeUrl: map['resumeUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AcademicDetailModel.fromJson(String source) =>
      AcademicDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory AcademicDetailModel.empty() => AcademicDetailModel(
        studentId: "",
        institute: "",
        dept: "",
        passingYr10: 0,
        percentage10: 0.0,
        board10: "",
        semPercentage: {},
        skills: [],
        interestedRoles: [],
        resumeUrl: "",
      );
}
