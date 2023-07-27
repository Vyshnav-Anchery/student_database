// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:async';
// import '../../../data/student_database.dart';

// import '../../../data/student_database.dart';

// part 'home_event.dart';
// part 'home_state.dart';

// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   HomeBloc() : super(HomeInitial()) {
//     on<HomeInitialEvent>(_onHomeInitialEvent);
//     on<AddClickedEvent>(_onAddClickedEvent);
//   }

//   Future<void> _onHomeInitialEvent(
//     HomeInitialEvent event,
//     Emitter<HomeState> emit,
//   ) async {
//     try {
//       final dataList = await StudentDatabase.getAllStudents();
//       emit(HomeLoadedSuccessState(dataList: dataList));
//     } catch (e) {
//       emit(HomeErrorState());
//     }
//   }

//   Future<void> _onAddClickedEvent(
//     AddClickedEvent event,
//     Emitter<HomeState> emit,
//   ) async {
//     try {
//       String name = event.nameEditingController.text;
//       int age = int.parse(event.ageEditingController.text);
//       String bloodgroup = event.bloodEditingController.text;
//       int contact = int.parse(event.numberEditingController.text);
//       String division = event.stdEditingController.text;
//       String address = event.addressEditingController.text;

//       await StudentDatabase.insertStudent(
//         name: name,
//         age: age,
//         bloodgroup: bloodgroup,
//         contact: contact,
//         division: division,
//         address: address,
//       );

//       // Re-fetch data after inserting a new student
//       final dataList = await StudentDatabase.getAllStudents();
//       emit(HomeLoadedSuccessState(dataList: dataList));
//     } catch (e) {
//       emit(HomeErrorState());
//     }
//   }
// }

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/student_database.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(onHomeInitialEvent);
    on<AddClickedEvent>(onAddClickedEvent);
    on<StudentButtonNavigateEvent>(studentButtonNavigateEvent);
  }

  Future<void> onHomeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      final dataList = await StudentDatabase.getAllStudents();
      emit(HomeLoadedState(students: dataList));
    } catch (e) {
      emit(HomeErrorState());
    }
  }

  Future<void> onAddClickedEvent(
    AddClickedEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      String name = event.name;
      int age = event.age;
      String bloodgroup = event.bloodgrp;
      int contact = event.number;
      String division = event.division;
      String address = event.address;

      await StudentDatabase.insertStudent(
        name: name,
        age: age,
        bloodgroup: bloodgroup,
        contact: contact,
        division: division,
        address: address,
      );

      // Re-fetch data after inserting a new student
      final dataList = await StudentDatabase.getAllStudents();
      emit(HomeLoadedState(students: dataList));
    } catch (e) {
      emit(HomeErrorState());
    }
  }

  FutureOr<void> studentButtonNavigateEvent(
      StudentButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(NavigateToStudentsDetailsPageActionState());
  }
}
