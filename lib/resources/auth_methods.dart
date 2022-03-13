// import 'dart:js';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:students_mate/models/user.dart' as model;
import 'package:students_mate/resources/storage_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var userexist;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

  // Sign up user
  Future<String> signupUser(
      {required String uprn,
      required String name,
      required String email,
      required String contactnum,
      required String dept,
      required String password,
      required Uint8List file}) async {
    String res = "Some error occured";
    await _firestore.collection('users').doc(uprn).get().then((docSnapshot) => {
          if (docSnapshot.exists) {userexist = true} else {userexist = false}
        });
    try {
      if (!userexist) {
        if (uprn.isNotEmpty ||
            name.isNotEmpty ||
            contactnum.isNotEmpty ||
            dept.isNotEmpty ||
            email.isNotEmpty ||
            password.isNotEmpty) {
          // register user with email and password
          UserCredential cred = await _auth.createUserWithEmailAndPassword(
              email: email.trim(), password: password);
          String photoUrl = await StorageMethods()
              .uploadImageToStorage('profilePictures', file, false);
          // store rest details to firestore

          model.User user = model.User(
            uprn: uprn,
            uid: cred.user!.uid,
            name: name,
            contactnum: contactnum,
            dept: dept,
            email: email,
            photoUrl: photoUrl,
          );

          await _firestore
              .collection('users')
              .doc(cred.user!.uid)
              .set(user.toJson());
          res = 'Success';
        }
      } else {
        res = "UPRN already exist";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "invalid-email") {
        res = 'The Email is badly formatted';
      } else if (err.code == "weak-password") {
        res = "Your Password should contain atleast 6 characters";
      }
    } catch (err) {
      res = err.toString();
      print("error found");
    }
    return res;
  }

  // Login screen
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == "user-not-found") {
        res = 'User is not found';
      } else if (err.code == "wrong-password") {
        res = "Your Password is not right";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> SignOut() async {
    await _auth.signOut();
  }
}
