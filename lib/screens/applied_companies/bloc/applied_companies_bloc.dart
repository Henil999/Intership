import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:placement_app/data/models/company.dart';
import 'package:placement_app/data/models/user.dart';
import 'package:placement_app/data/repository/company_repo.dart';
import 'package:placement_app/data/repository/user_repo.dart';
part 'applied_companies_event.dart';
part 'applied_companies_state.dart';

class AppliedCompaniesBloc extends Bloc<AppliedCompaniesEvent, AppliedCompaniesState> {
  AppliedCompaniesBloc(this.companyRepo, this.userRepo) : super(AppliedCompaniesState()) {
    on<AppliedCompaniesInitailEvent>(_onInitial);
    on<AppliedCompaniesBookmarkCompanyEvent>(_onBookMarkCompany);
  }

  CompanyRepo companyRepo;
  UserRepo userRepo;

  void _onInitial(
      AppliedCompaniesInitailEvent event, Emitter<AppliedCompaniesState> emit) async {
    var userC = await userRepo.getUser();
    final appliedCompanies = await companyRepo.getAppliedCompanies();

    var user = Student.empty();
    if (userC != null) {
      user.firstName = userC.email;
    }

    emit(state.copyWith(appliedCompanies: appliedCompanies, user: user));
  }

  void _onBookMarkCompany(
      AppliedCompaniesBookmarkCompanyEvent event, Emitter<AppliedCompaniesState> emit) {}
}
