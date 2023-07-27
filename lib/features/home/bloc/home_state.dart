part of 'home_bloc.dart';

class HomeState {}

class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Map<String, dynamic>> students;

  HomeLoadedState({required this.students});
}

class HomeErrorState extends HomeState {}

class StudentAddedState extends HomeState {}

class NavigateToStudentsDetailsPageActionState extends HomeActionState {}

class NavigateToStudentsEditPageActionState extends HomeActionState {}
