import 'package:flutter/material.dart';
import 'package:fluttertodoapp/helpers/drawer_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yapılacaklar Listesi"),
      ),
      drawer: DrawerNavigation(),
    );
  }
}
