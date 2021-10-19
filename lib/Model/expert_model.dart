import 'package:cloud_firestore/cloud_firestore.dart';

class ExpertModel{

  String id , fullName ,profile  ,about ,specialities,expert_owner_id ;
  int rating;

  ExpertModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        fullName = map['fullName'],
        profile = map['profile'],
        about = map['about'],
        specialities = map['specialities'],
        expert_owner_id = map['expert_owner_id'],
        rating = map['rating'];


  ExpertModel(
      this.id, this.fullName, this.profile, this.about, this.specialities,this.expert_owner_id,this.rating);

  ExpertModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}
