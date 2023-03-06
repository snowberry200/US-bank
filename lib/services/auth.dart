// import 'dart:developer';

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// class Authservice {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   //sign in email&password

//   Future emailPasswordSignIn(
//       {required String email, required String password}) async {
//     try {
//       final UserCredential userCredential = await _auth
//           .signInWithEmailAndPassword(email: email, password: password);
//       User user = userCredential.user!;
//       return user;
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future signIn({required String email, required String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      log(e.toString());
    }
    return Container();
  }
}
