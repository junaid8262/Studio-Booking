import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studio_booking_app/Auth/google_auth.dart';
import 'package:studio_booking_app/Auth/profile_setup.dart';
import 'package:studio_booking_app/Auth/sign_up.dart';
import 'package:studio_booking_app/Choice%20of%20Client/choice_of_client.dart';
import 'package:studio_booking_app/Model/user_model.dart';
import 'package:studio_booking_app/Navigator/bottom_navigator_artist.dart';
import 'package:studio_booking_app/Navigator/bottom_navigator_studio.dart';
import 'package:studio_booking_app/Shared%20Preference/shared_prefrence.dart';
import 'package:studio_booking_app/Values/constants.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

import 'email_verification.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _obscureText = true ;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  int? choice;

  @override
  void initState() {
    SharedPref sharedPref=new SharedPref();
    sharedPref.getChoiceOfClient().then((value)
    {
      setState(() {
        choice =  value;
      });
    });
    super.initState();
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
        backgroundColor: primaryColor,
        body: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(0),
          children: [
            Container(
              height: size.height*0.15,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap  : (){
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const ChoiceOfClient()),);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios,color : Colors.white),
                        Text("Back",style: TextStyle(
                          color : Colors.white,
                          fontSize: 16
                        ),)
                      ],
                    ),
                  ),
                ),
              )
            ),
            Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(18), topRight:Radius.circular(18) , bottomRight: Radius.zero , bottomLeft: Radius.zero),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height : size.height*0.07),

                       Center(child: choice == 1 ? Text("Login as Artist",style: TextStyle(
                        fontSize: 24,
                      ),) : Text("Login as Studio",style: TextStyle(
                        fontSize: 24,
                      ),)  ),

                      SizedBox(height : size.height*0.07),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Email",
                              style:  TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                              ),

                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),

                            TextFormField(
                              controller: email,
                              obscureText: false,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8),

                                  ),
                                  prefixIcon: const Icon(Icons.mail)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Email";
                                }
                                return null;
                              },
                            ),


                            SizedBox(height: size.height * 0.025,)
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Password",
                              style:  TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                              ),

                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),

                            TextFormField(
                              controller: password,
                              obscureText: _obscureText,

                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  prefixIcon: const Icon(Icons.lock ,),
                                  suffixIcon:  InkWell(
                                      onTap: ()
                                      {
                                        _toggle();
                                      },
                                      child: _obscureText ?  const Icon(Icons.visibility) : const Icon(Icons.visibility_off) )
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Password";
                                }

                                else
                                {
                                  return null;
                                }
                              },
                            ),


                            SizedBox(height: size.height * 0.02,),
                            const Align(
                                alignment: Alignment.centerRight,
                                child:  Text ("Forgot Password ?")),
                          ],
                        ),
                      ),

                      SizedBox(height : size.height *0.02),

                      InkWell(
                        onTap: ()
                        {
                          if (_formKey.currentState!.validate())
                          {
                            signIn();
                          }
                        },
                        child: Container(
                          height: size.height*0.07,
                          width: size.width*0.9,
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
                          child: const Center(child: Text("Log in",style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),),),
                        ),
                      ),

                      SizedBox(
                        height: size.height*0.05,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          const Text("Do You Have An Account ? "),
                          InkWell(
                            onTap: (){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUp()),
                              );
                            },
                            child: const  Text("Sign Up" ,style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),),
                          )
                        ],
                      ),

                      SizedBox(
                        height: size.height*0.05,
                      ),

                      choice == 1 ? Column(
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: size.width*0.13,
                                height: size.height*0.001,
                                color: Colors.grey,
                              ),
                              Text("  OR  ",style: TextStyle(
                                  color: Colors.grey
                              ),),

                              Container(
                                width: size.width*0.13,
                                height: size.height*0.001,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height*0.02,
                          ),
                          GoogleSignin(),

                        ],
                      ) : Container(),


                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }

  Future<void> signIn ()async
  {
    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
      message: 'Please Wait...',
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
      ),
    );
    try {
      pr.show();
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim()
      ).then((value) {
        print("value is $value");
        User? user =  FirebaseAuth.instance.currentUser;

        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) async {
          if(user.emailVerified == false)
          {
            pr.hide();
            Navigator.push(context,MaterialPageRoute(builder: (context) =>  EmailVerification()));
          }
          else if (!documentSnapshot.exists) {
            pr.hide();
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  ProfileSetup()));
          }
          else if (user.emailVerified && documentSnapshot.exists)
          {
            Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
            UserModel model= UserModel.fromMap(data, documentSnapshot.reference.id);
            if(choice == 1)
              {
                if(data['type'] == 'artist')
                  {
                    pr.hide();
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  BottomBarArtist(model)));
                  }
                else
                  {
                    pr.hide();
                    await FirebaseAuth.instance.signOut().then((value) =>  Toast.show("User Not Registered as Artist", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white));
                  }
              }
            else
              {
                if(data['type'] == 'studio')
                {
                  pr.hide();
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  BottomBarStudio(model)));
                }
                else
                {
                  pr.hide();
                  await FirebaseAuth.instance.signOut().then((value) =>  Toast.show("User Not Registered as Studio", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white));
                }

              }

          }
        });
        return value ;
      });

    } on FirebaseAuthException catch (e) {
      setState(() {
        pr.hide();
      });
      if (e.code == 'user-not-found') {
        Toast.show("User Not Registered", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
      } else if (e.code == 'wrong-password') {
        Toast.show("Wrong Password", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
      }
      else if (e.code == 'network-request-failed') {
        Toast.show("No Network", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
      }
      else{
        Toast.show("${e.code}", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
      }
    }
  }



}
