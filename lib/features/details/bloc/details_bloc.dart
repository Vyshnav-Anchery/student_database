import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_database/utils/constants/constants.dart';

import '../../../data/student_database.dart';
import '../../studentlist/bloc/students_bloc.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final StudentsBloc studentsBloc = StudentsBloc();
  DetailsBloc() : super(DetailsInitial()) {
    on<DetailsInitialEvent>(detailsInitialEvent);
    on<UpdateStudentEvent>(updateStudentEvent);
    on<EditClickedEvent>(editClickedEvent);
  }

  FutureOr<void> detailsInitialEvent(
      DetailsInitialEvent event, Emitter<DetailsState> emit) async {
    emit(DetailsLoadingState());
    try {
      final dataList = await StudentDatabase.getAllStudents();
      emit(DetailsLoadedState(students: dataList));
    } catch (e) {
      emit(DetailsErrorState());
    }
  }

  FutureOr<void> updateStudentEvent(
      UpdateStudentEvent event, Emitter<DetailsState> emit) async {
    try {
      final Map<String, dynamic> data = {
        Constants.nameString: event.name,
        Constants.ageString: event.age,
        Constants.contactString: event.number,
        Constants.bloodString: event.bloodgrp,
        Constants.addressString: event.address,
        Constants.divisionString: event.division,
        Constants.imageString: event.image,
      };
      await StudentDatabase.updateData(event.index, data);
      emit(DetailsUpdatedState());
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> editClickedEvent(
      EditClickedEvent event, Emitter<DetailsState> emit) {
    emit(EditEnabledState());
  }
}
