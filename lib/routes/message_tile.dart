import 'package:flutter/material.dart';
import 'package:ali_ugur_eratalar_proj/models/appUsers.dart';
import 'package:ali_ugur_eratalar_proj/models/appMessage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ali_ugur_eratalar_proj/utils/color.dart';

class MessageTile extends StatelessWidget {

  final AppUser userTo;
  final AppMessage message;
  const MessageTile({Key? key, required this.userTo, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chip (
        labelPadding: EdgeInsets.all(4),
        label: Text(
          message.content,
          style: TextStyle(
              color: Colors.white
          ),
        ),
        backgroundColor: (message.idFrom == user!.uid) ? AppColors.primary:AppColors.primaryTextColor,
        elevation: 4,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(8),
      ),
    );
  }
}
