
import 'package:flutter/material.dart';
import 'package:texto/history.dart';
import 'package:texto/home_page.dart';
import 'package:texto/splashscreen.dart';


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Recognition Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MySplashScreen(),
      routes: {
        '/homePage': (context) => MyHomePage(),
        '/historyPage': (context) => MyHistory()
      },
    );
  }
}

