// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeUpdateEvent extends HomeEvent {}

class HomeBookmarkCompanyEvent extends HomeEvent {
  final int companyIndex;
  HomeBookmarkCompanyEvent({required this.companyIndex});
}
