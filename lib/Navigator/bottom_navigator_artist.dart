import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studio_booking_app/Artist%20Screens/home_artist.dart';
import 'package:studio_booking_app/Artist%20Screens/my_profile.dart';
import 'package:studio_booking_app/Artist%20Screens/explore_nearby.dart';
import 'package:studio_booking_app/Artist%20Screens/reservation.dart';
import 'package:studio_booking_app/Model/user_model.dart';
import 'package:studio_booking_app/Values/constants.dart';

class BottomBarArtist extends StatefulWidget {
  UserModel model;

  BottomBarArtist(this.model);

  @override
  _BottomBarArtistState createState() => _BottomBarArtistState();
}

class _BottomBarArtistState extends State<BottomBarArtist> {

  int _currentIndex = 0;

  List<Widget> _children=[];

  @override
  void initState() {
    super.initState();
    _children =  [
      HomeArtist(widget.model),
      NearbyStudio(),
      Reservation(),
      MyProfile(widget.model),
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
                    icon: Icon(Icons.home,size: 22,),
                    title: Text("Home")
                ),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.location_solid,size: 22),
                    title: Text("Explore")
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book_outlined,size: 22),
                    title: Text("Reservation")
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person,size: 22),
                    title: Text("Profile")
                ),

              ],
            )),
      ),
      body: _children[_currentIndex],

    );
  }
}
