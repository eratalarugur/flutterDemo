import 'package:ali_ugur_eratalar_proj/routes/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ali_ugur_eratalar_proj/models/appUsers.dart';


class UserListView extends StatefulWidget {
  const UserListView({Key? key}) : super(key: key);

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  @override
  Widget build(BuildContext context) {

    final userList = Provider.of<List<AppUser>>(context);
    userList.sort((a, b) { return (a.strength > b.strength ? 1:0);});

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (BuildContext context, int index) {
              return UserTile(user: userList[index]);
            }),
        ),
      ],
    );
  }
}
