import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:studio_booking_app/Values/constants.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

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
              height: MediaQuery.of(context).size.height * 0.77182,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(18), topRight:Radius.circular(18) , bottomRight: Radius.zero , bottomLeft: Radius.zero),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height : size.height*0.07),

                  const Center(child: Text("My Profile",style: TextStyle(
                    fontSize: 24,
                  ),),),

                  //SizedBox(height : size.height*0.01),

                  Column(
                    children:  [
                      SizedBox(height: size.height*0.04,),
                      const CircleAvatar(
                        radius : 48,
                        backgroundColor: Colors.grey,
                        child: CircleAvatar(
                          radius: 47,
                          backgroundImage: AssetImage("assets/images/empty.png",),
                        ),
                      ),


                      SizedBox(height: size.height*0.01,),
                      const Text("Artist Name",style: TextStyle(
                        fontSize: 22,
                      ),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RatingBar.builder(
                            itemSize: 20,
                            initialRating: 3.5,
                            minRating: 1,
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
                          const Text('4.2 (10)',style: TextStyle(
                            color: Colors.grey
                          ),),
                        ],
                      ),

                      SizedBox(
                        height: size.height*0.04,
                      ),

                      const Text('Total points earned : 5',style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),),

                      SizedBox(
                        height: size.height*0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25.0, 10 ,25,15),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  Text("Email : ",style: TextStyle(
                                    fontSize: 18,
                                  ),),
                                  Text("kkkk@gmail.com",style: TextStyle(
                                    fontSize: 18,
                                  ),)
                                ],
                              ),
                              SizedBox(height: size.height*0.01,),


                              Row(
                                children: const [
                                  Text("Name : ",style: TextStyle(
                                fontSize: 18,
                              ),),
                                  Text("Joan",style: TextStyle(
                                    fontSize: 18,
                                  ),)
                                ],
                              ),
                              SizedBox(height: size.height*0.01,),


                              Row(
                                children: const [
                                  Text("Artist Name : ",style: TextStyle(
                                    fontSize: 18,
                                  ),),
                                  Text("Tupac",style: TextStyle(
                                    fontSize: 18,
                                  ),)
                                ],
                              ),
                              SizedBox(height: size.height*0.01,),


                              Row(
                                children: [
                                  const Text("Telephone No : ",style: TextStyle(
                                    fontSize: 18,
                                  ),),
                                  const Text("06 05 0 5 0666",style: TextStyle(
                                    fontSize: 18,
                                  ),),
                                  SizedBox(height: size.height*0.01,),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

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


                    ],
                  ),

                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
