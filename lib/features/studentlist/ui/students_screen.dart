import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:student_database/utils/constants/constants.dart';
import 'package:student_database/utils/widgets/drawer.dart';
import '../bloc/students_bloc.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  void initState() {
    super.initState();
    studentsBloc.add(StudentsInitialEvent());
    // studentsBloc=BlocProvider.of<StudentsBloc>(context);
  }

  final StudentsBloc studentsBloc = StudentsBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: studentsBloc,
      listenWhen: (previous, current) => current is StudentsActionState,
      buildWhen: (previous, current) => current is! StudentsActionState,
      listener: (context, state) async {
        if (state is NavigateToStudentsDetailsPageActionState) {
          GoRouter.of(context).pushNamed(RoutingConstants.detailsRouteName,
              pathParameters: {
                'index': state.index.toString()
              }).whenComplete(() => studentsBloc.add(StudentsInitialEvent()));
        } else if (state is StudentDeletedActionState) {
          studentsBloc.add(StudentsInitialEvent());
          Navigator.pop(context,);
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
                    onPressed: () =>
                        studentsBloc.add(StudentButtonClearEvent()),
                    icon: Constants.deleteIcon,
                  )
                ],
              ),
              drawer: const DrawerWidget(),
              body: RefreshIndicator(
                onRefresh: () async => studentsBloc.add(StudentsInitialEvent()),
                child: ListView.builder(
                  itemCount: state.students.length,
                  itemBuilder: (context, index) {
                    List<Map<String, dynamic>> db = state.students;
                    var img = db[index][Constants.imageString];
                    final imageWidget = img != null
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(img),
                          )
                        : const Icon(Icons.person_sharp);
                    return Slidable(
                      endActionPane:
                          ActionPane(motion: const StretchMotion(), children: [
                        SlidableAction(
                          icon: Icons.delete,
                          onPressed: (context) {
                            studentsBloc.add(DeleteClickedEvent(
                                index: db[index][Constants.idString]));
                          },
                        ),
                      ]),
                      child: Padding(
                        padding: Constants.paddingStudentsScreen,
                        child: ListTile(
                          onTap: () => studentsBloc
                              .add(StudentButtonNavigateEvent(index: index)),
                          tileColor: Constants.tiileColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          leading: imageWidget,
                          title: Text("${db[index][Constants.nameString]}"),
                          subtitle:
                              Text("${db[index][Constants.divisionString]}"),
                          trailing: const Icon(Icons.chevron_right_rounded),
                        ),
                      ),
                    );
                  },
                ),
              ));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
