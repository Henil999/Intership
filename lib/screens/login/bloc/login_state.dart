// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

sealed class LoginState {}

class LoginInitalState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginMsgState extends LoginState {
  String msg;
  LoginMsgState(this.msg);
}

class LoginFailedState extends LoginState {
  String msg;
  LoginFailedState(this.msg);
}
