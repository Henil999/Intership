// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

class ProfileState {
  Student? student;
  String? state;
  ProfileState({this.student, this.state});

  ProfileState copyWith({Student? student, String? state}) {
    return ProfileState(
      student: student ?? this.student,
      state: state ?? this.state,
    );
  }
}
