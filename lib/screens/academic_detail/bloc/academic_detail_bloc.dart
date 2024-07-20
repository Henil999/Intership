import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'academic_detail_event.dart';
part 'academic_detail_state.dart';

class AcademicDetailBloc extends Bloc<AcademicDetailEvent, AcademicDetailState> {
  AcademicDetailBloc() : super(AcademicDetailInitial()) {
    on<AcademicDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
