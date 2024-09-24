import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String? name;
  String? email;

  User({
    this.id,
    this.name,
    this.email,
  });

  User.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    email = documentSnapshot["email"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
    };
  }
}
