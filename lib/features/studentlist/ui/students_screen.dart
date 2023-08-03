import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_database/utils/constants/constants.dart';

import '../../details/ui/details.dart';
import '../bloc/students_bloc.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

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
        if (state is NavigateToStudentsDetailsPageActionState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentDetails(index: state.index),
              ));
        }
      },
      builder: (context, state) {
        if (state is StudentsLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is StudentsLoadedState) {
          return Scaffold(
              appBar: AppBar(
                title: Constants.studentListTitle,
                actions: [
                  IconButton(
                      onPressed: () {
                        studentsBloc.add(StudentButtonClearEvent());
                      },
                      icon: Constants.deleteIcon)
                ],
              ),
              body: ListView.builder(
                itemCount: state.students.length,
                itemBuilder: (context, index) {
                  var db = state.students;
                  var img = db[index][Constants.imageString];
                  final imageWidget = img != null
                      ? CircleAvatar(
                          backgroundImage: MemoryImage(img),
                        )
                      : const Icon(Icons.person_sharp);
                  return Padding(
                    padding: Constants.paddingStudentsScreen,
                    child: ListTile(
                      onTap: () => studentsBloc
                          .add(StudentButtonNavigateEvent(index: index)),
                      tileColor: Constants.tiileColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      leading:
                          Hero(tag: Constants.imageHeroTag, child: imageWidget),
                      title: Text("${db[index][Constants.nameString]}"),
                      subtitle: Text("${db[index][Constants.divisionString]}"),
                      trailing: const Icon(Icons.chevron_right_rounded),
                    ),
                  );
                },
              ));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
