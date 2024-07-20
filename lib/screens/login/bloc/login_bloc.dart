// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:placement_app/data/repository/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepo _userRepo;

  LoginBloc(this._userRepo) : super(LoginInitalState()) {
    on<LoginInitalEvent>(_onInitial);
    on<LoginForgetPasswordEvent>(_onForget);
    on<LoginSubmitEvent>(_onSubmit);
  }

  void _onInitial(LoginInitalEvent event, Emitter<LoginState> emit) async {
    // (await SharedPreferences.getInstance()).clear();
    // final vRes = await _userRepo.validateUser();
    // if (vRes) emit(LoginSuccessState());
  }

  void _onSubmit(LoginSubmitEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    final user = await _userRepo.loginUser(event.username, event.password);

    if (user == null) {
      emit(LoginFailedState("Invalid credentials"));
      return;
    }

    emit(LoginSuccessState());
  }

  void _onForget(LoginForgetPasswordEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    final res = await _userRepo.forgetPassword(event.email);
    emit(LoginMsgState(
        res ? "Password reset link sent to your email" : "Error sending reset link"));
  }
}
