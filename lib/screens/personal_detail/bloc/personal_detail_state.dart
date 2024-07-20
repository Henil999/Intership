// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'personal_detail_bloc.dart';

class PersonalDetailState {
  Student? student;
  PersonalDetailState({this.student});

  PersonalDetailState copyWith({Student? student}) {
    return PersonalDetailState(
      student: student ?? this.student,
    );
  }
}

final class PersonalDetailInitialState extends PersonalDetailState {
  PersonalDetailInitialState({super.student});
}

final class PersonalDetailSucessState extends PersonalDetailState {
  PersonalDetailSucessState({super.student});
}

final class PersonalDetailErrorState extends PersonalDetailState {
  final String msg;

  PersonalDetailErrorState(this.msg, {super.student});
}

final class PersonalDetailPfPChangedState extends PersonalDetailState {
  final String imgPath;

  PersonalDetailPfPChangedState(this.imgPath, {super.student});
}
