import 'package:ali_ugur_eratalar_proj/models/appUsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DBService {
  final String uid;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  DBService({ required this.uid });

  Future<void> createUserData(String name, int colorStrength) async {
    return  userCollection.doc(uid).set({
        'name': name,
        'strength': colorStrength,
      });
  }

  Future<void> createAppUserData(AppUser user) async {
    return userCollection.doc(uid).set({
      'name': user.name,
      'strength': user.strength,
    });
  }

  List<AppUser> _userListFromDB(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => AppUser(name: doc.get('name'), strength: doc.get('strength'))).toList();
  }

  Stream<List<AppUser>> get userList {
    return userCollection.snapshots().map(_userListFromDB);
  }

}