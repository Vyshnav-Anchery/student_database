import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_database/features/home/bloc/home_bloc.dart';

class CardWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  const CardWidget({super.key,required this.homeBloc});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.white,
        onTap: () => homeBloc.add(HomeNavigateToAddEvent()),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/svg/addstudent.svg",
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
                  "Add Student",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  width: 5,
                ),
                CircleAvatar(
                  maxRadius: 10,
                  child: Icon(Icons.arrow_forward_ios_rounded, size: 10),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
