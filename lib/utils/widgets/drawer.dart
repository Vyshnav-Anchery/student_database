import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),),
        title: Text(FirebaseAuth.instance.currentUser!.displayName!),
        subtitle: Text(FirebaseAuth.instance.currentUser!.email!,style: TextStyle(fontSize: 12)),
        ),
        ElevatedButton(
          onPressed: () => FirebaseAuth.instance.signOut(),
          child: Text("logout"),
        ),
      ],
    ));
  }
}
