import 'package:ali_ugur_eratalar_proj/routes/authStatus.dart';
import 'package:ali_ugur_eratalar_proj/services/auth.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    // title: "ugureratalar",
    home: Wrapper(),
  ));
}

class Wrapper extends StatelessWidget {
  // const Wrapper({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('Cannot connect to firebase ' + snapshot.error.toString());
          return NoFirebaseView();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print('Firebase connected');
          return MyApp();
        }
        return LoadingView();
      },
    );
  }
}

class NoFirebaseView extends StatelessWidget {
  const NoFirebaseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Cannot connect to server',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Cannot connect to server',
            style:
            TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
      ),
      
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver analyticsObserver = FirebaseAnalyticsObserver(
      analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        navigatorObservers: [analyticsObserver],
          home: AuthenticationStatus(analytics: analytics, analyticsObserver: analyticsObserver,),
      ),
    );
  }
}
