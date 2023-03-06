import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';

class Database {
  String username;
  dynamic pass;
  Database({required this.username, required this.pass});

  final firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getinfo() async {
    CollectionReference collect = firestore.collection('collect');
    late Map<String, dynamic> data = {'user':username, 'password': pass };

    await collect.add(data);

    try {
      await FirebaseFirestore.instance.collection('collect').add(data);
    } catch (e) {
      log(e.toString());
    }
    return data;
  }
}
