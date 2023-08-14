import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:student_database/utils/constants/constants.dart';

import '../bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginBloc loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
      bloc: loginBloc,
      // listenWhen: (previous, current) => current is LoginActionState,
      // buildWhen: (previous, current) => current is! LoginActionState,
      listener: (context, state) {
        if (state is LoginSuccessfullActionState) {
          GoRouter.of(context).pushNamed(RoutingConstants.homeRouteName);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/login.png"),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 70),
              child: ElevatedButton(
                onPressed: () => loginBloc.add(LoginGoogleClickedEvent()),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Constants.googleIcon,
                    const SizedBox(width: 10),
                    const Text("Sign In with Google",style: TextStyle(color: Colors.black,fontSize: 17),)
                  ],
                ),
              ),
            )
          ],
        );
      },
    ));
  }
}
