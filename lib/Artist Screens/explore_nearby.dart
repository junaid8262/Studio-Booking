import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:studio_booking_app/Values/constants.dart';

class NearbyStudio extends StatefulWidget {
  const NearbyStudio({Key? key}) : super(key: key);

  @override
  _NearbyStudioState createState() => _NearbyStudioState();
}

class _NearbyStudioState extends State<NearbyStudio> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
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


          Container(
            height:  size.height * 0.15,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12,6,12,16),
              child: Align(
                alignment: Alignment.bottomCenter,
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
            ),

          ),

          Container(
            height: size.height * 0.775,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(18), topRight:Radius.circular(18) , bottomRight: Radius.zero , bottomLeft: Radius.zero),
              color: Colors.white,
            ),

            child:  ClipRRect(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(18), topRight:Radius.circular(18) , bottomRight: Radius.zero , bottomLeft: Radius.zero),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),

          ),
        ],
      ),

    ),
  );
}
}
