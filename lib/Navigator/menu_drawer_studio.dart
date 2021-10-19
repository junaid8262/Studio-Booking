import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studio_booking_app/Artist%20Screens/music_preference.dart';
import 'package:studio_booking_app/Auth/sign_in.dart';
import 'package:studio_booking_app/Model/user_model.dart';
import 'package:studio_booking_app/Studio%20Screens/my_expert.dart';
import 'package:studio_booking_app/Studio%20Screens/my_studio.dart';
import 'package:studio_booking_app/Values/constants.dart';

class MenuDrawerStudio extends StatefulWidget {
  UserModel model;

  MenuDrawerStudio(this.model);

  @override
  _MenuDrawerStudioState createState() => _MenuDrawerStudioState();
}

class _MenuDrawerStudioState extends State<MenuDrawerStudio> {

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;

  String getUid() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return uid;
  }



  void onDrawerItemClicked(String name) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.7,
      child: Drawer(
        child: Container(
          color: primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height*0.09,),

              Column(
                children: [
                  Center(
                    child:  CircleAvatar(
                      radius : 48,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar(
                        radius: 47,
                        backgroundImage: NetworkImage(widget.model.profile),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.02,
                  ),
                  Center(
                    child: Text(widget.model.fullName,style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),),
                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  Center(
                    child: Text(widget.model.phoneNo,style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),),
                  ),
                  SizedBox(
                    height: size.height*0.02,
                  ),
                  const Divider(
                    height: 1,
                    //thickness: 1,
                    endIndent: 15,
                    indent: 15,
                    color: Colors.white,
                  ),

                ],
              ),

              SizedBox(
                height: size.height*0.01,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10 ,0 ,0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyStudio()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.supervised_user_circle_outlined ,color: Colors.white,),
                      SizedBox(width: size.width*0.05,),
                      const Text("My Studio",style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: size.height*0.01,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10 ,0 ,0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyExpert()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(CupertinoIcons.rectangle_stack_person_crop ,color: Colors.white,),
                      SizedBox(width: size.width*0.05,),
                      const Text("My Experts",style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: size.height*0.01,
              ),
              Padding(
                padding:  const EdgeInsets.fromLTRB(20,10 ,0 ,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.vpn_key_outlined ,color: Colors.white,),
                    SizedBox(width: size.width*0.05,),
                    const Text("Change Password",style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),),
                  ],
                ),
              ),

              SizedBox(
                height: size.height*0.01,
              ),
              Padding(
                padding:  const EdgeInsets.fromLTRB(20,10 ,0 ,0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  MusicPreference()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.contact_support_outlined ,color: Colors.white,),
                      SizedBox(width: size.width*0.05,),
                      const Text("Help & Support",style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: size.height*0.01,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10 ,0 ,0),
                child: InkWell(
                  onTap: (){

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(CupertinoIcons.settings ,color: Colors.white,),
                      SizedBox(width: size.width*0.05,),
                      const Text("Setting",style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: size.height*0.01,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10 ,0 ,0),
                child: InkWell(
                  onTap: (){
                    _signOut().then((value) => Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  SignIn())));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.logout ,color: Colors.white,),
                      SizedBox(width: size.width*0.05,),
                      const Text("Sign Out",style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signOut() async {

    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    //await  FacebookLogin().logOut();

    // await FirebaseAuth.instance.signOut();
  }


}
