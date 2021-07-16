import 'package:ali_ugur_eratalar_proj/models/appUsers.dart';
import 'package:ali_ugur_eratalar_proj/routes/message_tile.dart';
import 'package:flutter/material.dart';
import 'package:ali_ugur_eratalar_proj/models/appMessage.dart';
import 'package:provider/provider.dart';
import 'package:ali_ugur_eratalar_proj/routes/user_tile.dart';
import 'package:ali_ugur_eratalar_proj/models/appUsers.dart';

class MessageListView extends StatefulWidget {
  final AppUser userTo;
  const MessageListView({Key? key, required this.userTo}) : super(key: key);

  @override
  _MessageListViewState createState() => _MessageListViewState();
}

class _MessageListViewState extends State<MessageListView> {
  @override
  Widget build(BuildContext context) {

    final messageList = Provider.of<List<AppMessage>>(context);
    return Column(
      children: [
        Expanded(
            child: ListView.builder (
              itemCount: messageList.length,
              itemBuilder: (BuildContext context, int index) {
                return MessageTile(userTo: AppUser(name: 'ugur', strength: 19), message: messageList[index]);
              },
            ),
        ),
      ],
    );
  }
}
