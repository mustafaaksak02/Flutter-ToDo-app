import 'package:flutter/material.dart';
import 'package:fluttertodoapp/screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}