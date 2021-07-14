import 'package:ali_ugur_eratalar_proj/main.dart';
import 'package:ali_ugur_eratalar_proj/models/appUsers.dart';
import 'package:ali_ugur_eratalar_proj/routes/post_list.dart';
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
import 'dart:math';

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
  var _pageViewController = PageController(initialPage: 1);

  Future<bool> _willPop() async {
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCurrentScreen(widget.analytics, 'Home Page', 'HomePageState');
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);
    final db = DBService(uid: user!.uid);
    int strength = Random().nextInt(7) * 100 + 100;
    AppUser appUser = AppUser(name: 'Ugur', strength: strength);
    db.createAppUserData(appUser);

    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                  onPressed: () {
                    print('**> hello****');
                    Navigator.pop(context);
                  },
                  label: Text('Profile', style: TextStyle(color: AppColors.primary),),
                  icon: Icon(Icons.person,
                  color: AppColors.primary,
                  ),
              ),
              TextButton.icon(
                onPressed: () {
                  _auth.signOut();
                  Navigator.pop(context);
                },
                label: Text('Logout', style: TextStyle(color: AppColors.warningColor),),
                icon: Icon(Icons.exit_to_app_rounded,
                  color: AppColors.warningColor,
                ),
              ),
            ],
          ),
        );
      });
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
              'Home Page',
              style: appBarTextStyle,
            ),
           actions: [
             // IconButton(
             //     onPressed: () {
             //        _auth.signOut();
             //     },
             //     icon: Icon(Icons.exit_to_app_rounded,
             //     color: AppColors.appBarTitleColor,
             //     ),
             // ),
             IconButton(
               onPressed: () => _showSettingsPanel(),
               icon: Icon(Icons.settings,
                 color: AppColors.appBarTitleColor,
               ),
             ),
           ],
            centerTitle: true,
            backgroundColor: AppColors.primary,
          ),
          body: PageView (
              controller: _pageViewController,
              children: [
                UserListView(),
                _containerList(),
                Wrap(children: [ _loader()],),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildChip('Mesajimi aldin mi? Sesim geldi mi?', true),
                    ],
                ),
              ]
          )
        ),
      ),
    );
  }

  Widget _containerList() {
    return Wrap(
      children: [
        MyColorContainer(),
        MyColorContainer(),
        MyColorContainer(),
        MyColorContainer(),
      ],
    );
  }

  Widget MyColorContainer() {
    int strength = Random().nextInt(7) * 100 + 100;
    return Container (
      color: Colors.pink[strength],
      height: 64,
      width: 64,
    );
  }

  Widget _loader() {
    return AnimatedContainer(duration: Duration(seconds: 10,),
      color: Colors.transparent,
      curve: Curves.easeInOut,
      height: 5,
      width: 200,
      child: Container(
        color: Colors.orange,
      ),
    );
  }

  Widget _buildChip(String label, bool isUsers) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chip (
        labelPadding: EdgeInsets.all(4),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white
          ),
        ),
        backgroundColor: isUsers ? AppColors.primary:AppColors.primaryTextColor,
        elevation: 4,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(8),
      ),
    );
  }
}

