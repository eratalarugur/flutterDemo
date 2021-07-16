import 'package:ali_ugur_eratalar_proj/models/appMessage.dart';
import 'package:ali_ugur_eratalar_proj/models/appUsers.dart';
import 'package:ali_ugur_eratalar_proj/routes/message_list.dart';
import 'package:ali_ugur_eratalar_proj/utils/color.dart';
import 'package:ali_ugur_eratalar_proj/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ali_ugur_eratalar_proj/services/database.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key, required this.receiverID}) : super(key: key);

  final String receiverID;

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);
    final db = DBService(uid: user!.uid);

    return StreamProvider<List<AppMessage>>.value (
      value: db.messageList,
      initialData: [],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text(
            'Message',
            style: appBarTextStyle,
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
        ),
        body: MessageListView(userTo: AppUser(name: 'ugur', strength: 19),),
      ),
    );
  }
}
