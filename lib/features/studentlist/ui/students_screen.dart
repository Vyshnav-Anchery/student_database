import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_database/features/addstudent/ui/add_screen.dart';

import '../bloc/students_bloc.dart';

class StudentsPage extends StatefulWidget {
  StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  void initState() {
    studentsBloc.add(StudentsInitialEvent());

    super.initState();
  }

  final StudentsBloc studentsBloc = StudentsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: studentsBloc,
      listenWhen: (previous, current) => current is StudentsActionState,
      buildWhen: (previous, current) => current is! StudentsActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case NavigateToStudentsDetailsPageActionState:
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddStudent(),
                ));
            break;
          default:
        }
      },
      builder: (context, state) {
        if (state is StudentsLoadingState) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is StudentsLoadedState) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Studentdb"),
                actions: [
                  IconButton(
                      onPressed: () {
                        studentsBloc.add(StudentButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.details)),
                  IconButton(
                      onPressed: () {
                        studentsBloc.add(StudentButtonClearEvent());
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
              body: ListView.builder(
                itemCount: state.students.length,
                itemBuilder: (context, index) {
                  var db = state.students;
                  var img = db[index]['image'];
                  final imageWidget = img != null
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(img),
                        )
                      : Icon(Icons.person_sharp); // Placeholder for no image

                  return ListTile(
                    leading: imageWidget,
                    title: Text("${db[index]['name']}"),
                    subtitle: Text("${db[index]['address']}"),
                    trailing: Text("${db[index]['bloodgroup']}"),
                  );
                },
              ));
        } else
          return SizedBox();
      },
    );
  }
}
