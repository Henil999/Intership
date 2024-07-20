part of 'applied_companies_bloc.dart';

class AppliedCompaniesState {
  Student? user;
  List<CompanyModel> appliedCompanies = [];
  List<CompanyModel> bookmarkedCompanies = [];

  AppliedCompaniesState({
    this.user,
    List<CompanyModel>? appliedCompanies,
    List<CompanyModel>? bookmarkedCompanies,
  }) {
    this.appliedCompanies = appliedCompanies ?? [];
    this.bookmarkedCompanies = bookmarkedCompanies ?? [];
  }

  AppliedCompaniesState copyWith({
    Student? user,
    List<CompanyModel>? appliedCompanies,
    List<CompanyModel>? bookmarkedCompanies,
  }) {
    return AppliedCompaniesState(
      user: user ?? this.user,
      appliedCompanies: appliedCompanies ?? this.appliedCompanies,
      bookmarkedCompanies: bookmarkedCompanies ?? this.bookmarkedCompanies,
    );
  }
}
