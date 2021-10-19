import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sk_onboarding_screen/sk_onboarding_model.dart';
import 'package:sk_onboarding_screen/sk_onboarding_screen.dart';
import 'package:studio_booking_app/Auth/sign_in.dart';
import 'package:studio_booking_app/Shared%20Preference/shared_prefrence.dart';
import 'package:studio_booking_app/Values/constants.dart';

class OnBoardingStudio extends StatefulWidget {
  const OnBoardingStudio({Key? key}) : super(key: key);

  @override
  _OnBoardingStudioState createState() => _OnBoardingStudioState();
}

class _OnBoardingStudioState extends State<OnBoardingStudio> {

  @override
  void initState() {

    SharedPref sharedPref=new SharedPref();
    sharedPref.setFirstStudio();
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
        title: 'Increase its visibility',
        description:
        'List your studio for free. Take advantage of the flow of visitors, and this new means of communication to strengthen your image.',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/visibility.png'),
    SkOnboardingModel(
        title: 'Win time',
        description:
        'The platform is made for you, to facilitate the management of daily sessions. This will give you more time for other activities related to your studio.',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/managment.png'),
    SkOnboardingModel(
        title: 'Increase your income',
        description: 'With the increase in your attendance, and the acquisition of new customers, your turnover will be amplified.',
        titleColor: Colors.black,
        descripColor: const Color(0xFF929794),
        imagePath: 'assets/images/income.png'),
  ];



}
