part of 'home_bloc.dart';

class HomeState {
  Student? user;
  List<CompanyModel> companies = [];
  List<CompanyModel> bookmarkedCompanies = [];
  String? state;

  HomeState({
    this.user,
    List<CompanyModel>? companies,
    List<CompanyModel>? bookmarkedCompanies,
    this.state,
  }) {
    this.companies = companies ?? [];
    this.bookmarkedCompanies = bookmarkedCompanies ?? [];
  }

  HomeState copyWith(
      {Student? user,
      List<CompanyModel>? companies,
      List<CompanyModel>? bookmarkedCompanies,
      String? state}) {
    return HomeState(
        user: user ?? this.user,
        companies: companies ?? this.companies,
        bookmarkedCompanies: bookmarkedCompanies ?? this.bookmarkedCompanies,
        state: state ?? this.state);
  }
}
