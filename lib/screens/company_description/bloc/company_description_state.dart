// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'company_description_bloc.dart';

sealed class CompanyDescriptionState {
  CompanyModel? company;
  Map<String, dynamic>? pendingKeys;
  CompanyDescriptionState({this.company, this.pendingKeys});
}

class CompanyDescInitialState extends CompanyDescriptionState {
  CompanyDescInitialState({super.company});
}

class CompanyDescAppliedSuccessfulState extends CompanyDescriptionState {
  CompanyDescAppliedSuccessfulState({
    required super.company,
  });
}

class CompanyDescPendingKeysState extends CompanyDescriptionState {
  CompanyDescPendingKeysState({
    required super.company,
    required super.pendingKeys,
  });
}

class CompanyDescAppliedFailedState extends CompanyDescriptionState {
  CompanyDescAppliedFailedState({required super.company});
}

class CompanyDescLoadingState extends CompanyDescriptionState {
  CompanyDescLoadingState({super.company});
}

class CompanyDescAlreadyApplyState extends CompanyDescriptionState {
  CompanyDescAlreadyApplyState({super.company});
}
