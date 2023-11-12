import 'package:capstone_focus/parentsManagement/ManageGames.dart';
import 'package:capstone_focus/parentsManagement/MessageScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Statistics.dart';

void main() {
  runApp(MaterialApp(
    home: ParentMainScreen(),
  ));
}

class ParentMainScreen extends StatefulWidget {
  const ParentMainScreen({Key? key}) : super(key: key);

  @override
  _ParentMainScreenState createState() => _ParentMainScreenState();
}

class _ParentMainScreenState extends State<ParentMainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: Image.asset('assets/mainbg.png'),
                  ),
                  Text(
                    "Focus Finder",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
          backgroundColor: Colors.teal,
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            StatisticsPage(),
            ManageGames(), // Add the Reports page here
            MessageScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings), // Icon for Reports
              label: 'Manage', // Label for Reports
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Message',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}










