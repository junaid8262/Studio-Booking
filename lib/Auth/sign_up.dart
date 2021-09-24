import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:studio_booking_app/Auth/sign_in.dart';
import 'package:studio_booking_app/Navigator/bottom_navigator.dart';
import 'package:studio_booking_app/Screens/home.dart';
import 'package:studio_booking_app/Screens/privacy_policy.dart';
import 'package:studio_booking_app/Values/constants.dart';
import 'package:toast/toast.dart';

import 'email_verification.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordC = TextEditingController();


  bool _obscureText = true ,  _obscureText2 = true  ;
  bool isCheck = false ;

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
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
        body: Column(
          children: [
            SizedBox(height: size.height*0.15,),
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

                        const Center(child: Text("Register Now",style: TextStyle(
                          fontSize: 24,
                        ),),),

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


                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Confirm Password",
                                style:  TextStyle(
                                    fontSize: 16,
                                    color: Colors.black
                                ),

                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),

                              TextFormField(
                                controller: passwordC,
                                obscureText: _obscureText2,

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
                                          _toggle2();
                                        },
                                        child: _obscureText2 ?  const Icon(Icons.visibility) : const Icon(Icons.visibility_off) )
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Password";
                                  }
                                  if(password.text != passwordC.text)
                                    {
                                      return "Password does not match";
                                    }

                                  else
                                  {
                                    return null;
                                  }
                                },
                              ),


                              SizedBox(height: size.height * 0.01,),
                                Row (
                                  mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        value: isCheck,
                                        onChanged: (value) {
                                          setState(() {
                                            isCheck = value!;
                                          });
                                        },
                                      ),
                                      InkWell(
                                          onTap: (){
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => const Privacy()),);
                                          },
                                          child: const Text("I accept the terms of use")) ,
                                    ],
                                  )
                            ],
                          ),
                        ),


                        // SizedBox(height : size.height *0.01),

                        InkWell(
                          onTap: ()
                          {
                            if (_formKey.currentState!.validate())
                              {
                                if(isCheck)
                                  {
                                    if(EmailValidator.validate(email.text.trim()))
                                      {
                                        signUp();
                                      }
                                    else
                                      {
                                        Toast.show("Email Not Valid", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
                                      }
                                  }
                                else
                                  {
                                    Toast.show("privacy Policy not Accepted", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
                                  }
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
                            child: const Center(child: Text("Register",style: TextStyle(
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
                            const Text("Already Have An Account ? "),
                            InkWell(
                              onTap: ()
                              {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignIn()),
                                );
                              },
                              child: const  Text("Sign In" ,style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),),
                            )
                          ],
                        ),
                        SizedBox(
                          height: size.height*0.03,
                        )




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


  Future<void> signUp()async {
    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
      message: 'Please Wait...',
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
      ),
    );
    try {
      pr.show();
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text.trim(),
          password: password.text.trim()
      ).then((value) => pr.hide().then((value)async => await Navigator.push(context,MaterialPageRoute(builder: (context) =>  EmailVerification()))));
    } on FirebaseAuthException catch (e) {
      setState(() {
        pr.hide();
      });
      print(e.code);
      print('hello');
      if (e.code == 'weak-password') {
        Toast.show("Weak Password", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
      } else if (e.code == 'email-already-in-use') {
        Toast.show("Email Already Exist", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
      }
      else if (e.code == 'network-request-failed') {
        Toast.show("No Network", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
      }
      else{
        Toast.show("${e.code}", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
      }

    } catch (e) {
      pr.hide();
      print(e);
    }


  }


}
