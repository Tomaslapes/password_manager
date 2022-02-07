import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/login_page.dart';

void main() {
  // Needed because of DB
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      home: const LoginScreen(),
    );
  }
}



