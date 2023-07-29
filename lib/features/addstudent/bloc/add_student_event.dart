part of 'add_student_bloc.dart';

class AddStudentEvent {}

class AddinitialEvent extends AddStudentEvent {}

class AddClickedEvent extends AddStudentEvent {
  String division;
  String bloodgrp;
  String address;
  int number;
  int age;
  String name;

  var image;

  AddClickedEvent(
      {required this.name,
      required this.age,
      required this.number,
      required this.address,
      required this.bloodgrp,
      required this.division,
      required this.image});
}

class AddedEvent extends AddStudentEvent {}