part of 'profile_bloc.dart';

sealed class ProfileEvent {}

class ProfileInitialEvent extends ProfileEvent {}

class ProfileChangePasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;

  ProfileChangePasswordEvent({required this.oldPassword, required this.newPassword});
}
