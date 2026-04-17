import 'package:flutter/material.dart';
import 'package:project_4/page/beranda_page.dart';
import 'package:project_4/page/profile_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> _page = [BerandaPage(), ProfilePage()];

  int currentPage = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: _page[currentPage],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: currentPage,
          onTap: (i) => setState(() => currentPage = i),
          items: [
            // Beranda
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Beranda"),
              selectedColor: Colors.blue,
            ),

            // Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
