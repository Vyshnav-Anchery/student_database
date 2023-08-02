import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: detailsBloc,
        listenWhen: (previous, current) => current is DetailsActionstate,
        buildWhen: (previous, current) => current is! DetailsActionstate,
        listener: (context, state) {},
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
              appBar: AppBar(),
              body: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.deepPurpleAccent,
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
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
