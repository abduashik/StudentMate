import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:students_mate/providers/user_provider.dart';
import 'package:students_mate/models/user.dart' as model;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoUrl),
              radius: 75,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              user.name,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(user.uprn),
            // const SizedBox(
            //   height: 10,
            // ),
            // Text(user.dept),
            const SizedBox(
              height: 10,
            ),
            Text(user.contactnum),
          ],
        ),
      ),
    );
  }
}
