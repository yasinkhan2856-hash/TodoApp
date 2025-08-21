
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../login and sign up/Login.dart';

class LastScreen extends StatefulWidget {
  const LastScreen({super.key});

  @override
  State<LastScreen> createState() => _LastScreenState();
}

class _LastScreenState extends State<LastScreen> {
  void signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    } catch (e) {
      print('Sign out error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF05243E),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
            child: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        )),
        backgroundColor: Color(0xFF05243E),
      ),
      body: Column(
        children: [
          myListTile(
              title: "Profile",
              leadingicon: Icons.person,
              trailingIcon: Icons.chevron_right_outlined),
          myListTile(
              title: "Converstion",
              leadingicon: Icons.chat_bubble,
              trailingIcon: Icons.chevron_right_outlined),
          myListTile(
              title: "Projects",
              leadingicon: Icons.pets_rounded,
              trailingIcon: Icons.chevron_right_rounded),
          myListTile(
              title: "Terms and Policies",
              leadingicon: Icons.screen_search_desktop,
              trailingIcon: Icons.chevron_right_outlined),
          ElevatedButton.icon(
              onPressed: signout,
              icon: Icon(Icons.logout),
              label: Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ))
        ],
      ),
    );
  }
}

Widget myListTile({
  required String title,
  required IconData leadingicon,
  required IconData trailingIcon,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
    child: Column(
      children: [
        Row(
          children: [
            Icon(
              leadingicon,
              color: Colors.white,
              size: 50,
            ),
            Gap(10),
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Spacer(),
            Icon(
              trailingIcon,
              color: Color(0xff86DAED),
            ),
          ],
        ),
        Divider(
          color: Colors.white54,
          thickness: 1,
        )
      ],
    ),
  );
}
