import 'package:flutter/material.dart';
import 'package:studio_booking_app/Values/constants.dart';
class Reservation extends StatefulWidget {
  const Reservation({Key? key}) : super(key: key);

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(18), topRight:Radius.circular(18) , bottomRight: Radius.zero , bottomLeft: Radius.zero),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height : size.height*0.07),

                  const Center(child: Text("My reservations",style: TextStyle(
                    fontSize: 24,
                  ),),),

                  SizedBox(height : size.height*0.01),

                  Container(
                    child: Column(
                      children: [
                        DefaultTabController(
                            length: 3,
                            child:Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.shade300,

                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TabBar(
                                        labelColor: Colors.white,
                                        unselectedLabelColor: primaryColor,
                                        indicator : BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: primaryColor,
                                        ),
                                        indicatorPadding: EdgeInsets.all(5),
                                        /*indicator:  UnderlineTabIndicator(
                                      borderSide: BorderSide(width: 0.0,color: Colors.white),
                                      insets: EdgeInsets.symmetric(horizontal:16.0)
                              ),*/

                                        tabs: const [
                                          Tab(text: 'Confirmed'),
                                          Tab(text: 'Waiting'),
                                          Tab(text: 'Past'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),



                                Container(
                                  //height of TabBarView
                                  height: MediaQuery.of(context).size.height*0.545,

                                  child: TabBarView(children: <Widget>[

                                    //approved adds
                                    ListView.builder(
                                      scrollDirection: Axis.vertical ,
                                      itemCount: 4,
                                      physics: const BouncingScrollPhysics(),
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                      itemBuilder: (context, index) {
                                        return  Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                               // crossAxisAlignment: CrossAxisAlignment.start,
                                                children:  [

                                                  Container(
                                                    height: 60,
                                                    width: 60,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(color: Colors.grey),
                                                        image: const DecorationImage(
                                                          image : AssetImage('assets/images/empty.png'),
                                                          fit: BoxFit.cover,
                                                        )
                                                    ),
                                                  ),


                                                  Column(
                                                    children: const [
                                                      Text("Studio 1",style: TextStyle(
                                                        fontSize: 18,
                                                      ),),
                                                      Text("Engineer 1"),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: const [
                                                      Text("25 Dec 2020,"),
                                                      Text("8:00 PM"),
                                                      Text("Amount \$250"),
                                                    ],
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: primaryColor,
                                                    ),
                                                    child: const Center(
                                                      child:  Padding(
                                                        padding: EdgeInsets.all(4.0),
                                                        child: Text("Payed",style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14
                                                        ),),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const Divider(
                                                height: 30,
                                                thickness: 1,
                                                color: primaryColor,
                                                endIndent: 10,
                                                indent: 10,
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  ),

                                    //pending adds
                                    ListView.builder(
                                        scrollDirection: Axis.vertical ,
                                        itemCount: 6,
                                        physics: const BouncingScrollPhysics(),
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                        itemBuilder: (context, index) {
                                          return  Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:  [

                                                    Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: Colors.grey),
                                                          image: const DecorationImage(
                                                            image : AssetImage('assets/images/empty.png'),
                                                            fit: BoxFit.cover,
                                                          )
                                                      ),
                                                    ),


                                                    Column(
                                                      children: const [
                                                        Text("Studio 1",style: TextStyle(
                                                          fontSize: 18,
                                                        ),),
                                                        Text("Engineer 1"),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: const [
                                                        Text("25 Dec 2020,"),
                                                        Text("8:00 PM"),
                                                        Text("Amount \$250"),
                                                      ],
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: primaryColor,
                                                      ),
                                                      child: const Center(
                                                        child:  Padding(
                                                          padding: EdgeInsets.all(4.0),
                                                          child: Text("Non Payed",style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12
                                                          ),),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 30,
                                                  thickness: 1,
                                                  color: primaryColor,
                                                  endIndent: 10,
                                                  indent: 10,
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                    ),


                                    //rejected adds
                                    ListView.builder(
                                        scrollDirection: Axis.vertical ,
                                        itemCount: 8,
                                        physics: const BouncingScrollPhysics(),
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                                        itemBuilder: (context, index) {
                                          return  Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                                  children:  [

                                                    Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(color: Colors.grey),
                                                          image: const DecorationImage(
                                                            image : AssetImage('assets/images/empty.png'),
                                                            fit: BoxFit.cover,
                                                          )
                                                      ),
                                                    ),


                                                    Column(
                                                      children: const [
                                                        Text("Studio 1",style: TextStyle(
                                                          fontSize: 18,
                                                        ),),
                                                        Text("Engineer 1"),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: const [
                                                        Text("25 Dec 2020,"),
                                                        Text("8:00 PM"),
                                                        Text("Amount \$250"),
                                                      ],
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: Colors.white,
                                                      ),
                                                      child: const Center(
                                                        child:  Padding(
                                                          padding: EdgeInsets.all(4.0),
                                                          child: Text("Payed",style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 14
                                                          ),),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  height: 30,
                                                  thickness: 1,
                                                  color: primaryColor,
                                                  endIndent: 10,
                                                  indent: 10,
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                    ),



                                  ]),
                                )

                              ],

                            )
                        ),
                      ],
                    ),
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


