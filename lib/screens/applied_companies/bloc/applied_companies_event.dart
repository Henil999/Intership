part of 'applied_companies_bloc.dart';

sealed class AppliedCompaniesEvent {}

class AppliedCompaniesInitailEvent extends AppliedCompaniesEvent {}

class AppliedCompaniesBookmarkCompanyEvent extends AppliedCompaniesEvent {
  final int companyId;
  AppliedCompaniesBookmarkCompanyEvent(this.companyId);
}
