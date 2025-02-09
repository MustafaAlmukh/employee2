import 'package:employee/MyHomePage.dart';
import 'package:employee/register.dart';
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
        apiKey: "AIzaSyBaBPbR3zVeBzL20XyhRj0GJSskDC-ix3o",
        authDomain: "herasa10.firebaseapp.com",
        databaseURL: "https://herasa10-default-rtdb.europe-west1.firebasedatabase.app",
        projectId: "herasa10",
        storageBucket: "herasa10.firebasestorage.app",
        messagingSenderId: "316219989410",
        appId: "1:316219989410:web:fe81b8574f9584f70d26fb"
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
