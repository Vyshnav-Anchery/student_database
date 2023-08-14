import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_database/utils/constants/constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter.of(context);

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            Future.delayed(
                Duration.zero, () => router.go(RoutingConstants.homeRoutePath));
            return const SizedBox();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something Went Wrong!!!"),
            );
          } else {
            Future.delayed(Duration.zero,
                () => router.go(RoutingConstants.loginRoutePath));
            return const SizedBox();
          }
        },
      ),
    );
  }
}
