import 'package:flutter/material.dart';
import 'package:studio_booking_app/Values/constants.dart';

class MusicPreference extends StatefulWidget {
  const MusicPreference({Key? key}) : super(key: key);

  @override
  _MusicPreferenceState createState() => _MusicPreferenceState();
}

class _MusicPreferenceState extends State<MusicPreference> {

   List musicName= ['Rock','Jazz','Country','Classic','Disco','Opera', 'Funk' ,'Trance'];
   bool check = false;


   @override
 Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Scaffold(
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

              const Center(child: Text("Music Preference",style: TextStyle(
                fontSize: 24,
              ),),),

              SizedBox(height : size.height*0.04),


              Container(
                height: size.height*0.58,

                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical ,
                    itemCount: musicName.length,
                    padding: const EdgeInsets.fromLTRB(14,1,14,0),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      int choice = musicName.length+1;
/*                      print(value![3]);
                      print("lenght ${value!.length}");*/
                      return  Padding(
                        padding: const EdgeInsets.fromLTRB(7.0 , 0 , 7 , 12),
                        child: Container(
                          height: size.height*0.08,
                          width: size.width*0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black),
                            //color: Colors.grey,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25,8,8,8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(musicName[index],style: const TextStyle(
                                  fontSize: 20,
                                ),),
                                Center(
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        check = !check;
                                        //choice = index;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: check  ? Border.all(color: Colors.grey.shade700) : Border.all(color: Colors.green ),
                                          color: check ? Colors.white : Colors.green
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: check
                                              ? Icon(
                                            Icons.check,
                                            size: 15.0,
                                            color: Colors.grey.shade700,
                                          )
                                              : const Icon(
                                            Icons.check,
                                            size: 15.0,
                                            color: Colors.white,
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ) ,

              SizedBox(
                height: size.height*0.03,
              ),

              Container(
                height: size.height*0.065,
                width: size.width*0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primaryColor
                ),
                child: Center(child: Text("Continue",style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),),),
              )

            ],
          ),
        ),
      ],
    ),

  );
}
}
