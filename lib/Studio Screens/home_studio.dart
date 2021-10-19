import 'package:flutter/material.dart';
import 'package:studio_booking_app/Model/user_model.dart';
import 'package:studio_booking_app/Studio%20Screens/add_studio.dart';
import 'package:studio_booking_app/Navigator/menu_drawer_studio.dart';
import 'package:studio_booking_app/Values/constants.dart';

class HomeStudio extends StatefulWidget {
  UserModel model;

  HomeStudio(this.model);
  @override
  _HomeStudioState createState() => _HomeStudioState();
}

class _HomeStudioState extends State<HomeStudio> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _openDrawer () {
    _drawerKey.currentState!.openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit an App?'),
          actions:[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () => Navigator.of(context).pop(false),
              //return false when click on "NO"
              child:Text('No'),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: primaryColor, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () => Navigator.of(context).pop(true),
              //return true when click on "Yes"
              child:Text('Yes'),
            ),

          ],
        ),
      )??false; //if showDialouge had returned null, then return false
    }
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        drawer: MenuDrawerStudio(widget.model),
        key: _drawerKey,
        body: Column(
          children: [
            Container(
              height: size.height*0.25,
              color: primaryColor,
              child: Column(
                children: [
                  SizedBox(height: size.height*0.06,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12,0,12,0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          onTap: (){
                             _openDrawer();
                          },
                          child: Image.asset("assets/icons/drawer.png",fit: BoxFit.cover,)),
                    ),
                  ),
                  SizedBox(height: size.height*0.06,),
                  const Padding(
                    padding:  EdgeInsets.fromLTRB(12,0,12,0),
                    child:  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Register your studio",style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),),
                    ),
                  ),
                  const Padding(
                    padding:  EdgeInsets.fromLTRB(12,0,12,0),
                    child:  Align(
                      alignment: Alignment.topLeft,
                      child: Text("The app for those who live in music",style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: size.height*0.675,
              width: double.infinity,
              color: Colors.white,
            ),

          ],
        ),
      ),
    );
  }
}
