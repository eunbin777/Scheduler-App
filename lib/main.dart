import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 
import 'package:term_project/FirstPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        body: Center(
          child: FirstPage(),
        ),
      ),
    );
  }
}

