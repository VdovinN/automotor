import 'package:flutter/material.dart';

void main() {
  runApp(AutoMotorApp());
}

class AutoMotorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: OnBoardingPage(title: "Flutter Demo Home Page"),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  OnBoardingPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Center(
      child: Text("Catalog"),
    ),
    Center(
      child: Text("Favorite"),
    ),
    Center(
      child: Text("Cart"),
    ),
    Center(
      child: Text("Profile"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Catalog",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
