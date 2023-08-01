import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:student_database/features/home/bloc/home_bloc.dart';

class CardWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  final String path;
  final event;
  final String buttonText;
  const CardWidget({
    super.key,
    required this.homeBloc,
    required this.event,
    required this.path,
    required this.buttonText,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.white,
        onTap: () => homeBloc.add(event),
        child: Column(
          children: [
            SvgPicture.asset(
              path,
              fit: BoxFit.contain,
              height: MediaQuery.sizeOf(context).width / 1.5,
            ),
            const SizedBox(
              height: 20,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonText,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  width: 5,
                ),
                const CircleAvatar(
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
