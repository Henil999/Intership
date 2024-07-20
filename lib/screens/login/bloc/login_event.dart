// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginInitalEvent extends LoginEvent {}

class LoginSubmitEvent extends LoginEvent {
  String username;
  String password;
  LoginSubmitEvent({
    required this.username,
    required this.password,
  });
}

class LoginForgetPasswordEvent extends LoginEvent {
  String email;
  LoginForgetPasswordEvent(this.email);
}
