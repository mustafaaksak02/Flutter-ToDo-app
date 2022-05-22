import 'package:flutter/material.dart';
import 'package:fluttertodoapp/screens/categories_screen.dart';
import 'package:fluttertodoapp/screens/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children:  <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2016/12/13/18/53/android-1904852_640.jpg"),
              ),
                accountName: Text("Mustafa Aksak"),
                accountEmail: Text("mustafaaksak2@gmail.com"),
                decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Anasayfa"),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen())),


            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text("Kategoriler"),
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CategoriesScreen())),

            ),
           ],
        ),
      ),
    );
  }
}
