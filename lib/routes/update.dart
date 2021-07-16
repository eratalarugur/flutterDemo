import 'package:ali_ugur_eratalar_proj/models/appUsers.dart';
import 'package:ali_ugur_eratalar_proj/services/database.dart';
import 'package:ali_ugur_eratalar_proj/utils/color.dart';
import 'package:ali_ugur_eratalar_proj/utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ali_ugur_eratalar_proj/services/auth.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  var _auth = AuthService();
  String name = '';
  int strength = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final db = DBService(uid: user!.uid);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'Update User Info',
          style: appBarTextStyle,
        ),
      ),
      body: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Name',
                          labelStyle: regularTextStyle,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        onSaved: (String? value) {
                          name = value ?? '';
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Strength',
                          labelStyle: regularTextStyle,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (String? value) {
                          strength = value != null ? int.parse(value) : 0;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: ()  {
                          print('** USER INFO **');
                          user.updateDisplayName('displayName');
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            AppUser appUser =
                                AppUser(name: name, strength: strength);
                            db.updateAppUserData(appUser);
                            Navigator.pop(context);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Update',
                            style: primaryButtonTextStyle,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
