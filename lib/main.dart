import 'Login.dart';
import 'SignUp.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

<<<<<<< HEAD
class MyApp extends StatelessWidget {
  // This widget is the root of our application.
=======
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
>>>>>>> 1abdc7fb88734433f7eedda25e74ddf5673c28e5
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Electrical Consumption',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginPage(),
    );
  }
}
