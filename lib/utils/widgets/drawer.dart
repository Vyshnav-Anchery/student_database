import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:student_database/utils/constants/constants.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouterState.of(context).name!;
    return Drawer(
        child: Column(
      children: [
        ListTile(
          tileColor: Constants.tiileColor,
          leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)),
          title: Text(FirebaseAuth.instance.currentUser!.displayName!),
          subtitle: Text(FirebaseAuth.instance.currentUser!.email!,
              style: const TextStyle(fontSize: 12)),
        ),
        InkWell(
          onTap: () =>
              GoRouter.of(context).pushNamed(RoutingConstants.homeRouteName),
          child: ListTile(
            selected:
                currentRoute == RoutingConstants.homeRouteName ? true : false,
            leading: Icon(Icons.home_filled),
            title: Text("Home"),
          ),
        ),
        InkWell(
          onTap: () => GoRouter.of(context)
              .pushNamed(RoutingConstants.addstudentsRouteName),
          child: ListTile(
            selected: currentRoute == RoutingConstants.addstudentsRouteName
                ? true
                : false,
            leading: Icon(Icons.addchart),
            title: Text("Add Students"),
          ),
        ),
        InkWell(
          onTap: () => GoRouter.of(context)
              .pushNamed(RoutingConstants.studentlistRouteName),
          child: ListTile(
            selected: currentRoute == RoutingConstants.studentlistRouteName
                ? true
                : false,
            leading: Icon(Icons.table_view),
            title: Text("View Students"),
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            GoRouter.of(context).pushReplacementNamed(RoutingConstants.loginRouteName);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Logout"),
              SizedBox(width: 20),
              Icon(Icons.logout_rounded),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    ));
  }
}
