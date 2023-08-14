import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/google_sign_in/google_sign_in.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginGoogleClickedEvent>(loginGoogleClickedEvent);
  }

  FutureOr<void> loginGoogleClickedEvent(
      LoginGoogleClickedEvent event, Emitter<LoginState> emit) async {
    await signInWithGoogle().whenComplete(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      emit(LoginSuccessfullActionState());
    });
  }
}
