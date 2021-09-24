import 'package:flutter/material.dart';
import 'package:studio_booking_app/Navigator/menu_drawer.dart';
import 'package:studio_booking_app/Screens/studio_detail.dart';
import 'package:studio_booking_app/Values/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        drawer: MenuDrawer(),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: (){
                              _openDrawer();
                           },
                            child: Image.asset("assets/icons/drawer.png",fit: BoxFit.cover,)),

                            const Icon(Icons.notifications,color: Colors.white,),

                      ],
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
              height: size.height*0.67,
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
                            child: Container(
                              width: size.width*1,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal ,
                                  itemCount: 8,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(14.0,0, 0,0),
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context,MaterialPageRoute(builder: (context) =>  StudioDetail()),);
                                        },
                                        child: Column(
                                            children: [
                                              Container(
                                                height: size.height*0.16,
                                                width: size.height*0.16,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(color: Colors.grey),
                                                  image: const DecorationImage(
                                                    image: AssetImage('assets/images/empty.png'),
                                                    fit: BoxFit.cover,
                                                  )
                                                ),
                                              ),
                                              SizedBox(
                                                height: size.height*0.005,
                                              ),
                                              Column(
                                                children: const [
                                                  Text("Studio Name"),
                                                  Text("city"),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ),
                                    );
                                  }
                              ) ,
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
                              child: Container(
                                width: size.width*1,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical ,
                                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: (){
                                          Navigator.push(context,MaterialPageRoute(builder: (context) =>  StudioDetail()),);
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
                                                      image: const DecorationImage(
                                                        image: AssetImage("assets/images/empty.png"),
                                                        fit: BoxFit.cover
                                                      )
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: size.height*0.01,
                                                    left: size.width*0.05,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(12)
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: const [
                                                          Text("Studio Name",style: TextStyle(
                                                            fontSize: 14,
                                                          ),),
                                                          Text("city" , style: TextStyle(
                                                            fontSize: 14,
                                                          ),),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                          ),
                                        ),
                                      );
                                    }
                                ) ,
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

