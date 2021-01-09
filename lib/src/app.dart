import 'package:flutter/material.dart';
import 'package:task_flutter_app/src/screens/firstScreen.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: FirstScreen(),
      ),
    );
  }
}