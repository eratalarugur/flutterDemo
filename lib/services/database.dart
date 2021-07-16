import 'package:ali_ugur_eratalar_proj/models/appMessage.dart';
import 'package:ali_ugur_eratalar_proj/models/appUsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DBService {
  final String uid;
  String? converstaionId;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference messageCollection = FirebaseFirestore.instance.collection('messages');
  DBService({ required this.uid, this.converstaionId });

   ///********* Users Collection *********

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

  Future<void> updateAppUserData(AppUser user) async {
    return userCollection.doc(uid).update({
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

  ///********* Messages Collection *********

  Future<void> getAllMessagesFromConversation() async {
    messageCollection.doc('sdf').collection("sdf").snapshots();
  }

  Stream<List<AppMessage>> get messageList {
    return messageCollection.snapshots().map(_messageListFromDB);
  }

  List<AppMessage> _messageListFromDB(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => AppMessage(
              content: doc.get('content'),
              idFrom: doc.get('idFrom'),
              idTo: doc.get('idTo'),
              timestamp: doc.get('timestamp'),
            ))
        .toList();
  }

  Future<void> sendMessage(AppMessage message) async {
    return messageCollection.doc(uid).set({
      'content': message.content,
      'idFrom': message.idFrom,
      'idTo': message.idTo,
      'timestamp': message.timestamp,
    });
  }
}