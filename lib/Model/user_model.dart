import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{

  String id , fullName ,artistName  ,profile ,email, type , phoneNo;

  UserModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        fullName = map['fullName'],
        artistName = map['artistName'],
        profile = map['profile'],
        email = map['email'],
        type = map['type'],
        phoneNo = map['phoneNo'];


  UserModel(this.id, this.fullName, this.artistName, this.profile, this.email,
      this.type, this.phoneNo);

  UserModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}
