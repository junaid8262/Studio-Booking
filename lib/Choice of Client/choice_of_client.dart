import 'package:flutter/material.dart';
import 'package:studio_booking_app/Auth/sign_in.dart';
import 'package:studio_booking_app/OnBoarding/on_boarding_artist.dart';
import 'package:studio_booking_app/OnBoarding/on_boarding_studio.dart';
import 'package:studio_booking_app/Shared%20Preference/shared_prefrence.dart';
import 'package:studio_booking_app/Values/constants.dart';

class ChoiceOfClient extends StatefulWidget {
  const ChoiceOfClient({Key? key}) : super(key: key);

  @override
  _ChoiceOfClientState createState() => _ChoiceOfClientState();
}

class _ChoiceOfClientState extends State<ChoiceOfClient> {
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

        body : Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Center(
                child: Container(
                  height: size.height*0.11,
                  width: size.width*0.4,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/artist_icon.png'),
                        fit: BoxFit.contain,
                      )
                  ),
                ),
              ),
              SizedBox(height: size.height*0.04),
              InkWell(
                onTap: ()
                {

                  SharedPref sharedPref=new SharedPref();
                  sharedPref.setArtist();
                  sharedPref.getFirstArtist().then((value) {
                    if(value)
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignIn()));
                      }
                    else
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OnBoardingArtist()));
                      }
                  });

                },
                child: Container(
                  height: size.height*0.06,
                  width: size.width*0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF0681D5),
                          Color(0xFF000080),
                        ],
                      )
                  ),
                  child: const Center(child: Text("I'm an artist",style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),),),
                ),
              ),
              SizedBox(height: size.height*0.08),
              Center(
                child: Container(
                  height: size.height*0.16,
                  width: size.width*0.6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/studio_icon.png'),
                        fit: BoxFit.contain,
                      )
                  ),
                ),
              ),
              SizedBox(height: size.height*0.04),
              InkWell(
                onTap: ()
                {
                       SharedPref sharedPref=new SharedPref();
                       sharedPref.setStudio();
                       sharedPref.getFirstStudio().then((value) {
                         if(value)
                         {
                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignIn()));
                         }
                         else
                         {
                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => OnBoardingStudio()));
                         }
                       });

                },
                child: Container(
                  height: size.height*0.06,
                  width: size.width*0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF0681D5),
                          Color(0xFF000080),
                        ],
                      )
                  ),
                  child: const Center(child: Text("I am a Studio",style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),),),
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
}
