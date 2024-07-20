import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CompanyModel {
  int refId;
  String name;
  String description;
  DateTime lastApplyDate;
  DateTime visitDate;
  String? logoUrl;

  String pkgRange;
  String link;
  String city;
  Map<String, String> documents = {};
  EmploymentType employmentType = EmploymentType.fullTime;

  CompanyModel({
    required this.refId,
    required this.name,
    required this.description,
    required this.lastApplyDate,
    required this.visitDate,
    required this.link,
    this.logoUrl,
    required this.documents,
    required this.pkgRange,
    required this.city,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'refId': refId,
      'companyName': name,
      'description': description,
      'lastApplyDate': lastApplyDate.toIso8601String(),
      'visitDate': visitDate.toIso8601String(),
      'packageRange': pkgRange,
      'city': city,
      'logoUrl': logoUrl,
      'websiteLink': link,
      'documents': documents,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      refId: map['refId'] as int,
      name: map['companyName'] as String,
      description: map['description'] as String,
      lastApplyDate: DateTime.parse(map['lastApplyDate'] as String),
      visitDate: DateTime.parse(map['visitDate'] as String),
      logoUrl: map['logo'] != null ? map['logo'] as String : null,
      pkgRange: map['packageRange'] != null ? map['packageRange'] as String : "",
      city: map['city'] != null ? map['city'] as String : "",
      link: map['websiteLink'] != null ? map['websiteLink'] as String : "",
      documents: Map<String, String>.fromEntries(map.entries
          .where((e) => (e.value.runtimeType == String))
          .map((e) => MapEntry(e.key, e.value as String))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum EmploymentType {
  fullTime,
  partTime,
  internship,
}

String employmentTypeToString(EmploymentType employmentType) {
  switch (employmentType) {
    case EmploymentType.fullTime:
      return 'Full Time';
    case EmploymentType.partTime:
      return 'Part Time';
    case EmploymentType.internship:
      return 'Internship';
  }
}
