import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:studio_booking_app/Model/studio_model.dart';
import 'package:studio_booking_app/Model/user_model.dart';
import 'package:studio_booking_app/Navigator/menu_drawer_artist.dart';
import 'package:studio_booking_app/Artist%20Screens/studio_detail.dart';
import 'package:studio_booking_app/Values/constants.dart';

class HomeArtist extends StatefulWidget {
 UserModel model;

 HomeArtist(this.model);

  @override
  _HomeArtistState createState() => _HomeArtistState();
}

class _HomeArtistState extends State<HomeArtist> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  void _openDrawer () {
    _drawerKey.currentState!.openDrawer();
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

    return  WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        drawer: MenuDrawerArtist(widget.model),
        key: _drawerKey,
        body: Column(
          children: [
            Container(
              height: size.height*0.25,
              color: primaryColor,
              child: Column(
                children: [
                  SizedBox(height: size.height*0.06,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12,0,12,0),
                    child:Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                          onTap: (){
                            _openDrawer();
                          },
                          child: Image.asset("assets/icons/drawer.png",fit: BoxFit.cover,)),
                    ),
                  ),
                  SizedBox(height: size.height*0.02,),
                  const Padding(
                    padding:  EdgeInsets.fromLTRB(12,0,12,0),
                    child:  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Find your best studio",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),),
                    ),
                  ),
                  const Padding(
                    padding:  EdgeInsets.fromLTRB(12,0,12,0),
                    child:  Align(
                      alignment: Alignment.topLeft,
                      child: Text("The app for those who live in music",style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12,6,12,0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: size.height*0.05,
                        width: size.width*0.7,
                        color: backgroundColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("Paris"),
                              Icon(Icons.search,color: Colors.grey,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )


                ],
              ),
            ),

            Container(
              height: size.height*0.675,
              child: Column(
                children: [
                  Expanded(
                    flex: 23,
                      child: Container(
                        child: ListView.builder(
                              scrollDirection: Axis.horizontal ,
                              itemCount: 8,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: size.height*0.08,
                                        width: size.width*0.2,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          border: Border.all(color: Colors.grey),
                                          image: const DecorationImage(
                                              image: AssetImage("assets/images/empty.png"),
                                            fit: BoxFit.cover
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: size.height*0.009,),
                                      const Text("Mixing"),
                                    ],
                                  ),
                                );
                              }
                        ),
                  )),
                  Expanded(
                      flex: 40,
                      child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            flex : 17,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14,0,0,0),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: const Text("Popular studios",style: TextStyle(
                                  fontSize: 20,
                                ),),
                              ),
                            ),
                          ),
                          Expanded(
                            flex : 83,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection('studio').snapshots(),
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
                                  );;
                                }

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Column(
                                    children: [
                                      Center(child: CircularProgressIndicator(
                                        valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                                      ),),
                                    ],
                                  );
                                }

                                if(snapshot.data!.size == 0)
                                {
                                  return Column(
                                    children: [
                                      const Center(child: Text('No Studio',style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600
                                      ),)),
                                    ],
                                  );


                                }

                                return ListView(
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.fromLTRB(9,0,9,0),
                                  shrinkWrap: true,
                                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                    StudioModel model= StudioModel.fromMap(data, document.reference.id);
                                    return Padding(
                                        padding: const EdgeInsets.fromLTRB(5,0,3,0),
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.push(context,MaterialPageRoute(builder: (context) =>  StudioDetail(model)),);
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: size.height*0.16,
                                                width: size.width*0.55,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(color: Colors.grey),
                                                    image:  DecorationImage(
                                                      image: NetworkImage(data['title_image']),
                                                      fit: BoxFit.cover,
                                                    )
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height*0.005,
                                              ),
                                              Column(
                                                children:  [
                                                  Text(data['title']),
                                                  Text(data['studio_type']),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                  }).toList(),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      ),
                  ),
                  Expanded(
                      flex: 37,
                      child: Container(
                        width: size.height*1,
                        child: Column(
                          children: [
                            Expanded(
                              flex : 17,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(14,0,0,0),
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text("All Studios",style: TextStyle(
                                    fontSize: 20,
                                  ),),
                                ),
                              ),
                            ),

                            Expanded(
                              flex : 83,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('studio').snapshots(),
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
                                    );;
                                  }

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Column(
                                      children: [
                                        Center(child: CircularProgressIndicator(
                                          valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
                                        ),),
                                      ],
                                    );
                                  }

                                  if(snapshot.data!.size == 0)
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

                                  return ListView(
                                    physics: BouncingScrollPhysics(),
                                    padding: EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                      StudioModel model= StudioModel.fromMap(data, document.reference.id);
                                      return InkWell(
                                        onTap: (){
                                          Navigator.push(context,MaterialPageRoute(builder: (context) =>  StudioDetail(model)),);
                                          print(document.reference.id);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(0,0,0,12),
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: size.height*0.2,
                                                  width: size.width*0.93,
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
                                                  child: Container(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children:  [
                                                        Text(data['title'],style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.w700
                                                        ),),


                                                        Text(data['studio_type'] , style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white

                                                        ),),

                                                        Text(data['price']+'€ Per/h',style: TextStyle(
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
                                                            print(rating);
                                                          },
                                                        ),


                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                },
                              ),

                            )
                          ],
                        ),
                      )),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

