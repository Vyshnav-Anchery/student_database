import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
                .showSnackBar(const SnackBar(content: Text('Student Added')));
          }
        },
        bloc: addBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text("Add Students")),
            body: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 50, left: 30, right: 30),
                child: Column(
                  children: [
                    Text("Enter details",
                        style: GoogleFonts.secularOne(
                            textStyle: const TextStyle(fontSize: 30))),
                    CustomFormWidget(bloc: addBloc,option: true,enabled: true),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
