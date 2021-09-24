import 'package:flutter/material.dart';
import 'package:studio_booking_app/Values/constants.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {

  void onDrawerItemClicked(String name) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width*0.7,
      child: Drawer(
        child: Container(
          color: primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height*0.09,),
              const Center(
                child:  CircleAvatar(
                  radius : 48,
                  backgroundColor: Colors.grey,
                  child: CircleAvatar(
                    radius: 47,
                    backgroundImage: AssetImage("assets/images/empty.png",),
                  ),
                ),
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              const Center(
                child: Text("Rosina Kaur ",style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),),
              ),
              SizedBox(
                height: size.height*0.01,
              ),
              const Center(
                child: Text("+088 - 123456789",style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),),
              ),
              SizedBox(
                height: size.height*0.02,
              ),
              const Divider(
                height: 1,
                //thickness: 1,
                endIndent: 15,
                indent: 15,
                color: Colors.white,
              ),
              SizedBox(
                height: size.height*0.01,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10 ,0 ,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.account_balance_wallet_rounded ,color: Colors.white,),
                    SizedBox(width: size.width*0.05,),
                    const Text("Add Paymnet Method",style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),),
                  ],
                ),
              ),

              SizedBox(
                height: size.height*0.01,
              ),
              Padding(
                padding:  const EdgeInsets.fromLTRB(20,10 ,0 ,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.vpn_key_outlined ,color: Colors.white,),
                    SizedBox(width: size.width*0.05,),
                    const Text("Change Password",style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),),
                  ],
                ),
              ),

              SizedBox(
                height: size.height*0.01,
              ),
              Padding(
                padding:  const EdgeInsets.fromLTRB(20,10 ,0 ,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.settings ,color: Colors.white,),
                    SizedBox(width: size.width*0.05,),
                    const Text("Help & Support",style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),),
                  ],
                ),
              ),

              SizedBox(
                height: size.height*0.01,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10 ,0 ,0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.logout ,color: Colors.white,),
                    SizedBox(width: size.width*0.05,),
                    const Text("Sign Out",style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }


}
