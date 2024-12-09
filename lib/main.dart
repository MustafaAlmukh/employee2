import 'package:employee/MyHomePage.dart';
import 'package:employee/search.dart';
import 'package:employee/show.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase only once
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAL7p7mxgluOLfqKjyljfWom3mtwPOE-Sw",
      authDomain: "univirsty-eb962.firebaseapp.com",
      databaseURL: "https://univirsty-eb962-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "univirsty-eb962",
      storageBucket: "univirsty-eb962.appspot.com",
      messagingSenderId: "597400083122",
      appId: "1:597400083122:web:637758fefd98eb84e787ab",
      measurementId: "G-VD3GEMZR92",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("ar", "AE"), // OR Locale('ar', 'AE') OR Other RTL locales
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Mada",
        primarySwatch: Colors.blue,
      ),
      home: SearchScreen(),
    );
  }
}
