import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studio_booking_app/Screens/home.dart';
import 'package:studio_booking_app/Screens/my_profile.dart';
import 'package:studio_booking_app/Screens/explore_nearby.dart';
import 'package:studio_booking_app/Screens/reservation.dart';
import 'package:studio_booking_app/Values/constants.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomBar>{

  int _currentIndex = 0;

  List<Widget> _children=[];

  @override
  void initState() {
    super.initState();
    _children = const [
      Home(),
      NearbyStudio(),
      Reservation(),
      MyProfile(),
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    return Scaffold(

/*
      backgroundColor: Colors.grey[700],
*/
      bottomNavigationBar:
        ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(23.0), topRight: Radius.circular(23.0), ),
        child:BottomNavigationBar(
        backgroundColor: primaryColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey.shade500,
        selectedItemColor: Colors.white,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home")
          ),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.location_solid),
              title: Text("Explore")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined),
              title: Text("Reservation")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile")
          ),

        ],
      )),
      body: _children[_currentIndex],

    );
  }
}