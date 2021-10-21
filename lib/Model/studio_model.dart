import 'package:cloud_firestore/cloud_firestore.dart';

class StudioModel{

  String id , title , title_image ,bio ,equipments , features , price , studio_owner_id,studio_type;
  int rating;
  List music_type,expert_id;


  StudioModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        title = map['title'],
        title_image = map['title_image'],
        bio = map['bio'],
        equipments = map['equipments'],
        features = map['features'],
        price = map['price'],
        studio_owner_id = map['studio_owner_id'],
        studio_type = map['studio_type'],
        rating = map['rating'],
        music_type = map['music_type'],
        expert_id = map['expert_id'];


  StudioModel(this.id, this.title, this.title_image, this.bio, this.equipments,
      this.features, this.price, this.studio_owner_id, this.studio_type,
      this.rating, this.music_type,this.expert_id);

  StudioModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}
