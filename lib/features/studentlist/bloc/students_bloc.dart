import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/student_database.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  StudentsBloc() : super(StudentsInitial()) {
    on<StudentsInitialEvent>(onStudentsInitialEvent);

    on<StudentButtonNavigateEvent>(studentButtonNavigateEvent);

    on<StudentButtonClearEvent>(studentButtonClearEvent);
  }

  Future<void> onStudentsInitialEvent(
      StudentsInitialEvent event, Emitter<StudentsState> emit) async {
    emit(StudentsLoadingState());
    await Future.delayed(const Duration(seconds: 2));
    try {
      final dataList = await StudentDatabase.getAllStudents();
      emit(StudentsLoadedState(students: dataList));
    } catch (e) {
      emit(StudentsErrorState());
    }
  }

  FutureOr<void> studentButtonNavigateEvent(
      StudentButtonNavigateEvent event, Emitter<StudentsState> emit) {
    emit(NavigateToStudentsDetailsPageActionState());
  }

  FutureOr<void> studentButtonClearEvent(
      StudentButtonClearEvent event, Emitter<StudentsState> emit) async {
    await StudentDatabase.clearDb();
    final dataList = await StudentDatabase.getAllStudents();
    emit(StudentsLoadedState(students: dataList));
  }
}
