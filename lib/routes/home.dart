import 'package:ali_ugur_eratalar_proj/services/auth.dart';
import 'package:ali_ugur_eratalar_proj/utils/crashlytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:ali_ugur_eratalar_proj/utils/color.dart';
import 'package:ali_ugur_eratalar_proj/utils/style.dart';
import 'package:ali_ugur_eratalar_proj/utils/analytics.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCurrentScreen(widget.analytics, 'Home Page', 'HomePageState');
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "My App",
          style: appBarTextStyle,
        ),
        leading: GestureDetector (
          onTap: () {
            print('open edit user page');
          },
          child: Icon(
            Icons.settings,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Column (
            children: [
              SizedBox(height: 20),
              Text(
                "Welcome to my app",
                style: regularTextStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              OutlinedButton(
                onPressed: () {
                  setUserId(widget.analytics, widget.analyticsObserver,  'eratalar');
                  print('* --> sent UserID!');
                },
                child: Text(
                  'Send UserID',
                  style: subtitleTextStyle,
                ),
              ),
              OutlinedButton(
                  onPressed: () {
                    Map<String, dynamic>parameters = {
                      'string': 'string',
                      'int': 123,
                      'bool': false,
                    };
                    logCustomEvent(widget.analytics, 'CustomHomeLog', parameters);
                    print('* --> CustomHomeLog logged! $parameters');
                  },
                child: Text(
                    'Log Custom Event',
                  style: subtitleTextStyle,
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  crashlytics.crashApp();
                  print('* --> App crashed!');
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppColors.warningColor,
                ),
                child: Text(
                  'Crash App!',
                  style: subtitleTextStyle,
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  _auth.signOut();
                  print('* --> App crashed!');
                },
                child: Text(
                  'Logout user',
                  style: subtitleTextStyle,
                ),
              ),
            ],
        ),
      ),
    );
  }
}

