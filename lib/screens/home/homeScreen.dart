import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgl_admin/backend/database.dart';
import 'package:sgl_admin/screens/home/doubleDataScreen.dart';
import 'package:sgl_admin/screens/home/singleDataScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //-----------------------------//
  int _currentIndex = 0;
  late PageController _pageController;
  //----------------------------//

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade700,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('SGL-Admin'),
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [SingleDataScreen(), DoubleDataScreen()],
      ),
      //--------Bottom-Navigation-Bar-----------//
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber.shade800,
        selectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              _currentIndex,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Single',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Double',
          ),
        ],
      ),
    );
  }
}
