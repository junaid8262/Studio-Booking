import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studio_booking_app/Model/user_model.dart';
import 'package:studio_booking_app/Studio%20Screens/manager_profile.dart';
import 'package:studio_booking_app/Studio%20Screens/home_studio.dart';
import 'package:studio_booking_app/Studio%20Screens/reservation_request.dart';
import 'package:studio_booking_app/Values/constants.dart';

class BottomBarStudio extends StatefulWidget {
  UserModel model;

  BottomBarStudio(this.model);
  @override
  _BottomBarStudioState createState() => _BottomBarStudioState();
}

class _BottomBarStudioState extends State<BottomBarStudio> {
  int _currentIndex = 0;

  List<Widget> _children=[];

  @override
  void initState() {
    super.initState();
    _children =  [
      HomeStudio(widget.model),
      ReservationRequest(),
      ManagerProfile(widget.model),
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(

/*
      backgroundColor: Colors.grey[700],
*/
      bottomNavigationBar:
      SizedBox(
        height: size.height*0.075,
        child: ClipRRect(
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
                    icon: Icon(Icons.home,size: 22),
                    title: Text("Home")
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book_outlined,size: 22),
                    title: Text("Reservation")
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person,size: 22),
                    title: Text("Profile")
                ),
                /*
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    title: Text("Profile")
                ),*/

              ],
            )),
      ),
      body: _children[_currentIndex],

    );
  }
}
