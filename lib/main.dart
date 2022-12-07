import 'package:flutter/material.dart';
// import 'AppDrawer.dart';
// import 'package:term_project/Calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 
import 'package:term_project/FirstPage.dart';
// import 'package:term_project/LoginForm.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', 'KR'),
      ],
      title: 'Scheduler App',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(),
    //   drawer: AppDrawer(),
    //   body: Calendar()
    // );
    return MaterialApp (
      theme: ThemeData.light(),
      home: Scaffold(
        body: Center(
          child: FirstPage(),
        ),
      ),
    );
  }
}

