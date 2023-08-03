import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_database/utils/widgets/form.dart';

import '../bloc/details_bloc.dart';

class StudentDetails extends StatefulWidget {
  final int index;
  const StudentDetails({super.key, required this.index});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  @override
  void initState() {
    detailsBloc.add(DetailsInitialEvent());
    super.initState();
  }

  DetailsBloc detailsBloc = DetailsBloc();
  bool enabled = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: detailsBloc,
        listenWhen: (previous, current) => current is DetailsActionstate,
        buildWhen: (previous, current) => current is! DetailsActionstate,
        listener: (context, state) {
          if (state is DetailsUpdatedState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Student Detail Updated')));
          } else if (state is DetailsDeletedState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is DetailsLoadingState) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is DetailsLoadedState) {
            var db = state.students;
            var img = db[widget.index]['image'];
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        enabled = !enabled;
                        setState(() {});
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        detailsBloc
                            .add(DeleteClickedEvent(index: db[widget.index]['id']));
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
              body: SingleChildScrollView(
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150,
                          color: Colors.deepPurpleAccent,
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 100, left: 30, right: 30),
                          width: double.infinity,
                          child: CustomFormWidget(
                            bloc: detailsBloc,
                            index: db[widget.index]['id'],
                            option: false,
                            enabled: enabled,
                            name: db[widget.index]['name'],
                            age: db[widget.index]['age'],
                            address: db[widget.index]['address'],
                            batch: db[widget.index]['division'],
                            bloodgroup: db[widget.index]['bloodgroup'],
                            contact: db[widget.index]['contact'],
                            image: db[widget.index]['image'],
                          ),
                        ),
                        const SizedBox(height: 30,)
                      ],
                    ),
                    const Positioned(
                      top: 70,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      top: 75,
                      child: Hero(
                        tag: "image",
                        child: CircleAvatar(
                          radius: 75,
                          backgroundImage: MemoryImage(img),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text("error"),
              ),
            );
          }
        });
  }
}
