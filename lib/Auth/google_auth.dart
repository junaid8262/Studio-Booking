
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:studio_booking_app/Model/user_model.dart';
import 'package:studio_booking_app/Navigator/bottom_navigator_artist.dart';
import 'package:studio_booking_app/Values/constants.dart';

class GoogleSignin extends StatefulWidget {
  @override
  _GoogleSigninState createState() => _GoogleSigninState();
}

class _GoogleSigninState extends State<GoogleSignin> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final ProgressDialog pr = ProgressDialog(context);
        pr.style(
          message: 'Please Wait...',
          progressWidget: const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        );
        signInWithGoogle().then((value){
          pr.show();
            User? user=FirebaseAuth.instance.currentUser;
             FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
            "email": user.email.toString(),
            "artistName": user.displayName ?? "",
            'profile': user.photoURL ?? "",
            "fullName": user.displayName ?? "",
            "phoneNo": user.phoneNumber ?? "",
            "type" :  "artist" ,
            }).then((value) {
              UserModel model = UserModel(user.uid,user.displayName ?? "",user.displayName ?? "",user.photoURL ?? "",user.email.toString(),'artist',user.phoneNumber ?? "");
              pr.hide();
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>  BottomBarArtist(model)));

             });
        });
      },
      child: Center(
        child: Container(
            height: MediaQuery.of(context).size.height*0.07,
            child: Image.asset("assets/icons/goggle.png")),
      ),

    );

  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<Null> signOutWithGoogle() async {
    // Sign out with firebase
    await FirebaseAuth.instance.signOut();
    // Sign out with google
    await GoogleSignIn().signOut();
  }


}