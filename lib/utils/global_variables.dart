import 'package:flutter/material.dart';
import 'package:students_mate/screens/chat_screen.dart';
import 'package:students_mate/screens/feed_screen.dart';
import 'package:students_mate/screens/profile_screen.dart';
import 'package:students_mate/screens/student_attendence_view.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Center(
      child: Text(
    "Friends",
    style: TextStyle(fontWeight: FontWeight.bold),
  )),
  StudentAttendenceView(),
  ChatPage(),
  ProfileScreen()
];
