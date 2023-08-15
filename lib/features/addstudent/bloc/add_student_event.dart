part of 'add_student_bloc.dart';

class AddStudentEvent {}

class AddinitialEvent extends AddStudentEvent {}

class AddClickedEvent extends AddStudentEvent {
  String division;
  String bloodgrp;
  String address;
  String number;
  int age;
  String name;
  String latitude;
  String longitude;
  // ignore: prefer_typing_uninitialized_variables
  var image;

  AddClickedEvent({
    required this.name,
    required this.age,
    required this.number,
    required this.address,
    required this.bloodgrp,
    required this.division,
    required this.image,
    required this.latitude,
    required this.longitude,
  });
}

class AddedEvent extends AddStudentEvent {}
