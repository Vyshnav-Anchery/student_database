import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/student_database.dart';

part 'add_student_event.dart';
part 'add_student_state.dart';

class AddStudentBloc extends Bloc<AddStudentEvent, AddStudentState> {
  AddStudentBloc() : super(AddStudentInitial()) {
    on<AddClickedEvent>(onAddClickedEvent);
  }
  

  FutureOr<void> onAddClickedEvent(AddClickedEvent event, Emitter<AddStudentState> emit) async{
    try {
      String name = event.name;
      int age = event.age;
      String bloodgroup = event.bloodgrp;
      int contact = event.number;
      String division = event.division;
      String address = event.address;
      var image = event.image;

      await StudentDatabase.insertStudent(
          name: name,
          age: age,
          bloodgroup: bloodgroup,
          contact: contact,
          division: division,
          address: address,
          imageBytes: image);

      // Re-fetch data after inserting a new student
      final dataList = await StudentDatabase.getAllStudents();
      emit(AddStudentAddedState());
    } catch (e) {
      emit(AddStudentErrorState());
    }
  }
}