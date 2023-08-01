import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeNavigateToAddEvent>(homeNavigateToAddEvent);
  }

  FutureOr<void> homeNavigateToAddEvent(
      HomeNavigateToAddEvent event, Emitter<HomeState> emit) {
    try {
      emit(HomeNavigateToAddingPageActionState());
    } catch (e) {
      print(e);
    }
  }
}
