// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'personal_detail_bloc.dart';

sealed class PersonalDetailEvent {}

class PersonalDetailInitalEvent extends PersonalDetailEvent {}

class PersonalDetailSubmitEvent extends PersonalDetailEvent {
  PersonalDetailModel model;
  PersonalDetailSubmitEvent(this.model);
}

class PersonalDetailChangePfpEvent extends PersonalDetailEvent {
  String imgPath;
  PersonalDetailChangePfpEvent(this.imgPath);
}
