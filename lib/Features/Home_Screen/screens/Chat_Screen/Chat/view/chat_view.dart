
import 'package:quickai/Features/Home_Screen/screens/Chat_Screen/Chat/controller/chat_controller.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/models/msg_model.dart';
import 'package:quickai/core/styles/icons.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Chat_screen extends StatelessWidget {
  Chat_screen({Key? key, required this.msgsdata,required this.docid,required this.searchtitle}) : super(key: key){
    AssistantController controller = AssistantController(Msgs: msgsdata,userid: docid,searchtitle: searchtitle);
    Get.put(controller);

  }
  final List<msg_model> msgsdata;
  final String docid;
  final String searchtitle;








  @override
  Widget build(BuildContext context) {
    var loc=AppLocalizations.of(context);
    final size=MediaQuery.of(context).size;
    final height=size.height;
    final width=size.width;
    return GetBuilder<AssistantController>(
      builder:(con)=> Scaffold(

        appBar: AppBar(
          centerTitle: true,
          title: Text("Qubiko AI",style: TextStyle(

              fontSize: width/18
          ),),
          leading: IconButton(
            icon: Icon(
              IconBroken.Arrow___Left
            ),
            onPressed: () async {
               FocusScope.of(context).unfocus();
               await Future.delayed(Duration(milliseconds: 100)).then((value){
                 Get.back();

               });


            },
          ),
          actions: [
            InkWell(
              onTap: () {
                //Get.to(My_profile(),transition: kTransition2,duration: kTransitionDuration);

              },
              child: Padding(
                padding:  EdgeInsets.only(
                  right: width/30,
                ),
              ),
            ),
          ],
        ),
        body: FutureBuilder<void>(
          future: con.setmsgs(),
          builder:(context,snapshot)=> Container(
            decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(width/15),
                topRight: Radius.circular(width/15),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 40,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: width/40, vertical: height/220),
                    decoration:  BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(width/15),
                        topRight: Radius.circular(width/15),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(width/15),
                        topRight: Radius.circular(width/15),
                      ),
                      child: con.msgs.isEmpty?Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Lottie.asset("assets/lottie/Animation - 1701833779426.json",height: height/5),

                            Container(
                              child: SvgPicture.asset("assets/img/logogray.svg"),
                              height: height / 10,
                              width: width / 5,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: width / 200, horizontal: width / 20),
                            ),
                            Text(loc.translate("chatscreen", "title1"),style: TextStyle(
                              fontSize: width/30,
                              color: Colors.black38,
                            ),),
                            SizedBox(height: height/80,),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(width/30)
                              ),
                              child: Text(loc.translate("chatscreen", "title2"),style: TextStyle(
                                fontSize: width/30,
                                color: Colors.black38,
                              ),),
                              height: height / 8,
                              width: width ,
                              alignment: Alignment.center,
                            ),
                            SizedBox(height: height/80,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(width/30)
                              ),
                              child: Text(loc.translate("chatscreen", "title3"),style: TextStyle(
                                fontSize: width/30,
                                color: Colors.black38,
                              ),),
                              height: height / 8,
                              width: width ,
                              alignment: Alignment.center,
                            ),


                          ],


                        ),

                      ):GlowingOverscrollIndicator(
                        axisDirection: AxisDirection.down,
                        color: ColorsManager.purble2.withOpacity(.009),

                        child: ListView.builder(
                            controller:con.scrollController,

                            reverse: false,
                            padding: const EdgeInsets.only(top: 15),
                            itemCount: con.msgs.length,
                            itemBuilder: (context, index) =>


                            con.msgs[index].sender!="me"?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Expanded(
                                      child: Align(
                                        alignment:
                                        Alignment.topLeft,
                                        child: Container(
                                          margin:  EdgeInsets.all(width/60),
                                          padding:  EdgeInsets.all(width/20),
                                          decoration: BoxDecoration(
                                            color:Colors.grey.shade200,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(width/30),topLeft: Radius.circular(width/120),bottomLeft:Radius.circular(width/30) ,bottomRight: Radius.circular(width/30)),
                                          ),
                                          child: Text(
                                            con.msgs[index].textmsg,
                                            style: const TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(

                                          child: IconButton(onPressed: (){
                                            con.copyToClipboard(index);
                                          },
                                              icon: Icon(Icons.copy,size: width/25,color: Colors.grey.shade500,)),
                                        ),
                                        Container(

                                          child: IconButton(onPressed: (){
                                            con.sharemsgto(index);
                                          },
                                              icon: Icon(Icons.share,size: width/25,color: Colors.grey.shade500,)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )

                                :

                            index==con.msgs.length.toInt()-1?
                            Column(
                              children: [
                                Align(
                                  alignment:
                                  Alignment.topRight ,
                                  child: Container(
                                    margin:  EdgeInsets.all(width/60),
                                    padding:  EdgeInsets.all(width/20),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(39, 29, 103, 1),
                                      borderRadius:BorderRadius.only( topRight: Radius.circular(width/30),topLeft: Radius.circular(width/30),bottomLeft:Radius.circular(width/30) ,bottomRight: Radius.circular(width/120)),
                                    ),
                                    child: Text(
                                      con.msgs[index].textmsg,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment:
                                  Alignment.topLeft,
                                  child: Container(
                                    margin:  EdgeInsets.all(width/60),
                                    padding:  EdgeInsets.all(width/20),
                                    decoration: BoxDecoration(
                                      color:Colors.grey.shade200,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(width/30),topLeft: Radius.circular(width/120),bottomLeft:Radius.circular(width/30) ,bottomRight: Radius.circular(width/30)),
                                    ),
                                    child: Lottie.asset("assets/img/Animation - 1703111120002.json",height: height/35,width: width/4)
                                  ),
                                ),
                              ],
                            )


                                :
                            Align(
                              alignment:
                              Alignment.topRight ,
                              child: Container(
                                margin:  EdgeInsets.all(width/60),
                                padding:  EdgeInsets.all(width/20),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(39, 29, 103, 1),
                                  borderRadius:BorderRadius.only( topRight: Radius.circular(width/30),topLeft: Radius.circular(width/30),bottomLeft:Radius.circular(width/30) ,bottomRight: Radius.circular(width/120)),
                                ),
                                child: Text(
                                  con.msgs[index].textmsg,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )

                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(width / 30),
                  decoration: BoxDecoration(


                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right:width / 30),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(width / 30),),
                          width: width/3,
                          child: Row(
                            children: [
                              Container(
                                child: SvgPicture.asset("assets/img/logo.svg"),
                                height: height / 15,
                                width: width / 25,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(vertical: width / 200, horizontal: width / 20),
                              ),
                              Expanded(
                                child: TextField(
                                  cursorColor: ColorsManager.purble2,
                                  controller: con.msgController,
                                  decoration: InputDecoration(
                                    hintText: loc.translate("chatscreen", "tfieldhint"),
                                    hintStyle: TextStyle(
                                      color: Colors.black54
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [ColorsManager.burble,ColorsManager.purble2]
                          )
                        ),
                        child: IconButton(
                          onPressed: con.sendMsg,
                          icon: Icon(Icons.send, color: ColorsManager.white),
                        ),
                      ),
                    ],
                  ),
                ),

              ],

            ),
          ),
        ),
      ),
    );
  }
}
