import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/manager/colors_manager.dart';
import '../../../../../core/styles/icons.dart';
import '../../../../../widgets/scroll_behavior.dart';
import '../controller/faqscontroller.dart';
class Faqsscreen extends StatelessWidget {
  Faqsscreen({Key? key}) : super(key: key);
  static const scid="/faqsscreen";

  FaqsController controller=Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FaqsController>(
      builder:(con)=> Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: height/60),
              padding: EdgeInsets.symmetric(horizontal: width/40),
              height: height/18,
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: (){
                      con.changeposition_faqs(index: index);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: width/22),
                      height: height/18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width/15),
                        gradient: con.assistant_pos==index?LinearGradient(colors: [
                          ColorsManager.burble,
                          Color.fromRGBO(105, 114, 240, 1),
                        ]):LinearGradient(colors: [
                          ColorsManager.white,
                          ColorsManager.white,

                        ]),
                        border: Border.all(width: width/350,color: Color.fromRGBO(224, 231, 242, 1)),
                      ),
                      child: Text(con.assistant_cat[index],style: TextStyle(
                        color: con.assistant_pos==index?Colors.white:Colors.black,
                        fontSize: width/25,
                        fontWeight: FontWeight.w400,
                      ),),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: con.assistant_cat.length,
                ),
              ),
            ),


            Expanded(
                child:Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/60),
                  child: ListView.separated(
                      itemBuilder: (context,index)=>Container(
                        decoration:BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(.2),width: width/300),
                          borderRadius: BorderRadius.circular(width/30),
                        ),
                        child: Theme(
                          data: ThemeData().copyWith(dividerColor: Colors.transparent),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: width/120,vertical: height/150),
                            
                            child: ExpansionTile(

                              backgroundColor: Colors.white,
                              collapsedBackgroundColor: Colors.white.withOpacity(.97),
                              iconColor: ColorsManager.burble,
                              childrenPadding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                              collapsedIconColor: ColorsManager.burble,
                              tilePadding: EdgeInsets.symmetric(horizontal: 10.0),
                              controlAffinity: ListTileControlAffinity.trailing,
                              trailing: !con.usedFaqsitemslist[index].show
                                  ? Icon(IconBroken.Arrow___Down_2)
                                  : Icon(IconBroken.Arrow___Up_2),
                              title: Row(
                                children: [
                                  Container(height: height/350,
                                      color:Colors.grey.withOpacity(.2)

                                  ),

                                  Text(
                                    con.usedFaqsitemslist[index].question,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(fontSize: 14, color: ColorsManager.black),
                                  ),
                                ],
                              ),
                              children: [
                                Container(
                                  height: width/300,
                                    color:Colors.grey.withOpacity(.2),
                                  margin: EdgeInsets.symmetric(vertical: height/200),

                                ),

                                Container(


                                    margin: EdgeInsets.symmetric(vertical: height/120),
                                    child: Text(con.usedFaqsitemslist[index].ans))
                                // Your content goes here
                                // DynamicFilters(),
                              ],
                              onExpansionChanged: (value) {
                                print(value);
                                con.changeshowitem(index: index,val: value);
                            
                                //con.isTapped.value=value;
                                // con.onHighlightChanged(value);
                                // Provider.of<Settings_prov>(context,listen: false).faqstate(snapshot.data![index].id!, value);
                              },
                              // Additional styling
                            
                              // Set the elevation for a subtle shadow
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context,index)=>SizedBox(height: height/60,),
                      itemCount: con.usedFaqsitemslist.length
                  ),
                ),
            ),


          ],
        ),
      ),
    );
  }
}
