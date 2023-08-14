import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_database/utils/constants/constants.dart';
import 'features/details/bloc/details_bloc.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/studentlist/bloc/students_bloc.dart';
import 'firebase_options.dart';
import 'utils/constants/routing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // bool isLoggedIn = await checkIfUserIsLoggedIn();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => StudentsBloc(),
        ),
        BlocProvider(
          create: (context) => DetailsBloc(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  build(BuildContext context) {
    AppRouter singleton = AppRouter.instance;
    var router = singleton.router;
    return SafeArea(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: Constants.appTheme,
        routerConfig: router,
      ),
    );
  }
}
