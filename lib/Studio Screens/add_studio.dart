import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:studio_booking_app/Artist%20Screens/expert_detail.dart';
import 'package:studio_booking_app/Model/expert_model.dart';
import 'package:studio_booking_app/Studio%20Screens/add_expert.dart';
import 'package:studio_booking_app/Values/constants.dart';
import 'package:firebase_storage/firebase_storage.dart'  as firebase_storage;
import 'package:toast/toast.dart';

import 'home_studio.dart';

class AddStudio extends StatefulWidget {
  const AddStudio({Key? key}) : super(key: key);

  @override
  _AddStudioState createState() => _AddStudioState();
}

class _AddStudioState extends State<AddStudio> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController features = TextEditingController();
  TextEditingController equipments = TextEditingController();
  TextEditingController price = TextEditingController();

  int studioType = 0  ;
  bool jazz = false , country = false , rock = false , pop = false , classic = false;
  List<Expert> expert = [];
  int? lenghtExpert = 0 ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        children: [
          Container(
              height: size.height*0.15,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap  : (){
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios,color : Colors.white),
                        Text("Back",style: TextStyle(
                            color : Colors.white,
                            fontSize: 16
                        ),)
                      ],
                    ),
                  ),
                ),
              )
          ),

          Container(
            height: MediaQuery.of(context).size.height * 0.755,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(18), topRight:Radius.circular(18) , bottomRight: Radius.zero , bottomLeft: Radius.zero),
              color: Colors.white,
            ),
            child:  Form(
                    key: _formKey,
                    child:  Scrollbar(
                      isAlwaysShown: false,
                      thickness: 7,
                      radius: Radius.circular(15), // give the thumb rounded corners
                      showTrackOnHover: true,
                      child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 5),
                      children: [

                        SizedBox(height : size.height*0.07),

                        const Center(child: Text("Add Studio",style: TextStyle(
                          fontSize: 24,
                        ),),),


                        SizedBox(height : size.height*0.02),

                        // image
                        InkWell(
                          onTap: (){
                            _showPicker(context);
                          },
                          child: photoUrl == "" ? Container (
                            height : size.height*0.2,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black54),
                              image: DecorationImage(
                                image: AssetImage("assets/images/empty.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Icon(Icons.add_circle_outline_outlined,color: Colors.black54,),
                                ),
                                Text("Add Image",style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                    fontSize: 20
                                ),)
                              ],
                            ),
                          ) :
                          Container (
                            height : size.height*0.2,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black54),
                              image: DecorationImage(
                                image: NetworkImage(photoUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ) ,
                        ),

                        // title
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 5, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Title",
                                style:  TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  fontWeight: FontWeight.w500
                                ),

                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),

                              TextFormField(
                                controller: title,
                                obscureText: false,
                                decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    border:  OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(4),

                                    ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Email";
                                  }
                                  return null;
                                },
                              ),

                            ],
                          ),
                        ),


                        SizedBox(height : size.height*0.02),

                        // music type
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.fromLTRB(5,0,5,0),
                                child: Text(
                                  "Music Type",
                                  style:  TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500
                                  ),

                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),

                              // music Type
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      // jazz
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,8,8,8,),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              jazz = !jazz;
                                            });
                                          },
                                          child: jazz == true ?   Container(
                                            height: size.height*0.06,
                                            width: size.width*0.3,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(color: Colors.white),
                                                color: primaryColor
                                            ),
                                            child: Center(child: Text("Jazz",style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16
                                            ),)),
                                          ) :
                                          Container(
                                            height: size.height*0.06,
                                            width: size.width*0.3,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4),
                                              border: Border.all(color: Colors.black87)
                                            ),
                                            child: Center(child: Text("Jazz",style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black87,
                                              fontSize: 16
                                            ),)),
                                          ),
                                        ),
                                      ),

                                      //Country
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              country = !country ;
                                            });
                                          },
                                          child: country == true ?  Container(
                                            height: size.height*0.06,
                                            width: size.width*0.3,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(color: Colors.white),
                                                color : primaryColor,
                                            ),
                                            child: Center(child: Text("Country",style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16
                                            ),)),
                                          ) :
                                          Container(
                                            height: size.height*0.06,
                                            width: size.width*0.3,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(color: Colors.black87)
                                            ),
                                            child: Center(child: Text("Country",style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: 16
                                            ),)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      //rock
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,8,8,8,),
                                        child: InkWell(
                                          onTap :(){
                                            setState(() {
                                              rock  = !rock ;
                                            });
                                          },
                                          child: rock == true ? Container(
                                            height: size.height*0.06,
                                            width: size.width*0.3,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(color: Colors.white),
                                                color : primaryColor,
                                            ),
                                            child: Center(child: Text("Rock",style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16
                                            ),)),
                                          ) :
                                          Container(
                                            height: size.height*0.06,
                                            width: size.width*0.3,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(color: Colors.black87)
                                            ),
                                            child: Center(child: Text("Rock",style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: 16
                                            ),)),
                                          ),
                                        ),
                                      ),

                                      //pop
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              pop = !pop ;
                                            });
                                          },
                                          child: pop == true ?  Container(
                                            height: size.height*0.06,
                                            width: size.width*0.2,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(color: Colors.white),
                                                color : primaryColor,
                                            ),
                                            child: Center(child: Text("Pop",style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16
                                            ),)),
                                          ) :
                                          Container(
                                            height: size.height*0.06,
                                            width: size.width*0.2,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(color: Colors.black87)
                                            ),
                                            child: Center(child: Text("Pop",style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: 16
                                            ),)),
                                          ),
                                        ),
                                      ),

                                      //classic
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              classic = !classic ;
                                            });
                                          },
                                          child: classic == true ? Container(
                                            height: size.height*0.06,
                                            width: size.width*0.3,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(color: Colors.white),
                                                color: primaryColor,
                                            ),
                                            child: Center(child: Text("Classic",style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 16
                                            ),)),
                                          ) :
                                          Container(
                                            height: size.height*0.06,
                                            width: size.width*0.3,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(color: Colors.black87)
                                            ),
                                            child: Center(child: Text("Classic",style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: 16
                                            ),)),
                                          ),
                                        ),
                                      ),


                                    ],
                                  )
                                ],
                              ),





                            ],
                          ),
                        ),

                        SizedBox(height : size.height*0.02),

                        //Studio Type
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.fromLTRB(5,0,5,0),
                                child: Text(
                                  "Studio Type",
                                  style:  TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500
                                  ),

                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),

                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0,8,8,8,),
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          studioType = 1 ;
                                        });
                                      },
                                      child: studioType == 1 ? Container(
                                        height: size.height*0.06,
                                        width: size.width*0.35,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: Colors.white),
                                          color : primaryColor,

                                        ),
                                        child: Center(child: Text("Home Studio",style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color:  Colors.white,
                                            fontSize: 16
                                        ),)),
                                      ) :
                                      Container(
                                        height: size.height*0.06,
                                        width: size.width*0.35,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: Colors.black87)
                                        ),
                                        child: Center(child: Text("Home Studio",style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                            fontSize: 16
                                        ),)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          studioType = 2 ;
                                        });
                                      },
                                      child: studioType == 2 ?    Container(
                                        height: size.height*0.06,
                                        width: size.width*0.42,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: Colors.white),
                                            color : primaryColor,
                                        ),
                                        child: Center(child: Text("Recording Studio",style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 16
                                        ),)),
                                      ):
                                      Container(
                                        height: size.height*0.06,
                                        width: size.width*0.42,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(color: Colors.black87)
                                        ),
                                        child: Center(child: Text("Recording Studio",style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                            fontSize: 16
                                        ),)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),

                        // bio
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 5, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Bio",
                                style:  TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500
                                ),

                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),

                              TextFormField(
                                controller: bio,
                                minLines: 1,
                                maxLines: 5,
                                obscureText: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4),


                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Email";
                                  }
                                  return null;
                                },
                              ),

                            ],
                          ),
                        ),

                        //studio features
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 7, 5, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Studio Features",
                                style:  TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500
                                ),

                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),

                              TextFormField(
                                controller: features,
                                minLines: 1,
                                maxLines: 5,
                                obscureText: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4),


                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Email";
                                  }
                                  return null;
                                },
                              ),

                            ],
                          ),
                        ),

                        //equipment
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 7, 5, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Equipments",
                                style:  TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500
                                ),

                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),

                              TextFormField(
                                controller: equipments,
                                minLines: 1,
                                maxLines: 5,
                                obscureText: false,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4),


                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Email";
                                  }
                                  return null;
                                },
                              ),

                            ],
                          ),
                        ),

                        //price
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "Price/hour",
                                style:  TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500
                                ),

                              ),
                              SizedBox(
                                height: size.height * 0.005,
                              ),

                              Container(
                                width: size.width*0.45,
                                child: TextFormField(
                                  controller: price,
                                  minLines: 1,
                                  keyboardType: TextInputType.number,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      borderSide: const BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    border:  OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(4),


                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Price";
                                    }
                                    return null;
                                  },
                                ),
                              ),

                            ],
                          ),
                        ),


                        // add engineer
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Studio Expert",
                                        style:  TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500
                                        ),

                                      ),

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(8,0,8,0),
                                        child: Text("(Long Press : To View Detail)",style: TextStyle(
                                            color : Colors.grey.shade600,
                                          fontSize: 12
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
                                height: size.height * 0.01,
                              ),
                              Container(
                                height : size.height *0.15,
                                //width: double.infinity,
                                color : Colors.white,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('expert').where("expert_owner_id" , isEqualTo: getUid()).snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

                                    if (snapshot.hasError) {
                                      return  Column(
                                        children: [
                                          SizedBox(height : 20),
                                          const Center(child: Text('Something Went Wrong',style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600
                                          ),)),
                                        ],
                                      );
                                    }

                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Column(
                                        children: [
                                          SizedBox(height : 20),
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
                                          SizedBox(height : 10),
                                          InkWell(
                                            onTap : (){
                                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AddExpert()));
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const[
                                                 Center(child: Text('Add Expert',style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w600
                                                ),)),

                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Icon(Icons.add_circle_outline_outlined,color : Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      );


                                    }

                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.fromLTRB(0,2,9,0),
                                      itemCount: snapshot.data?.docs.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        Map<String, dynamic> data = snapshot.data!.docs[index].data()! as Map<String, dynamic>;
                                        ExpertModel model= ExpertModel.fromMap(data, snapshot.data!.docs[index].reference.id);
                                        Expert expert1 = Expert(false, snapshot.data!.docs[index].reference.id);
                                        expert.add(expert1);
                                        lenghtExpert = snapshot.data!.docs.length;
                                        return InkWell(
                                          onTap : (){
                                            setState(() {
                                              expert[index].isCheck = !expert[index].isCheck ;
                                              expert[index].id = snapshot.data!.docs[index].reference.id ;
                                            });
                                          },
                                          onLongPress: (){
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
                                                  expert[index].isCheck ?
                                                   Badge(
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
                                      },

                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),



                      ],
                    ),
                    )
                  ),
            
          ),
        ],
      ),

      bottomNavigationBar: title.text.trim() != "" && bio.text.trim() != "" && equipments.text.trim() != ""&& features.text.trim() != "" && price.text.trim() != ""
          && studioType != 0  && (jazz == true  || country == true || rock == true || pop == true || classic == true ) && photoUrl != "" && expertList().isNotEmpty ? InkWell(
        onTap: (){
          addStudio().then((value) {
            Toast.show("Studio Added", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
            Navigator.pop(context);
          }
          );
        },
            child: Container(
        height: size.height*0.095,
        width: double.infinity,
        color: Colors.white,
        child: Center(
            child: Container(
              height: size.height*0.07,
              width: size.width*0.9,
              decoration: BoxDecoration(
                color: primaryColor,
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(4)
              ),
                child: const Center(child: Text("Next",style: TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ) ,),),
            ),
        ),
      ),
          ) :
       Container(
          height: size.height*0.095,
          width: double.infinity,
          color: Colors.white,
          child: Center(
            child: Container(
              height: size.height*0.07,
              width: size.width*0.9,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4)
              ),
              child: const Center(child: Text("Next",style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
              ) ,),),
            ),
          ),
      ) ,

    );
  }
  late File imageFiles;
  late File imagefile;
  String photoUrl="";
  final FirebaseAuth auth = FirebaseAuth.instance;

  String getUid() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return uid;
    // here you write the codes to input the data into firestore
  }


  Future uploadImageToFirebase(BuildContext context) async {
    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
      message: 'Please Wait...',
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
      ),
    );
    await pr.show();
    firebase_storage.Reference firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref().child('uploads/${DateTime.now().millisecondsSinceEpoch}');
    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(imagefile);
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) {
        photoUrl=value;
        print("value $value");
        setState(() {
          pr.hide();
        });

      },
    ).onError((error, stackTrace){
      Toast.show(error.toString(), context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
    });
  }

  void fileSet(File file){
    setState(() {
      if(file!=null){
        imagefile=file;
      }
    });
    uploadImageToFirebase(context);
  }
  Future<void> _chooseGallery() async => await ImagePicker().getImage(source: ImageSource.gallery).then((value) =>  fileSet(File(value!.path)));
  Future<void> _choosecamera() async => await ImagePicker().getImage(source: ImageSource.camera).then((value) => fileSet(File(value!.path)));

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _chooseGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _choosecamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  CollectionReference studio = FirebaseFirestore.instance.collection('studio');

  Future<void> addStudio() {
    return studio
        .doc()
        .set({
      'studio_owner_id' : getUid(),
      'title': title.text,
      'title_image' : photoUrl,
      'bio': bio.text,
      'features' : features.text,
      'equipments' : equipments.text,
      'price' : price.text,
      'rating' : 0,
      'studio_type' : studioType == 1 ? "Home Studio" : "Recording Studio" ,
      'music_type' : FieldValue.arrayUnion(musicTypes()),
      'expert_id' : FieldValue.arrayUnion(expertList()),
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }


  List<String> expertList()  {
    List<String> expertT = [];

    for (int i = 0 ; i <= lenghtExpert!;i++)
      {
        if(expert[i].isCheck)
          {
            expertT.add(expert[i].id);
          }
      }
    return expertT;
  }

  List<String> musicTypes()  {
    List<String> musicT = [];
    if (jazz == true)
      {
        musicT.add('Jazz');
      }
    if (country == true)
      {
        musicT.add('Country');
      }
    if (rock == true)
      {
        musicT.add('rock');
      }
    if(pop == true)
      {
        musicT.add('Pop');
      }
    if(classic == true)
      {
        musicT.add("Classic");
      }
      musicT.sort();
      return musicT;

  }


}


class Expert{
  bool isCheck = false ;
  String id;

  Expert(this.isCheck, this.id);

}