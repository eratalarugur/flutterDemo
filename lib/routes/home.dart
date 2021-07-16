import 'package:ali_ugur_eratalar_proj/models/appUsers.dart';
import 'package:ali_ugur_eratalar_proj/routes/post_list.dart';
import 'package:ali_ugur_eratalar_proj/routes/update.dart';
import 'package:ali_ugur_eratalar_proj/services/auth.dart';
import 'package:ali_ugur_eratalar_proj/services/database.dart';
import 'package:ali_ugur_eratalar_proj/utils/crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ali_ugur_eratalar_proj/utils/color.dart';
import 'package:ali_ugur_eratalar_proj/utils/style.dart';
import 'package:ali_ugur_eratalar_proj/utils/analytics.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.analytics, required this.analyticsObserver}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver analyticsObserver;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var crashlytics = Crashlytics();
  var _auth = AuthService();

  Future<bool> _willPop() async {
    return false;
  }

  @override
  void initState() {
    super.initState();
    setCurrentScreen(widget.analytics, 'Home Page', 'HomePageState');
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);
    final db = DBService(uid: user!.uid);
    // int strength = Random().nextInt(7) * 100 + 100;
    // AppUser appUser = AppUser(name: 'NewUser $strength', strength: strength);
    // db.createAppUserData(appUser);

    void _showProfileSettings() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage()));

    }

    return  StreamProvider<List<AppUser>>.value(
      value: db.userList,
      initialData: [],
      child: WillPopScope(
        onWillPop: _willPop,
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            title: Text(
              'Users List',
              style: appBarTextStyle,
            ),
           actions: [
             IconButton(
               onPressed: () => _showProfileSettings(),
               icon: Icon(Icons.settings,
                 color: AppColors.appBarTitleColor,
               ),
             ),
           ],
            centerTitle: true,
            backgroundColor: AppColors.primary,
          ),
          body: UserListView(),
        ),
      ),
    );
  }
}

