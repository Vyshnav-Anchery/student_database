import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    TextEditingController nameEditingController = TextEditingController();
    TextEditingController ageEditingController = TextEditingController();
    TextEditingController numberEditingController = TextEditingController();
    TextEditingController addressEditingController = TextEditingController();
    TextEditingController bloodEditingController = TextEditingController();
    TextEditingController stdEditingController = TextEditingController();

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
                  builder: (context) => const StudentDetails(),
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
                    icon: const Icon(Icons.details))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameEditingController,
                            ),
                            TextFormField(
                              controller: ageEditingController,
                            ),
                            TextFormField(
                              controller: numberEditingController,
                            ),
                            TextFormField(
                              controller: addressEditingController,
                            ),
                            TextFormField(
                              controller: bloodEditingController,
                            ),
                            TextFormField(
                              controller: stdEditingController,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  homeBloc.add(AddClickedEvent(
                                    name: nameEditingController.text,
                                    address: addressEditingController.text,
                                    age: int.parse(ageEditingController.text),
                                    bloodgrp: bloodEditingController.text,
                                    number:
                                        int.parse(numberEditingController.text),
                                    division: stdEditingController.text,
                                  ));
                                },
                                child: const Text("add"))
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
            body: ListView.builder(
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                var db = state.students;
                return ListTile(
                  leading: Text("${db[index]['id']}"),
                  title: Text("${db[index]['name']}"),
                  subtitle: Text("${db[index]['address']}"),
                  trailing: Text("${db[index]['bloodgroup']}"),
                );
              },
            ),
          );
        } else
          return SizedBox();
      },
    );
  }
}
