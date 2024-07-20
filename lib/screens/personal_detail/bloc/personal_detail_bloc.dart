import 'package:bloc/bloc.dart';
import 'package:placement_app/data/models/user.dart';
import 'package:placement_app/data/repository/user_repo.dart';
import 'package:placement_app/screens/personal_detail/personal_detail_model.dart';

part 'personal_detail_event.dart';
part 'personal_detail_state.dart';

class PersonalDetailBloc extends Bloc<PersonalDetailEvent, PersonalDetailState> {
  PersonalDetailBloc(this.userRepo) : super(PersonalDetailInitialState()) {
    on<PersonalDetailInitalEvent>(_onInitial);
    on<PersonalDetailSubmitEvent>(_onSubmit);
    on<PersonalDetailChangePfpEvent>(_onPfpChange);
  }

  UserRepo userRepo;

  void _onInitial(
      PersonalDetailInitalEvent event, Emitter<PersonalDetailState> emit) async {
    var res = await userRepo.getStudent();
    if (res != null) {
      emit(PersonalDetailSucessState(student: res));
    } else {
      emit(PersonalDetailErrorState("Error fetching student details",
          student: state.student));
    }
  }

  void _onSubmit(PersonalDetailSubmitEvent event, Emitter<PersonalDetailState> emit) {
    emit(PersonalDetailSucessState(student: state.student));
  }

  void _onPfpChange(
      PersonalDetailChangePfpEvent event, Emitter<PersonalDetailState> emit) {
    emit(PersonalDetailPfPChangedState(event.imgPath, student: state.student));
  }
}
