import 'dart:math';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studio_booking_app/Artist%20Screens/expert_detail.dart';
import 'package:studio_booking_app/Artist%20Screens/reservation_summary.dart';
import 'package:studio_booking_app/Model/expert_model.dart';
import 'package:studio_booking_app/Model/studio_model.dart';
import 'package:studio_booking_app/Values/constants.dart';

class ReserveStudio extends StatefulWidget {
  StudioModel model;

  ReserveStudio(this.model);

  @override
  _ReserveStudioState createState() => _ReserveStudioState();
}

class _ReserveStudioState extends State<ReserveStudio> {

  int selected = -1 ;
  List<Time> time = [];

  
  @override
  Widget build(BuildContext context) {

    final orientation = MediaQuery.of(context).orientation;
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

                const Center(child: Text("Reservation",style: TextStyle(
                  fontSize: 24,
                ),),),

                SizedBox(height : size.height*0.04),

                //Choose Engineer
                Container(
                  height: size.height*0.23,
                  width: double.infinity,
                  color: Colors.white,
                  child : Padding(
                        padding: const EdgeInsets.fromLTRB(14,8,8,8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text("Choose Your Expert",style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500
                                    ),),

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                      child: Text("(Long Tap : To View Detail)",style: TextStyle(
                                          color : Colors.grey.shade600,
                                          fontSize: 9
                                      ),),
                                    )
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Transform.rotate(
                                      angle: 180 * pi / 360,
                                      child: Icon(CupertinoIcons.chevron_up_chevron_down,color: Colors.grey,)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.00,
                            ),
                            Container(
                              height : size.height *0.15,
                              //width: double.infinity,
                              color : Colors.white,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(0,2,9,0),
                                itemCount: widget.model.expert_id.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  //ExpertModel model= ExpertModel.fromMap(data, snapshot.data!.docs[index].reference.id);

                                  return FutureBuilder<DocumentSnapshot>(
                                      future: FirebaseFirestore.instance.collection('expert').doc(widget.model.expert_id[index]).get(),
                                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                                        if (snapshot.hasError) {
                                          return Center(child: Text('Something Went Wrong',style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600
                                          ),));
                                        }

                                        if (snapshot.hasData && !snapshot.data!.exists) {
                                          return Center(child: Text('No Expert',style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600
                                          ),));
                                        }


                                        if (snapshot.connectionState == ConnectionState.waiting)
                                        {
                                          return Container();
                                        }

                                        if (snapshot.connectionState == ConnectionState.done) {
                                          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                          ExpertModel model= ExpertModel.fromMap(data, snapshot.data!.reference.id);

                                          return InkWell(
                                            onTap: (){
                                              setState(() {
                                                selected = index ;
                                              });
                                            },
                                            onLongPress : (){
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (BuildContext bc) {
                                                    return SafeArea(
                                                      child: Wrap(
                                                        children: <Widget>[
                                                          ListTile(
                                                              leading: const Icon(Icons.list_alt),
                                                              title: const Text('View Expert Detail'),
                                                              onTap: () {
                                                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>  ExpertDetail(model)));
                                                              }),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                              );
                                            },

                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(0,8,9,0),
                                              child: Column(
                                                  children : [

                                                    selected == index ? Badge(
                                                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                      badgeColor: primaryColor,
                                                      badgeContent:  Icon(Icons.done,color  :Colors.white,size: 18,),
                                                      child:CircleAvatar(
                                                        radius : 35 ,
                                                        backgroundImage: NetworkImage(data['profile']),
                                                      ),
                                                    ) : CircleAvatar(
                                                      radius : 35 ,
                                                      backgroundImage: NetworkImage(data['profile']),
                                                    ),


                                                    Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: Text(data['fullName']),
                                                    ),
                                                  ]
                                              ),
                                            ),
                                          );
                                        }

                                        return Container();
                                      }
                                  );},

                              ),
                            ),
                          ],
                        ),
                      ),

                ),

                // Select Date
                Container(
                    height: size.height*0.17,
                    width: double.infinity,
                    color: Colors.white,
                    child :Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(14,8,8,8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Select the date",style: TextStyle(
                                fontSize: 19,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500
                            ),),
                          ),
                        ),


                            Padding(
                              padding: EdgeInsets.fromLTRB(14,5,14,8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,

                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    border: Border.all(color: primaryColor),
                                    color: Colors.white,
                                  ),
                                  height: size.height*0.075,
                                  width: size.width*1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20,0,0,0),
                                        child: Center(
                                          child: Text(
                                            "${selectedDate.toLocal()}".split(' ')[0],
                                            style: TextStyle(fontSize: 14,
                                                color: Colors.black54,
                                                fontFamily: 'Montserrat Regular'),
                                          ),
                                        ),

                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 16),
                                        child: InkWell(
                                            onTap: (){
                                              _selectDate(context);
                                            },
                                            child: Icon(CupertinoIcons.calendar,color:  Colors.black54,)),
                                      )
                                    ],
                                  ),

                                ),
                              ),
                            ),


                      ],
                    )
                ),

                //find your niche
                Container(
                    height: size.height*0.22,
                    width: double.infinity,
                    color: Colors.white,
                    child :Column(
                      children: [
                         Padding(
                          padding: const EdgeInsets.fromLTRB(14,0,8,8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Find Your Niche",style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500
                                ),),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5,8,2,8),
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle
                                        ),
                                      ),
                                    ),
                                    Text("Booked"),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(5,8,2,8),
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: BoxDecoration(
                                            color: Color(0xffADBAFC),
                                            shape: BoxShape.circle
                                        ),
                                      ),
                                    ),
                                    Text("Available"),


                                    Padding(
                                      padding: const EdgeInsets.only(left :8.0),
                                      child: Transform.rotate(
                                            angle: 180 * pi / 360,
                                            child: Icon(CupertinoIcons.chevron_up_chevron_down,color: Colors.grey,)),
                                    ),

                                  ],
                                ),
                              )

                            ],
                          ),

                        ),


                        Expanded(
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            children: [
                              Container(
                                width : size.width*1,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [

                                          GestureDetector(
                                            onTap: (){
                                            },
                                            onTapCancel: (){
                                            },
                                            child: Container(
                                              height: size.height*0.04,
                                              width: size.width*0.21,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: BorderRadius.circular(14),
                                              ),
                                              child: Center(child: Text("6:00 Am",style: TextStyle(
                                                color: Colors.white,

                                              ),),),
                                            ),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("7:00 Am",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: Color(0xffADBAFC),
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("8:00 Am",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: Color(0xffADBAFC),
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("9:00 Am",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("10:00 Am",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("11:00 Am",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("12:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("1:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("2:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("3:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("4:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("5:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),

                                          ),

                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                              Container(
                                width : size.width*1,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [

                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("6:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("7:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: Color(0xffADBAFC),
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("8:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: Color(0xffADBAFC),
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("9:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("10:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("11:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("12:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,

                                          ),

                                        ],
                                      ),
                                    ),
/*
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("2:00 Am",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.circular(14),
                                            ),
                                            child: Center(child: Text("9:00 Pm",style: TextStyle(
                                              color: Colors.white,

                                            ),),),
                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,

                                          ),
                                          Container(
                                            height: size.height*0.04,
                                            width: size.width*0.21,

                                          ),

                                        ],
                                      ),
                                    ),
*/


                                  ],
                                ),
                              ),

                            ],
                          ),
                        )



                      ],
                    )
                ),

                InkWell(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  ReservationSummary()),);
                  },
                  child: Container(
                    height: size.height*0.07,
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
                    child: const Center(child: Text("checkout",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),),),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),

    );
  }

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add( Duration(days: 30)),
      builder: ( context,  child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: primaryColor,
            accentColor: primaryColor,
            colorScheme: const ColorScheme.light(primary: primaryColor),
            buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary
            ),
          ),
          child: child!,
        );
      },
      /*builder: (context, child) {
        return Theme(
          data: ThemeData., // This will change to light theme.
          child: child,
        );
      },*/
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

}


class Time{
  bool isBooked = false ;
  String time;

  Time(this.isBooked, this.time);

}