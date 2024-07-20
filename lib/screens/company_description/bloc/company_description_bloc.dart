import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:placement_app/data/models/company.dart';
import 'package:placement_app/data/repository/company_repo.dart';
import 'package:placement_app/data/repository/user_repo.dart';

part 'company_description_event.dart';
part 'company_description_state.dart';

class CompanyDescriptionBloc
    extends Bloc<CompanyDescriptionEvent, CompanyDescriptionState> {
  CompanyDescriptionBloc(this.userRepo, this.companyRepo)
      : super(CompanyDescInitialState()) {
    on<CompanyDescriptionInitialEvent>(_onInitial);
    on<CompanyDescriptionApplyEvent>(_onApply);
    on<CompanyDescriptionApplyWithKeysEvent>(_onApplyWithPendingKeys);
    on<CompanyDescriptionBookmarkEvent>(_onBookmark);
  }

  final UserRepo userRepo;
  final CompanyRepo companyRepo;
  CompanyModel? _company;

  void _onInitial(
      CompanyDescriptionInitialEvent event, Emitter<CompanyDescriptionState> emit) async {
    emit(CompanyDescLoadingState());
    await Future.delayed(const Duration(milliseconds: 500));

    _company = event.company;
    emit(CompanyDescInitialState(company: event.company));
    // emit(CompanyDescInitialState(
    //   company: CompanyModel(
    //     name: "Microsoft",
    //     position: "UX Designer",
    //     location: "Banglore",
    //     isRemote: false,
    //     employmentType: EmploymentType.fullTime,
    //     packageMinLPA: 6,
    //     packageMaxLPA: 8,
    //     companyImg:
    //         "https://w7.pngwing.com/pngs/817/886/png-transparent-microsoft-logo-icon-microsoft-icon-angle-text-rectangle.png",
    //   ),
    // ));
  }

  void _onApply(
      CompanyDescriptionApplyEvent event, Emitter<CompanyDescriptionState> emit) async {
    debugPrint("Applied to ${_company?.refId} ${_company?.name}");
    if ((_company?.refId) == null) return;
    var r = await companyRepo.applyCompany(_company!.refId);

    if (r["message"] == "Application updated" || r["message"] == "Application sent") {
      emit(CompanyDescAppliedSuccessfulState(company: _company));
    } else if (r["message"] == "Pending keys") {
      emit(CompanyDescPendingKeysState(company: _company, pendingKeys: r));
    } else if (r['message'] == 'You have already applied for this company') {
      emit(CompanyDescAlreadyApplyState(company: _company));
    }
  }

  void _onApplyWithPendingKeys(CompanyDescriptionApplyWithKeysEvent event,
      Emitter<CompanyDescriptionState> emit) async {
    debugPrint("EVENT: ${event.formKeyData}");

    var ees = await userRepo.updateUserFields(event.formKeyData);
    if (ees && (_company?.refId) != null) {
      var r = await companyRepo.applyCompany(_company!.refId);
      if (r["message"] == "Application updated" || r["message"] == "Application sent") {
        emit(CompanyDescAppliedSuccessfulState(company: _company));
        return;
      }
    }
    emit(CompanyDescAppliedFailedState(company: _company));
  }

  void _onBookmark(
      CompanyDescriptionBookmarkEvent event, Emitter<CompanyDescriptionState> emit) {}
}
