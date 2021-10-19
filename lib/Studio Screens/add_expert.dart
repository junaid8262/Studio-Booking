import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:studio_booking_app/Values/constants.dart';
import 'package:firebase_storage/firebase_storage.dart'  as firebase_storage;
import 'package:toast/toast.dart';


class AddExpert extends StatefulWidget {
  const AddExpert({Key? key}) : super(key: key);

  @override
  _AddExpertState createState() => _AddExpertState();
}

class _AddExpertState extends State<AddExpert> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController speciality = TextEditingController();


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
                  thickness: 7,
                  radius: Radius.circular(15), // give the thumb rounded corners
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 5),
                    children: [

                      SizedBox(height : size.height*0.07),

                      const Center(child: Text("Add Expert",style: TextStyle(
                        fontSize: 24,
                      ),),),


                      SizedBox(height : size.height*0.02),

                      // expert profile image
                      InkWell(
                        onTap: (){
                          _showPicker(context);

                        },
                        child: photoUrl==""?const Center(
                          child:  CircleAvatar(
                            radius : 48,
                            backgroundColor: Colors.grey,
                            child: CircleAvatar(
                              radius: 47,
                              backgroundImage: AssetImage("assets/images/emptyProfile.png",),
                            ),
                          ),

                        ): Center(
                          child: CircleAvatar(
                            radius : 48,
                            backgroundColor: Colors.grey,
                            child: CircleAvatar(
                              radius: 47,
                              backgroundImage: NetworkImage(photoUrl,),
                            ),
                          ),

                        ),
                      ),

                      // name of expert
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 5, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Expert Name",
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
                              controller: name,
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

                      // expert specialties
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Specialties",
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
                              minLines: 1,
                              maxLines: 5,
                              controller: speciality,
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
                                  return "Enter Speciality";
                                }
                                return null;
                              },
                            ),

                          ],
                        ),
                      ),

                      // About expert
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "About",
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
                              controller: about,
                              minLines: 5,
                              maxLines: 6,
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


                    ],
                  ),
                )
            ),

          ),
        ],
      ),

      bottomNavigationBar: name.text.trim() != "" && photoUrl != "" && about.text.trim() != "" && speciality.text.trim() != ""? InkWell(
        onTap: (){
          addExpert().then((value) {
            Toast.show("Expert Added", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
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
              child: const Center(child: Text("Save Expert",style: TextStyle(
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
            child: const Center(child: Text("Save Expert",style: TextStyle(
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

  CollectionReference expert = FirebaseFirestore.instance.collection('expert');

  Future<void> addExpert() {
    return expert
        .doc()
        .set({
      'expert_owner_id' : getUid(),
      'fullName': name.text,
      'profile' : photoUrl,
      'about': about.text,
      'specialities': speciality.text,
      'rating' : 0 ,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }



}
