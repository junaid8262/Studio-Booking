import 'package:flutter/material.dart';
import 'package:studio_booking_app/Values/constants.dart';

class ReservationSummary extends StatefulWidget {
  const ReservationSummary({Key? key}) : super(key: key);

  @override
  _ReservationSummaryState createState() => _ReservationSummaryState();
}
enum paymentMethod { COD, Card }

class _ReservationSummaryState extends State<ReservationSummary> {
  paymentMethod _site = paymentMethod.COD;

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
            child: Scrollbar(
              isAlwaysShown: true,
              thickness: 5,
              radius: Radius.circular(15), // give the thumb rounded corners
              showTrackOnHover: true,
              child: ListView(
                padding: EdgeInsets.all(0),
                children: [
                  SizedBox(height : size.height*0.07),

                  const Center(child: Text("Service Summary",style: TextStyle(
                    fontSize: 24,
                  ),),),

                  SizedBox(height : size.height*0.01),

                  //date & hour
                  Container(
                      height: size.height*0.13,
                      width: double.infinity,
                      color: Colors.white,
                      child :Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(14,8,8,8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Date & Hour",style: TextStyle(
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

                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Date"),
                                      Text("21/02/2021",style: TextStyle(
                                        color: Colors.grey,
                                      ),),
                                    ],
                                  ),
                                  SizedBox(
                                    height: size.height*0.007,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Hour"),
                                      Text("10:00 Pm , 11:00 Pm",style: TextStyle(
                                        color: Colors.grey,
                                      ),),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),


                        ],
                      )
                  ),

                  //Total Amount
                  Container(
                      height: size.height*0.13,
                      width: double.infinity,
                      color: Colors.white,
                      child :Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(14,8,8,8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Total Amount",style: TextStyle(
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

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Duration",style: TextStyle(
                                        fontSize: 16,
                                      ),),
                                      Text("2h",style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16
                                      ),)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Rate/h",style: TextStyle(
                                        fontSize: 16,
                                      ),),
                                      Text("25€/h",style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16
                                      ),)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Price",style: TextStyle(
                                        fontSize: 16,
                                      ),),
                                      Text("50€",style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16
                                      ),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ],
                      )
                  ),


                  //Order Summary
                  Container(
                      height: size.height*0.19,
                      width: double.infinity,
                      color: Colors.white,
                      child :Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(14,8,8,8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Order Summary",style: TextStyle(
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

                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Sub Total",style: TextStyle(
                                          fontSize: 16
                                      ),),
                                      Text("50€",style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey
                                      ),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Service Feex",style: TextStyle(
                                          fontSize: 16
                                      ),),
                                      Text("2.5€",style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey
                                      ),)
                                    ],
                                  ),
                                  Divider(
                                    endIndent: 0,
                                    indent: 0,
                                    color: primaryColor,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Total",style: TextStyle(
                                          fontSize: 16
                                      ),),
                                      Text("52.50€",style: TextStyle(
                                        fontSize: 16,
                                      ),)
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),


                        ],
                      )
                  ),

                  // cash on site
                  Padding(
                    padding: EdgeInsets.fromLTRB(14,8,14,8.0),
                    child: Container(
                      height: size.height*0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: primaryColor)
                      ),
                      child: Center(
                        child: ListTile(
                          title: const Text('Cash On Site'),
                          trailing: Radio(
                            value: paymentMethod.COD,
                            groupValue: _site,
                            onChanged: (paymentMethod? value) {
                              setState(() {
                                _site = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  //card
                  Padding(
                    padding: EdgeInsets.fromLTRB(14,4,14,8.0),
                    child: Container(
                      height: size.height*0.08,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: primaryColor)
                      ),
                      child: Center(
                        child: ListTile(
                          title: const Text('Card Payment'),
                          trailing: Radio(
                            value: paymentMethod.Card,
                            groupValue: _site,
                            onChanged: (paymentMethod? value) {
                              setState(() {
                                _site = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  // on card payment
                  paymentMethod.COD == _site ?  Padding(
                    padding: EdgeInsets.fromLTRB(14,8,14,8.0),
                    child: Container(
                      child: Text("You are more likely that the studio will accept the session, if it is paid in advance.",style: TextStyle
                        (
                      color: Colors.red,
                    ),),),
                  )
                      : Container(
                     height: size.height*0.14,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal ,
                          itemCount: 4,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(4,8,4,8),
                              child: Container(
                                height: size.height*0.14,
                                width: size.width*0.45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.black87),
                                  image : DecorationImage(
                                    image : AssetImage("assets/images/empty.png"),
                                    fit: BoxFit.cover
                                  )

                                ),
                              ),
                            );
                          }
                      ),
                    ),

                  // place order
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14,10,14,10),
                    child: InkWell(
                      onTap: (){
                       // Navigator.push(context,MaterialPageRoute(builder: (context) =>  ReservationSummary()),);
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
                        child: const Center(child: Text("Confirm Reservation",style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),),),
                      ),
                    ),
                  ),



                ],
              ),
            ),
          ),
        ],
      ),


    );
  }
}
