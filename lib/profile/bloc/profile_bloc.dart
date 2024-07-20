import 'package:bloc/bloc.dart';
import 'package:placement_app/data/models/user.dart';
import 'package:placement_app/data/repository/user_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.userRepo) : super(ProfileState()) {
    on<ProfileInitialEvent>(_onInitial);
  }

  UserRepo userRepo;

  void _onInitial(ProfileInitialEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(state: "Loading"));
    var s = await userRepo.getStudent();
    emit(state.copyWith(student: s, state: "Success"));
    emit(state.copyWith());
  }
}
