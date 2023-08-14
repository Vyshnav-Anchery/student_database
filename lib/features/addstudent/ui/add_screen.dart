import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_database/utils/constants/constants.dart';
import 'package:student_database/utils/widgets/drawer.dart';
import 'package:student_database/utils/widgets/form.dart';

import '../bloc/add_student_bloc.dart';

class AddStudentPage extends StatelessWidget {
  AddStudentPage({super.key});
  final AddStudentBloc addBloc = AddStudentBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        listenWhen: (previous, current) => current is AddStudentState,
        buildWhen: (previous, current) => current is! AddStudentState,
        listener: (context, state) {
          if (state is AddStudentAddedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(Constants.addstudentSnackbar);
          }
        },
        bloc: addBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Constants.addAppBarTitle),
            drawer: const DrawerWidget(),
            body: SingleChildScrollView(
              child: Container(
                margin: Constants.addStudentPadding,
                child: Column(
                  children: [
                    Constants.addFormTitle,
                    CustomFormWidget(
                      bloc: addBloc,
                      option: true,
                      enabled: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
