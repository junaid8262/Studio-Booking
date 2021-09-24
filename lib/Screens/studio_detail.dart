import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:studio_booking_app/Values/constants.dart';


class StudioDetail extends StatefulWidget {
  const StudioDetail({Key? key}) : super(key: key);

  @override
  _StudioDetailState createState() => _StudioDetailState();
}

class _StudioDetailState extends State<StudioDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column (
          children: [
            Container(
              height: size.height*0.31,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                  image : AssetImage("assets/images/empty.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height*0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios,color: Colors.black,),
                          Text("Back",style: TextStyle(
                            color : Colors.black,
                          ),),
                        ],
                      ),

                    ),
                  ),
                  SizedBox(
                    height: size.height*0.07,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,3,8,2),
                    child: Text("Life Beauty Parlour",style: TextStyle(
                      fontSize : 24,
                      fontWeight: FontWeight.w400
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,0,8,3),
                    child: Text("Paris,France"),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(8,3,8,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBar.builder(
                          itemSize: 20,
                          initialRating: 3.5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,12,0),
                          child: Container(
                            width: size.width*0.18,
                            height : size.height*0.035,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: primaryColor,
                                gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF0681D5),
                                Color(0xFF000080),
                                /*      Color(0xff000080),
                Color(0xff104FE4),*/
                              ],
                            )
                            ),
                            child:const Center(child:Text("Reserve",style: TextStyle(
                              color : Colors.white,
                            ),)),
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Container(
              height: size.height*0.69,
              child: Container(
                child: Column(
                  children: [
                    DefaultTabController(
                        length: 3,
                        child:Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                height: size.height*0.055,
                                decoration: const  BoxDecoration(
                                  color: Colors.white,
                                    gradient:  LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF777777),
                                        Color(0xFF000000),
                                      ],
                                    )
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: TabBar(

                                    labelColor : Colors.white,

                                    unselectedLabelColor: Colors.white,

                                    indicator : BoxDecoration(
                                      color: primaryColor,
                                      gradient:  LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF0681D5),
                                        Color(0xFF000080),
                                      ],
                                    )
                                    ),

                                    /*indicator:  UnderlineTabIndicator(
                                      borderSide: BorderSide(width: 0.0,color: Colors.white),
                                      insets: EdgeInsets.symmetric(horizontal:16.0)
                              ),*/

                                    tabs:  [
                                      Tab(text: 'Description',),
                                      Tab(text: 'Gallery'),
                                      Tab(text: 'Remarks'),
                                    ],
                                  ),
                                ),
                              ),
                            ),



                            Container(
                              //height of TabBarView
                              height: MediaQuery.of(context).size.height*0.635,

                              child: TabBarView(children: <Widget>[

                                //Description
                                SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height : size.height*0.05,
                                      ),
                                        const Padding(
                                          padding: EdgeInsets.fromLTRB(14,0,14,5),
                                          child: Text("Bio",style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 20,
                                          ),),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(14,0,14,5),
                                        child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore and dolore magna aliqua.",style: TextStyle(
                                          // /fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.grey.shade600
                                        ),),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.fromLTRB(14,10,14,5),
                                        child: Text("Services",style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                        ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(14,0,14,5),
                                        child: Text("Duis aute irure dolor in reprehenderit",style: TextStyle(
                                          // /fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.grey.shade600
                                        ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(14,0,14,5),
                                        child: Text("Duis aute irure dolor in reprehenderit",style: TextStyle(
                                          // /fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.grey.shade600
                                        ),),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.fromLTRB(14,10,14,5),
                                        child: Text("Studio features",style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                        ),),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(14,0,14,5),
                                        child: Text("Duis aute irure dolor ",style: TextStyle(
                                          // /fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.grey.shade600
                                        ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(14,0,14,5),
                                        child: Text("Duis aute irure dolor  in reprehenderit ",style: TextStyle(
                                          // /fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.grey.shade600
                                        ),),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(14,0,14,5),
                                        child: Text("Duis aute irure dolor  in reprehenderit ",style: TextStyle(
                                          // /fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.grey.shade600
                                        ),),
                                      ),

                                      const Padding(
                                        padding: EdgeInsets.fromLTRB(14,10,14,5),
                                        child: Text("Equipments",style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                        ),),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(14,0,14,5),
                                        child: Text("Duis aute irure dolor ",style: TextStyle(
                                          // /fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.grey.shade600
                                        ),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(14,0,14,5),
                                        child: Text("Duis aute irure dolor  in reprehenderit ",style: TextStyle(
                                          // /fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.grey.shade600
                                        ),),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(14,0,14,5),
                                        child: Text("Duis aute irure dolor  in reprehenderit ",style: TextStyle(
                                          // /fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.grey.shade600
                                        ),),
                                      ),

                                      SizedBox(
                                        height: size.height*0.01,
                                      ),


                                    ],
                                  ),
                                ),


                                //Gallery
                                SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      children: [
                                       // SizedBox(height:size.height*0.015),

                                        ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical ,
                                            itemCount: 6,
                                            physics: const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    height: size.height*0.26,
                                                    decoration: const BoxDecoration(
                                                      image : DecorationImage(
                                                        image : AssetImage("assets/images/emptyImage.png"),
                                                        fit: BoxFit.cover
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height:size.height*0.015),
                                                ],
                                              );

                                            }),
                                      ],
                                    ),
                                  ),
                                ),


                                //Remarks
                                Container(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        //review list view builder
                                        Container(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical ,
                                              itemCount: 4,
                                              padding: EdgeInsets.fromLTRB(0, 15, 0 ,5),
                                              physics: const BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return  Container(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Padding(
                                                            padding: EdgeInsets.all(16.0),
                                                            child: CircleAvatar(
                                                              radius : 35,
                                                              backgroundColor: Colors.grey,
                                                              child: CircleAvatar(
                                                                radius: 34,
                                                                backgroundImage: AssetImage("assets/images/empty.png",),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: size.width*0.7,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,

                                                              children: [
                                                                Text("John William",style: TextStyle(
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.w400
                                                                )),
                                                                Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.fromLTRB(0,8,8,8),
                                                                      child: Text("1 day ago"),
                                                                    ),

                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: RatingBar.builder(
                                                                        itemSize: 15,
                                                                        initialRating: 3.5,
                                                                        minRating: 1,
                                                                        direction: Axis.horizontal,
                                                                        allowHalfRating: true,
                                                                        itemCount: 5,
                                                                        itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                                                        itemBuilder: (context, _) => const Icon(
                                                                          Icons.star,
                                                                          color: Colors.amber,
                                                                        ),
                                                                        onRatingUpdate: (rating) {
                                                                          print(rating);
                                                                        },
                                                                      ),
                                                                    ),

                                                                  ],
                                                                ),
                                                                Text("Contrary to popular besimp and world classlyrandom text. It has roots"),
                                                              ],
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                      Divider(
                                                        color: primaryColor,
                                                        endIndent: 20,
                                                        indent: 20,
                                                      )
                                                    ],
                                                  ),
                                                )
                                                ;

                                              }),
                                        ),

                                        //rating container
                                        Column(
                                          children: [
                                            SizedBox(
                                              height : size.height*0.02,
                                            ),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                    padding: EdgeInsets.fromLTRB(16,0,16,16),
                                                    child: Text("4.9",style: TextStyle(
                                                        fontSize: 28,
                                                        fontWeight: FontWeight.w600
                                                    ),)
                                                ),
                                                Container(
                                                  width: size.width*0.7,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,

                                                    children: [
                                                      Text("Overall Rating",style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w400
                                                      )),
                                                      Row(
                                                        children: [

                                                          Padding(
                                                            padding: const EdgeInsets.fromLTRB(0,8,8,8),
                                                            child: RatingBar.builder(
                                                              itemSize: 15,
                                                              initialRating: 3.5,
                                                              minRating: 1,
                                                              direction: Axis.horizontal,
                                                              allowHalfRating: true,
                                                              itemCount: 5,
                                                              itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                                                              itemBuilder: (context, _) => const Icon(
                                                                Icons.star,
                                                                color: Colors.amber,
                                                              ),
                                                              onRatingUpdate: (rating) {
                                                                print(rating);
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8),
                                                            child: Text("(120)"),
                                                          ),

                                                        ],
                                                      ),
                                                      Text("Service",style: TextStyle(
                                                        fontSize: 16,
                                                      ),),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0,3,0,0),
                                                        child: Text("Price",style: TextStyle(
                                                          fontSize: 16,
                                                        ),),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                            SizedBox(
                                              height : size.height*0.04,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                ),




                              ]),
                            )

                          ],

                        )
                    ),
                  ],
                ),
              ),

            ),


          ],
        ),
      ),

    );
  }
}


/*



class ServiceDetail extends StatefulWidget {

  @override
  _ServiceDetailState createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  IconData _iconData=Icons.favorite_border;
  Color _color=Colors.white;
  bool isFavourite = false;
  String? symbol,align;
  checkFavouriteFromDatabase()async{

    FirebaseFirestore.instance
        .collection('favourites')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('services')
        .doc(widget.model.id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          _iconData=Icons.favorite;
          _color=Colors.red;
          isFavourite=true;
        });
      }
    });

  }
  checkFavourite() async{
    final ProgressDialog pr = ProgressDialog(context: context);
    pr.show(max: 100, msg: "Please wait");
    if(isFavourite){
      FirebaseFirestore.instance.collection('favourites').doc(FirebaseAuth.instance.currentUser!.uid).collection("services").doc(widget.model.id).delete().then((value) {
        setState(() {
          _iconData=Icons.favorite_border;
          _color=Colors.white;
          isFavourite=false;
          pr.close();
        });
      })
          .catchError((error, stackTrace) {
        print("inner: $error");
        pr.close();

      });
    }
    else{
      FirebaseFirestore.instance.collection('favourites').doc(FirebaseAuth.instance.currentUser!.uid).collection("services").doc(widget.model.id).set({
        'serviceId': widget.model.id,
      }).then((value) {
        setState(() {
          _iconData=Icons.favorite;
          _color=Colors.red;
          isFavourite=true;
        });
        pr.close();
      })
          .catchError((error, stackTrace) {
        print("inner: $error");
        pr.close();

      });
    }


  }

  */
/* Future<File> file(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String pathName="";
    f.join(dir.path, filename);
    return File(pathName);
  }*//*




  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(

          //color:Colors.transparent.withOpacity(0.2),
            image: DecorationImage(
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                image:AssetImage("assets/images/pattern.jpg",),
                fit: BoxFit.fitHeight

            )
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: size.height*0.33,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft:Radius.circular(25) ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: widget.model.image,
                    height: size.height*0.33,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),

                Align(
                    alignment: languageCode=="US"?Alignment.centerRight:Alignment.centerLeft,
                    //align:
                    child: Container(
                      margin: EdgeInsets.only(left: 10,right: 10,top: 30),
                      child: CircleAvatar(
                        backgroundColor: lightBrown,
                        child: IconButton(
                          icon: Icon(_iconData),
                          color: _color,
                          onPressed: checkFavourite,
                        ),
                      ),
                    )
                ),
                Align(
                  alignment: languageCode=="US"?Alignment.centerLeft:Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 30),
                    child: InkWell(onTap: ()=>Navigator.pop(context),child: CircleAvatar(
                      backgroundColor: lightBrown,
                      child: Icon(Icons.arrow_back_ios_sharp,color:Colors.white,size: 25,),
                    )),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top:size.height*0.27,left: size.width*0.1,right: size.width*0.1 ),
                  decoration: BoxDecoration(
                      color: Color(0xffFFF6EC),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.Language=="English"?widget.model.name:widget.model.name_ar,style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900
                          ),
                          ),
                          IconButton(
                            icon: Icon(Icons.share_outlined),
                            onPressed: (){
                              Share.share('${widget.model.name}');
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar(
                            initialRating: widget.model.rating.toDouble(),
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                              full: Icon(Icons.star,color: darkBrown),
                              half: Icon(Icons.star_half,color: darkBrown),
                              empty:Icon(Icons.star_border,color: darkBrown,),
                            ),
                            ignoreGestures: true,
                            itemSize: 20,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          symbol==""?Container():

                          align=="Left"?Text("$symbol${widget.model.price}",style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: darkBrown
                          ),
                          ):
                          Text("${widget.model.price}$symbol",style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: darkBrown
                          ),
                          ),
                        ],
                      ),

                    ],
                  ),
                )
              ],
            ),

            SizedBox(
              height: size.height*0.02,
            ),

            DefaultTabController(
                length: 3,
                child:Column(
                  children: [
                    Container(
                      padding : EdgeInsets.all(8),
                      margin: EdgeInsets.all(8),
                      height: size.height*0.07,
                      decoration: BoxDecoration(
                        border: Border.all(color: darkBrown),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: lightBrown,
                        indicator : BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: lightBrown,
                        ),
                        */
/*indicator:  UnderlineTabIndicator(
                          borderSide: BorderSide(width: 0.0,color: Colors.white),
                          insets: EdgeInsets.symmetric(horizontal:16.0)
                      ),*//*


                        tabs: [
                          Tab(text: 'description'.tr()),
                          Tab(text: 'Gallery'.tr()),
                          Tab(text: 'Review'.tr()),
                        ],
                      ),

                    ),

                    Container(
                      //height of TabBarView
                      height: MediaQuery.of(context).size.height*0.4,

                      child: TabBarView(children: <Widget>[
                        Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.only(right: 10),
                            child: MediaQuery.removePadding(
                              removeTop: true,
                              context: context,
                              child: ListView(
                                children: [
                                  Text('serviceDescription'.tr(),style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(widget.Language=="English"?widget.model.description:widget.model.description_ar,style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w300
                                  ),
                                  ),

                                  SizedBox(height: 10,),
                                  Text('specialist'.tr(),style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height*0.15,
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance.collection('specialists')
                                          .where("serviceIds",arrayContains: widget.model.id)
                                          .snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.hasError) {
                                          return Center(
                                            child: Column(
                                              children: [
                                                Text("Something Went Wrong",style: TextStyle(color: Colors.black),)

                                              ],
                                            ),
                                          );
                                        }

                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        if (snapshot.data!.size==0){
                                          return Container(
                                              alignment: Alignment.center,
                                              child:Text('noSpecialist'.tr(),style: TextStyle(color: Colors.black),)

                                          );

                                        }
                                        print("sp size ${snapshot.data!.size}");
                                        return new ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                            return Container(
                                              height: MediaQuery.of(context).size.height*0.1,
                                              width: 80,
                                              margin: EdgeInsets.only(left: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: NetworkImage(data['image']),
                                                    fit: BoxFit.cover,
                                                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
                                                  )
                                              ),
                                              child: Container(
                                                alignment: Alignment.bottomCenter,
                                                margin: EdgeInsets.all(10),
                                                child: Text(data['name'],style: TextStyle(color: Colors.white),),
                                              ),
                                            );
                                          }).toList(),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                        Container(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('gallery').where("serviceId",isEqualTo: widget.model.id).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/wrong.png",width: 150,height: 150,),
                                      Text("Something Went Wrong")

                                    ],
                                  ),
                                );
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.data!.size==0){
                                return Container(
                                    alignment: Alignment.center,
                                    child:Text("No Pictures")

                                );

                              }
                              return new GridView(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
                                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                  //ServiceModel model= ServiceModel.fromMap(data, document.reference.id);
                                  return Container(
                                    margin: EdgeInsets.all(5),
                                    child: CachedNetworkImage(
                                      imageUrl: data['image'],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                        Container(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('reviews')
                                .where("serviceId",isEqualTo: widget.model.id)
                                .where("status",isEqualTo: "Approved").snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Column(
                                    children: [
                                      Image.asset("assets/images/wrong.png",width: 150,height: 150,),
                                      Text("Something Went Wrong")

                                    ],
                                  ),
                                );
                              }

                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (snapshot.data!.size==0){
                                return Container(
                                    alignment: Alignment.center,
                                    child:Text("No Reviews")

                                );

                              }
                              return new ListView(
                                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                                  ReviewModel model= ReviewModel.fromMap(data, document.reference.id);
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context).size.width,
                                            padding: EdgeInsets.all(10),

                                            decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10)
                                                )
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(model.username,style: TextStyle(fontWeight: FontWeight.w600),),
                                                RatingBar(
                                                  initialRating: model.rating.toDouble(),
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  ratingWidget: RatingWidget(
                                                    full: Icon(Icons.star,color: darkBrown),
                                                    half: Icon(Icons.star_half,color: darkBrown),
                                                    empty:Icon(Icons.star_border,color: darkBrown),
                                                  ),
                                                  ignoreGestures: true,
                                                  itemSize: 14,
                                                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                )
                                              ],
                                            )
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          child: Text(model.review),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),

                      ]),
                    )

                  ],

                )
            ),



          ],
        ),
      ),



    );
  }


}*/
