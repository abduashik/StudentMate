import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String uprn;
  final String uid;
  final String name;
  final String contactnum;
  final String dept;
  final String email;
  final String photoUrl;

  const User(
      {required this.uprn,
      required this.uid,
      required this.name,
      required this.contactnum,
      required this.dept,
      required this.email,
      required this.photoUrl});

  Map<String, dynamic> toJson() => {
        'UPRN': uprn,
        'UID': uid,
        'Name': name,
        'Contact Number': contactnum,
        'Department': dept,
        'Email': email,
        'Photo URL': photoUrl
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uprn: snapshot['UPRN'],
      uid: snapshot['UID'],
      name: snapshot['Name'],
      contactnum: snapshot['Contact Number'],
      dept: snapshot['Department'],
      email: snapshot['Email'],
      photoUrl: snapshot['Photo URL'],
    );
  }
}
