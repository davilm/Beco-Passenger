import 'package:flutter/material.dart';

import 'package:beco_passenger/getRouteDetails.dart';

import 'package:beco_passenger/views/ChooseSign/ChooseSign.dart';
import 'package:beco_passenger/views/HomeScreen/HomeScreen.dart';
import 'package:beco_passenger/views/Splashscreen/Splashscreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

/// We are using a StatefulWidget such that we only create the [Future] once,
/// no matter how many times our widget rebuild.
/// If we used a [StatelessWidget], in the event where [App] is rebuilt, that
/// would re-initialize FlutterFire and make our application re-enter loading state,
/// which is undesired.
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("hasError");

            return Container(
              child: Center(
                child: Text("hasError"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapshot) {
                if (userSnapshot.hasData) {
                  return HomeScreen();

                  // final String selectedRoute = "Gwo9mVet7JJMi2Je8yRw";
                  // return GetRouteDetails(selectedRoute);
                } else {
                  return ChooseSign();
                }
              },
            );
          }
          return SplashScreen();
        },
      ),
    );
  }
}
