
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studio_booking_app/Auth/sign_in.dart';
import 'package:studio_booking_app/Choice%20of%20Client/choice_of_client.dart';
import 'package:studio_booking_app/Model/user_model.dart';
import 'package:studio_booking_app/Navigator/bottom_navigator_artist.dart';
import 'package:studio_booking_app/Navigator/bottom_navigator_studio.dart';
import 'package:studio_booking_app/OnBoarding/on_boarding_artist.dart';
import 'package:studio_booking_app/OnBoarding/on_boarding_studio.dart';
import 'package:studio_booking_app/Shared%20Preference/shared_prefrence.dart';

class SplashScreen extends StatefulWidget {
/*  static String routeName = "/splash";
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);*/

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 5;


  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {

    SharedPref sharedPref=new SharedPref();
    sharedPref.getChoiceOfClient().then((value) {
      if(value == 0 )
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ChoiceOfClient()));
        }
      else if(value == 1 )
      {

        sharedPref.getFirstArtist().then((value) {
          if(value)
          {
            User? user = FirebaseAuth.instance.currentUser;

            if(user != null)
            {
              FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((DocumentSnapshot documentSnapshot) {
                Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
                UserModel model= UserModel.fromMap(data, documentSnapshot.reference.id);

                if (user.emailVerified && documentSnapshot.exists && data['type'] == "artist") {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (BuildContext context) => BottomBarArtist(model)));
                }
                else{
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (BuildContext context) => SignIn()));
                }

              });
            }

            else if (user == null ) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) => SignIn()));
            }
          }
          else
          {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OnBoardingArtist()));
          }
        });
      }
      else
        {
          sharedPref.getFirstStudio().then((value) {
            if(value)
            {
              User? user = FirebaseAuth.instance.currentUser;

              if(user != null)
              {
                FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((DocumentSnapshot documentSnapshot) {
                  Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
                  UserModel model= UserModel.fromMap(data, documentSnapshot.reference.id);

                  if (user.emailVerified && documentSnapshot.exists && data['type'] == "studio") {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (BuildContext context) => BottomBarStudio(model)));
                  }
                  else{
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (BuildContext context) => SignIn()));
                  }

                });
              }

              else if (user == null ) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) => SignIn()));
              }
            }
            else
            {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OnBoardingStudio()));
            }
          });
        }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height,
        decoration:  BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey.shade300,
                Colors.white,
          /*      Color(0xff000080),
                Color(0xff104FE4),*/
              ],
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.2,),
              Image.asset("assets/images/logo.png"),
              SizedBox(height: MediaQuery.of(context).size.height*0.15,),
              Image.asset("assets/images/texts2.png"),
            ],
          ),
        ),

      ),
    );
  }
}
