import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:student_database/features/home/bloc/home_bloc.dart';
import 'package:student_database/utils/constants/constants.dart';
import '../../../utils/widgets/drawer.dart';
import 'widgets/cardmenu.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeNavigateToAddingPageActionState) {
            GoRouter.of(context)
                .pushNamed(RoutingConstants.addstudentsRouteName);
          } else if (state is HomeNavigateToStudentListPageActionState) {
            GoRouter.of(context)
                .pushNamed(RoutingConstants.studentlistRouteName);
          }
        },
        builder: (context, state) {
          return Scaffold(
              drawer: DrawerWidget(),
              appBar: AppBar(title: Constants.homeTitleString),
              // drawer: const Drawer(),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CardWidget(
                        homeBloc: homeBloc,
                        path: Constants.addCardmenuImageLogo,
                        event: HomeNavigateToAddEvent(),
                        buttonText: Constants.addStudentString,
                      ),
                      CardWidget(
                        homeBloc: homeBloc,
                        event: HomeNavigateToStudentListEvent(),
                        path: Constants.viewCardmenuImageLogo,
                        buttonText: Constants.viewStudentString,
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
