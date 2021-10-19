import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sk_onboarding_screen/sk_onboarding_model.dart';
import 'package:sk_onboarding_screen/sk_onboarding_screen.dart';
import 'package:studio_booking_app/Auth/sign_in.dart';
import 'package:studio_booking_app/Shared%20Preference/shared_prefrence.dart';
import 'package:studio_booking_app/Values/constants.dart';

class OnBoardingArtist extends StatefulWidget {
  const OnBoardingArtist({Key? key}) : super(key: key);

  @override
  _OnBoardingArtistState createState() => _OnBoardingArtistState();
}

class _OnBoardingArtistState extends State<OnBoardingArtist> {

  @override
  void initState() {

    SharedPref sharedPref=new SharedPref();
    sharedPref.setFirstArtist();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
/*
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
*/

    return  Scaffold(
       body : SKOnboardingScreen(
          bgColor: Colors.white,
          themeColor: primaryColor,
          pages: pages,
          skipClicked: (value) {
            print("Skip");
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const SignIn()),);
          },
          getStartedClicked: (value) {
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const SignIn()),);
            print("Get Started");
          },
        ),
    );
  }

  final pages = [
    SkOnboardingModel(
        title: 'Find your studio',
        description:
        'Compare the studios among several criteria of your choice (price, location, service, etc.). Select the one that matches your musical world.',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/pin.png'),
    SkOnboardingModel(
        title: 'Reserve in a few clicks',
        description:
        'Reserve the times of your choice. Pay online or directly on site.',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/calender.png'),
    SkOnboardingModel(
        title: 'Record your sound',
        description: 'This is it, the start of an adventure.Go to the chosen studio, take full advantage of your session and let your passion express itself.',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/rocket.png'),
  ];



}
