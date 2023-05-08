import 'package:embulance/screens/home_screens/account_screens/account.dart';
import 'package:embulance/screens/home_screens/acitivity.dart';
import 'package:embulance/screens/home_screens/home.dart';
import 'package:embulance/screens/home_screens/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBar createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ActivityScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 12,
        currentIndex:
            _selectedIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: new Icon(Icons.volunteer_activism),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            label: 'Account',
          ),
        ],
        selectedFontSize: 15,
        unselectedFontSize: 12,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[500],
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
      ),
    );
  }
}
