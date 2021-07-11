import 'package:ali_ugur_eratalar_proj/routes/home.dart';
import 'package:ali_ugur_eratalar_proj/routes/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:provider/provider.dart';

class AuthenticationStatus extends StatefulWidget {
  const AuthenticationStatus({Key? key, required this.analytics, required this.analyticsObserver}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver analyticsObserver;

  @override
  _AuthenticationStatusState createState() => _AuthenticationStatusState();
}

class _AuthenticationStatusState extends State<AuthenticationStatus> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context);
    if(user == null) {
      return SignIn();
    } else {
      return HomePage(
          analytics: widget.analytics,
          analyticsObserver: widget.analyticsObserver
      );
    }
  }
}

