import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_database/features/addstudent/ui/add_screen.dart';
import 'package:student_database/features/details/ui/details.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
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
        if (state is HomeLoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is HomeLoadedState) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Studentdb"),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(StudentButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.details)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(StudentButtonClearEvent());
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
