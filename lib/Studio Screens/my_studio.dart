import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:studio_booking_app/Artist%20Screens/studio_detail.dart';
import 'package:studio_booking_app/Model/studio_model.dart';
import 'package:studio_booking_app/Studio%20Screens/add_studio.dart';
import 'package:studio_booking_app/Values/constants.dart';

class MyStudio extends StatefulWidget {

  @override
  _MyStudioState createState() => _MyStudioState();
}

class _MyStudioState extends State<MyStudio> {


  final FirebaseAuth _auth = FirebaseAuth.instance;


  String getUid() {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    return uid;
    // here you write the codes to input the data into firestore
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          SizedBox(
              height: size.height*0.15,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap  : (){
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: const[
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
          Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(18), topRight:Radius.circular(18) , bottomRight: Radius.zero , bottomLeft: Radius.zero),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(height : size.height*0.037),

                const Center(child: Text("My Studios",style: TextStyle(
                  fontSize: 24,
                ),),),


                Expanded(
                  child: Scrollbar(
                      isAlwaysShown: true,
                      thickness: 5,
                      radius: const Radius.circular(15), // give the thumb rounded corners
                      showTrackOnHover: true,
                      child: ListView(
                    padding: const EdgeInsets.all(0),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(height : size.height*0.03),

                      //add studio button
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AddStudio()));

                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                          height: size.height*0.065,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: const [
                              Expanded(
                                flex : 63 ,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Add Studio",style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600
                              ),),
                                ),),
                              Expanded(
                                flex:37,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Icon(Icons.add,color: Colors.white,),
                                    )),

                              )
                            ],
                          ),


                        ),
                      ),


                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('studio').where('studio_owner_id' , isEqualTo: getUid()).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                            if (snapshot.hasError) {
                              return  Column(
                                children: [
                                  SizedBox(height : size.height*0.3),
                                  const Center(child: Text('Something Went Wrong',style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600
                                  ),)),
                                ],
                              );
                            }

                            else if (snapshot.connectionState == ConnectionState.waiting) {
                              return Column(
                                children: [
                                  SizedBox(height : size.height*0.3),
                                  const Center(child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                                  ),),
                                ],
                              );
                            }

                            else if(snapshot.data!.size == 0)
                              {
                                return Column(
                                  children: [
                                    SizedBox(height : size.height*0.3),
                                  const Center(child: Text('No Studio',style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600
                                  ),)),
                                   ],
                                );


                              }
                            else
                              {
                                return ListView(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                    StudioModel model= StudioModel.fromMap(data, document.reference.id);
                                    return InkWell(
                                      onTap: (){
                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>  StudioDetail(model)),);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0,0,0,12),
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: size.height*0.2,
                                                width: size.width*0.85,
                                                decoration:  BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    border: Border.all(color : Colors.grey),
                                                    image: DecorationImage(
                                                      image: NetworkImage(data['title_image']),
                                                      fit: BoxFit.cover,
                                                    )
                                                ),

                                              ),
                                              Positioned(
                                                top: size.height*0.01,
                                                left: size.width*0.03,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:  [
                                                    Text(data['title'],style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w700
                                                    ),),


                                                    Text(data['studio_type'] , style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white

                                                    ),),

                                                    Text(data['price']+'€ Per/h',style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w700
                                                    ),),

                                                    RatingBar.builder(
                                                      unratedColor: Colors.white60,
                                                      ignoreGestures: true,
                                                      itemSize: 15,
                                                      initialRating: data['rating'].toDouble(),
                                                      minRating: 0,
                                                      direction: Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                                      itemBuilder: (context, _) => const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {

                                                      },
                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );

                              }

                           },
                      ),


                    ],
                  )
                  )
                )

              ],
            ),
          ),
        ],
      ),

    );
  }
}

