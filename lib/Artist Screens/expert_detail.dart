import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:studio_booking_app/Model/expert_model.dart';
import 'package:studio_booking_app/Values/constants.dart';

class ExpertDetail extends StatefulWidget {
  ExpertModel model ;

  ExpertDetail(this.model);

  @override
  _ExpertDetailState createState() => _ExpertDetailState();
}

class _ExpertDetailState extends State<ExpertDetail> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Scaffold(
        backgroundColor: primaryColor,
        body: Column(
          children: [
            SizedBox(height: size.height*0.15,),


            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(18), topRight:Radius.circular(18) , bottomRight: Radius.zero , bottomLeft: Radius.zero),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height : size.height*0.07),

                  const Center(child: Text("Expert Profile",style: TextStyle(
                    fontSize: 24,
                  ),),),

                  //SizedBox(height : size.height*0.01),

                  Column(
                    children:  [
                      SizedBox(height: size.height*0.04,),
                      CircleAvatar(
                        radius : 48,
                        backgroundColor: Colors.grey,
                        child: CircleAvatar(
                          radius: 47,
                          backgroundImage: NetworkImage(widget.model.profile),
                        ),
                      ),


                      SizedBox(height: size.height*0.01,),
                      Text(widget.model.fullName,style: const TextStyle(
                        fontSize: 22,
                      ),),

                      RatingBar.builder(
                        ignoreGestures: true,
                        itemSize: 20,
                        initialRating: widget.model.rating.toDouble(),
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {

                        },
                      ),



                      SizedBox(
                        height: size.height*0.04,
                      ),

                      const Padding(
                        padding: EdgeInsets.fromLTRB(14,4,0,4),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("About",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                          ),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14,4,0,4),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(widget.model.about,style: const TextStyle(
                              fontSize: 17,
                              color: Colors.grey
                            ),)),
                      ),
                      SizedBox(
                        height: size.height*0.01,
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(14,4,0,4),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Specialities",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                          ),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14,4,0,4),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(widget.model.specialities,style: const TextStyle(
                                fontSize: 17,
                                color: Colors.grey
                            ),)),
                      ),



                    ],
                  ),



                ],
              ),
            ),
          ],
        ),
    );
  }
}
