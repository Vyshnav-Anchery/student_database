part of 'home_bloc.dart';

class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class ViewStudentButtonClickedEvent extends HomeEvent {}

class StudentButtonNavigateEvent extends HomeEvent {}

class EditStudentButtonClickedEvent extends HomeEvent {}

class AddClickedEvent extends HomeEvent {
  String division;
  String bloodgrp;
  String address;
  int number;
  int age;
  String name;

  AddClickedEvent({
    required this.name,
    required this.age,
    required this.number,
    required this.address,
    required this.bloodgrp,
    required this.division,
  });
}
