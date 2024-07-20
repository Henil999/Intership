// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'company_description_bloc.dart';

sealed class CompanyDescriptionEvent {}

class CompanyDescriptionInitialEvent extends CompanyDescriptionEvent {
  CompanyModel company;
  CompanyDescriptionInitialEvent({required this.company});
}

class CompanyDescriptionApplyEvent extends CompanyDescriptionEvent {}

class CompanyDescriptionApplyWithKeysEvent extends CompanyDescriptionEvent {
  Map<String, dynamic> formKeyData;
  CompanyDescriptionApplyWithKeysEvent(this.formKeyData);
}

class CompanyDescriptionBookmarkEvent extends CompanyDescriptionEvent {}
