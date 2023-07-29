import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/student_database.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(onHomeInitialEvent);

    on<StudentButtonNavigateEvent>(studentButtonNavigateEvent);

    on<StudentButtonClearEvent>(studentButtonClearEvent);
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

  FutureOr<void> studentButtonNavigateEvent(
      StudentButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(NavigateToStudentsDetailsPageActionState());
  }

  FutureOr<void> studentButtonClearEvent(
      StudentButtonClearEvent event, Emitter<HomeState> emit) async {
    await StudentDatabase.clearDb();
    final dataList = await StudentDatabase.getAllStudents();
    emit(HomeLoadedState(students: dataList));
  }
}
