import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studio_booking_app/Auth/profile_setup.dart';
import 'package:studio_booking_app/Navigator/bottom_navigator_artist.dart';
import 'package:studio_booking_app/Values/constants.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {

  final auth = FirebaseAuth.instance;
  User? user;
  Timer? timer;
   String? userEmail;
   bool verified = false;
  sendVerification()async
  {
    user = auth.currentUser;
    if(user != null && user!.emailVerified == false )
      {
        userEmail = user!.email;
      await user!.sendEmailVerification();
      }
    else{

      print("already verified");

    }
  }

  @override
  void initState() {
    sendVerification();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          SizedBox(height: size.height*0.15,),
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(18), topRight:Radius.circular(18) , bottomRight: Radius.zero , bottomLeft: Radius.zero),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(height : size.height*0.07),

                const Center(child: Text("Verify Email",style: TextStyle(
                  fontSize: 24,
                ),),),

                SizedBox(height : size.height*0.05),

                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Center(
                    child: Container(
                      width: size.width*1,
                      child: RichText(
                        text:  TextSpan(
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                          children: <TextSpan>[
                            const TextSpan(text:"A Verification Email has been Sent to your email address "),
                            TextSpan(text: userEmail,style: const TextStyle(
                              fontWeight: FontWeight.w700
                            )),

                          ]
                        ),
                      ),
                    ),
                  ),
                ),
                
                Container(
                    height: size.height*0.4,
                    width: size.width*0.8,
                    child: Image.asset("assets/images/verifyEmail.png")),

                SizedBox(height: size.height*0.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Didn't recive the code ? ",style: TextStyle(
                      fontSize: 16
                    ),),
                    InkWell(
                      onTap: (){
                        sendVerification();
                      },
                      child: Text("Resend",style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                          fontSize: 16

                      ),),
                    ),
                  ],
                ),
                SizedBox(height: size.height*0.01,),

                InkWell(
                  onTap : (){
                    checkEmailVerified();
                  },
                  child: Container(
                    height: size.height*0.05,
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
                    child: const Center(child: Text("Verify",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),),),
                  ),
                )



              ],
            ),
          ),
        ],
      ),

    );
  }

  Future<void> checkEmailVerified() async{
    user = auth.currentUser;
    await user!.reload().then((value) => awsomeDialog());

  }

  awsomeDialog()
  {
    user = auth.currentUser;
    if(user!.emailVerified){

      print("verified");
      AwesomeDialog(
          context: context,
          animType: AnimType.LEFTSLIDE,
          headerAnimationLoop: false,
          dialogType: DialogType.SUCCES,
          showCloseIcon: true,
          title: 'Verified',
          autoHide: Duration(seconds: 3),
          btnOkIcon: Icons.check_circle,
          onDissmissCallback: (type) {
            debugPrint('Dialog Dissmiss from callback $type');
          }).show().then((_) => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  ProfileSetup())));
    }
    else
    {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          headerAnimationLoop: true,
          title: 'Not Verified',
          btnOkOnPress: () {},
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red)
          .show();

    }
  }
}
