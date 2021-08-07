import 'package:beco_passenger/stores/map_store.dart';
import 'package:flutter/material.dart';

import 'package:beco_passenger/views/ChooseSign/ChooseSign.dart';
import 'package:beco_passenger/views/HomeScreen/HomeScreen.dart';
import 'package:beco_passenger/views/Splashscreen/Splashscreen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MapStore>(create: (_) => MapStore()),
      ],
      child: MaterialApp(
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
                  } else {
                    return ChooseSign();
                  }
                },
              );
            }
            return SplashScreen();
          },
        ),
      ),
    );
  }
}
