// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart'  as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:studio_booking_app/Model/user_model.dart';
import 'package:studio_booking_app/Navigator/bottom_navigator_artist.dart';
import 'package:studio_booking_app/Navigator/bottom_navigator_studio.dart';
import 'package:studio_booking_app/Shared%20Preference/shared_prefrence.dart';
import 'package:studio_booking_app/Values/constants.dart';
import 'package:toast/toast.dart';

class ProfileSetup extends StatefulWidget {
  const ProfileSetup({Key? key}) : super(key: key);

  @override
  _ProfileSetupState createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController fullName = TextEditingController();
  TextEditingController artistName = TextEditingController();
  TextEditingController phoneNo = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  String? uid;

  void inputData() {
    final User? user = auth.currentUser;
    uid = user!.uid;
  }

  int? choice;


  @override
  void initState() {
    SharedPref sharedPref= SharedPref();
    sharedPref.getChoiceOfClient().then((value)
    {
      setState(() {
        choice =  value;
      });
    });
    inputData();
    super.initState();
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
        body: ListView(
          padding: EdgeInsets.all(0),
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: size.height*0.15,),
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(18), topRight:Radius.circular(18) , bottomRight: Radius.zero , bottomLeft: Radius.zero),
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height : size.height*0.07),

                      const Center(child: Text("Profile Setup",style: TextStyle(
                        fontSize: 24,
                      ),),),

                      SizedBox(height : size.height*0.025),

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

                      SizedBox(height: size.height*0.02),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Full Name",
                              style:  TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                              ),

                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),

                            TextFormField(
                              controller: fullName,
                              obscureText: false,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8),

                                  ),
                                  prefixIcon: const Icon(Icons.person_rounded)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Full Name";
                                }
                                return null;
                              },
                            ),


                            SizedBox(height: size.height * 0.025,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Artist Name",
                              style:  TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                              ),

                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),

                            TextFormField(
                              controller: artistName,
                              obscureText: false,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8),

                                  ),
                                  prefixIcon: const Icon(Icons.perm_contact_calendar_rounded)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Artist Name";
                                }
                                return null;
                              },
                            ),


                            SizedBox(height: size.height * 0.025,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Phone No",
                              style:  TextStyle(
                                  fontSize: 16,
                                  color: Colors.black
                              ),

                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),

                            TextFormField(
                              controller: phoneNo,
                              obscureText: false,
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  border:  OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(8),

                                  ),
                                  prefixIcon: const Icon(Icons.phone)
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Phone No";
                                }
                                return null;
                              },
                            ),


                            SizedBox(height: size.height * 0.035,)
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: ()
                        {
                          if (_formKey.currentState!.validate())
                          {
                            if(photoUrl.length > 0 )
                              {
                                setUserData();
                              }
                            else
                              {
                                Toast.show("Upload Profile Picture", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);

                              }
                            //  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  ProfileSetup()),);
                          }
                        },
                        child: Container(
                          height: size.height*0.07,
                          width: size.width*0.9,
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
                          child: const Center(child: Text("Register",style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),),),
                        ),
                      ),




                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }


  late File imageFiles;
  late File imagefile;
  String photoUrl="";

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


  final CollectionReference userDetails =
  FirebaseFirestore.instance.collection('users');

  Future setUserData() async {
    final ProgressDialog pr = ProgressDialog(context);
    pr.style(
      message: 'Please Wait...',
      progressWidget: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(primaryColor),
      ),
    );
    pr.show();
    User? user = FirebaseAuth.instance.currentUser;
    return await userDetails.doc(uid).set({
      "email": user!.email.toString(),
      "artistName": artistName.text.trim(),
      'profile': photoUrl,
      "fullName": fullName.text.trim(),
      "phoneNo": phoneNo.text.trim(),
      "type" : choice == 1 ? "artist" : "studio",
    }).onError((error, stackTrace) {
      pr.hide();
      Toast.show(error.toString(), context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP , textColor: primaryColor , backgroundColor: Colors.white);
    }).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        UserModel model= UserModel.fromMap(data, documentSnapshot.reference.id);
        pr.hide();
        if(choice == 1 )
        {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  BottomBarArtist(model)));
        }
        else
        {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  BottomBarStudio(model)));
        }

      });
    });

  }





}
