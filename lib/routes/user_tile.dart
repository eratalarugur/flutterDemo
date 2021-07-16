import 'package:flutter/material.dart';
import 'package:ali_ugur_eratalar_proj/models/appUsers.dart';

class UserTile extends StatelessWidget {

  final AppUser user;
  const UserTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 0,
        child: Row (
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.purple[user.strength],
              ),
            ),
            SizedBox(width: 16,),
            Expanded(child: Text((user.name))),
            IconButton(
                onPressed: () {
                  print('send me message baby!');
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => MessagePage()));
                },
                icon: Icon(Icons.send_rounded, color: Colors.purple[user.strength],),
            ),
          ],
        ),
    );
  }
}
