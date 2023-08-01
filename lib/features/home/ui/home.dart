import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:student_database/features/home/bloc/home_bloc.dart';
import 'package:student_database/features/studentlist/ui/students_screen.dart';

import '../../addstudent/ui/add_screen.dart';
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
            print("asdd");
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddStudentPage()));
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                  // backgroundColor: Colors.blueAccent,
                  ),
              drawer: Container(
                color: Colors.white,
                width: MediaQuery.sizeOf(context).width / 1.5,
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardWidget(homeBloc: homeBloc),
                      Card(
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.white,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StudentsPage(),
                              )),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                "assets/svg/viewstudent.svg",
                                fit: BoxFit.contain,
                                height: MediaQuery.sizeOf(context).width / 1.5,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "View Students",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CircleAvatar(
                                    maxRadius: 10,
                                    child: Icon(Icons.arrow_forward_ios_rounded,
                                        size: 10),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
