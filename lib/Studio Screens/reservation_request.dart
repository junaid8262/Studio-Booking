import 'package:flutter/material.dart';
import 'package:studio_booking_app/Values/constants.dart';

class ReservationRequest extends StatefulWidget {
  const ReservationRequest({Key? key}) : super(key: key);

  @override
  _ReservationRequestState createState() => _ReservationRequestState();
}

class _ReservationRequestState extends State<ReservationRequest> {
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

                  const Center(child: Text("Studio Reservations",style: TextStyle(
                    fontSize: 24,
                  ),),),

                  SizedBox(height : size.height*0.07),

                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}
