import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:studio_booking_app/Model/user_model.dart';
import 'package:studio_booking_app/Values/constants.dart';

class ManagerProfile extends StatefulWidget {
  UserModel model;

  ManagerProfile(this.model);
  @override
  _ManagerProfileState createState() => _ManagerProfileState();
}

class _ManagerProfileState extends State<ManagerProfile> {

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;

  String getUid() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return uid;
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


            Container(
              height: MediaQuery.of(context).size.height * 0.775,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(18), topRight:Radius.circular(18) , bottomRight: Radius.zero , bottomLeft: Radius.zero),
                color: Colors.white,
              ),
              child:Column(
                children: [
                  SizedBox(height : size.height*0.07),

                  const Center(child: Text("My Profile",style: TextStyle(
                    fontSize: 24,
                  ),),),

                  //SizedBox(height : size.height*0.01),

                  Column(
                    children:  [
                      SizedBox(height: size.height*0.04,),
                      CircleAvatar(
                        radius : 48,
                        backgroundColor: Colors.grey,
                        child: CircleAvatar(
                          radius: 47,
                          backgroundImage: NetworkImage(widget.model.profile),
                        ),
                      ),


                      SizedBox(height: size.height*0.01,),
                      Text(widget.model.artistName,style: const TextStyle(
                        fontSize: 22,
                      ),),


                      SizedBox(
                        height: size.height*0.09,
                      ),


                      Padding(
                        padding: const EdgeInsets.fromLTRB(25.0, 10 ,0,15),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                width: size.width*0.98,
                                child: Row(
                                  children:  [
                                    const Text("Email : ",style: TextStyle(
                                      fontSize: 18,
                                    ),),
                                    Text(widget.model.email,style: const TextStyle(
                                      fontSize: 17,
                                    ),)
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 1,
                                endIndent: 20,
                              ),

                              SizedBox(height: size.height*0.01,),


                              Container(
                                width: size.width*0.98,
                                child: Row(
                                  children:  [
                                    const Text("Name : ",style: TextStyle(
                                      fontSize: 18,
                                    ),),
                                    Text(widget.model.fullName,style: const TextStyle(
                                      fontSize: 18,
                                    ),)
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 1,
                                endIndent: 20,
                              ),

                              SizedBox(height: size.height*0.01,),


                              Container(
                                width: size.width*0.98,
                                child: Row(
                                  children:  [
                                    const Text("Artist Name : ",style: TextStyle(
                                      fontSize: 18,
                                    ),),
                                    Text(widget.model.artistName,style: const TextStyle(
                                      fontSize: 18,
                                    ),)
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 1,
                                endIndent: 20,
                              ),
                              SizedBox(height: size.height*0.01,),


                              Container(
                                width: size.width*0.98,
                                child: Row(
                                  children: [
                                    const Text("Telephone No : ",style: TextStyle(
                                      fontSize: 18,
                                    ),),
                                    Text(widget.model.phoneNo,style: const TextStyle(
                                      fontSize: 18,
                                    ),),

                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey,
                                thickness: 1,
                                endIndent: 20,
                              ),

                            ],
                          ),
                        ),
                      ),

/*
                            Container(
                              width: size.width*0.9,
                              height: size.height*0.06,
                              color: Colors.grey.shade300,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex : 15,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Image.asset("assets/icons/coupon.png"),
                                      )),
                                  const Expanded(
                                      flex : 70,
                                      child: Text("My Coupon",style: TextStyle(
                                          fontSize: 16
                                      ),)),
                                  const Expanded(
                                      flex : 15,
                                      child: Icon(Icons.arrow_forward_ios_rounded)),
                                ],
                              ),
                            ),*/

                      SizedBox(height: size.height*0.01,),
                            Container(
                              width: size.width*0.9,
                              height: size.height*0.06,
                              color: Colors.grey.shade300,
                              child: Row(
                                children: const [
                                  Expanded(
                                      flex : 15,
                                      child: Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.person_outline_sharp),
                                      )),
                                  Expanded(
                                      flex : 70,
                                      child: Text("Help & Support",style: TextStyle(
                                          fontSize: 16
                                      ),)),
                                  Expanded(
                                      flex : 15,
                                      child: Icon(Icons.arrow_forward_ios_rounded)),
                                ],
                              ),
                            )


                    ],
                  )

/*
                  FutureBuilder<DocumentSnapshot>(
                    future: users.doc(getUid()).get(),
                    builder:(BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return Text("Document does not exist");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                        return Column(
                          children:  [
                            SizedBox(height: size.height*0.04,),
                            CircleAvatar(
                              radius : 48,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 47,
                                backgroundImage: NetworkImage(data['profile']),
                              ),
                            ),


                            SizedBox(height: size.height*0.01,),
                            Text(data['artistName'],style: const TextStyle(
                              fontSize: 22,
                            ),),


                            SizedBox(
                              height: size.height*0.04,
                            ),


                            SizedBox(
                              height: size.height*0.01,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25.0, 10 ,0,15),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: size.width*0.98,
                                      child: Row(
                                        children:  [
                                          const Text("Email : ",style: TextStyle(
                                            fontSize: 18,
                                          ),),
                                          Text(data['email'],style: const TextStyle(
                                            fontSize: 17,
                                          ),)
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                      endIndent: 20,
                                    ),

                                    SizedBox(height: size.height*0.01,),


                                    Container(
                                      width: size.width*0.98,
                                      child: Row(
                                        children:  [
                                          const Text("Name : ",style: TextStyle(
                                            fontSize: 18,
                                          ),),
                                          Text(data['fullName'],style: const TextStyle(
                                            fontSize: 18,
                                          ),)
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                      endIndent: 20,
                                    ),

                                    SizedBox(height: size.height*0.01,),


                                    Container(
                                      width: size.width*0.98,
                                      child: Row(
                                        children:  [
                                          const Text("Artist Name : ",style: TextStyle(
                                            fontSize: 18,
                                          ),),
                                          Text(data['artistName'],style: const TextStyle(
                                            fontSize: 18,
                                          ),)
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                      endIndent: 20,
                                    ),
                                    SizedBox(height: size.height*0.01,),


                                    Container(
                                      width: size.width*0.98,
                                      child: Row(
                                        children: [
                                          const Text("Telephone No : ",style: TextStyle(
                                            fontSize: 18,
                                          ),),
                                          Text(data['phoneNo'],style: const TextStyle(
                                            fontSize: 18,
                                          ),),

                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                      endIndent: 20,
                                    ),

                                  ],
                                ),
                              ),
                            ),

*/
/*
                            Container(
                              width: size.width*0.9,
                              height: size.height*0.06,
                              color: Colors.grey.shade300,
                              child: Row(
                                children: [
                                  Expanded(
                                      flex : 15,
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Image.asset("assets/icons/coupon.png"),
                                      )),
                                  const Expanded(
                                      flex : 70,
                                      child: Text("My Coupon",style: TextStyle(
                                          fontSize: 16
                                      ),)),
                                  const Expanded(
                                      flex : 15,
                                      child: Icon(Icons.arrow_forward_ios_rounded)),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height*0.01,),
                            Container(
                              width: size.width*0.9,
                              height: size.height*0.06,
                              color: Colors.grey.shade300,
                              child: Row(
                                children: const [
                                  Expanded(
                                      flex : 15,
                                      child: Padding(
                                        padding: EdgeInsets.all(2.0),
                                        child: Icon(Icons.person_outline_sharp),
                                      )),
                                  Expanded(
                                      flex : 70,
                                      child: Text("Support Request",style: TextStyle(
                                          fontSize: 16
                                      ),)),
                                  Expanded(
                                      flex : 15,
                                      child: Icon(Icons.arrow_forward_ios_rounded)),
                                ],
                              ),
                            )
*//*



                          ],
                        );
                      }

                      return Column(
                        children: [
                          SizedBox(height : size.height*0.3),
                          Center(child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                          ),),
                        ],
                      );
                    },
                  ),
*/


                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
