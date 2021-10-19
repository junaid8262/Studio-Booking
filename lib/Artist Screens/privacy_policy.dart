import 'package:flutter/material.dart';
import 'package:studio_booking_app/Values/constants.dart';

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
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
            child: Column(
              children: [
                SizedBox(height : size.height*0.07),

                const Center(child: Text("Privacy & Policy",style: TextStyle(
                  fontSize: 24,
                ),),),

                SizedBox(height : size.height*0.07),

              ],
            ),
          ),
        ],
      ),

    );
  }
}
