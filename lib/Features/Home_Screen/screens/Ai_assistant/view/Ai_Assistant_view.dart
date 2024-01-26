import 'package:quickai/Features/Auth/Login/view/Login_screen.dart';
import 'package:quickai/Features/Home_Screen/screens/Ai_assistant/controller/Ai_assistant_con.dart';
import 'package:quickai/Features/Home_Screen/screens/Ai_assistant/view/Ai_Assistant_view.dart';
import 'package:quickai/Features/Home_Screen/screens/Chat_Screen/Chat/view/chat_view.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/data/Google_Ads.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:quickai/widgets/scroll_behavior.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/sizeconfig.dart';
class AI_Assistant_Screen extends StatelessWidget {
   AI_Assistant_Screen({Key? key}) : super(key: key);
  static const scid="/AI_Assistant_Screen";
  Ai_Assistant_controller controller=Get.find();


  @override
  Widget build(BuildContext context) {
    var Width=Get.size.width<SizeConfig.tabletBreakPoint?Get.width:Get.width*.75;

    var loc=AppLocalizations.of(context);

    return GetBuilder<Ai_Assistant_controller>(
      builder:(con)=> Scaffold(
        appBar: AppBar(
          title: Text(loc.translate("apphomescs", "sc2")),
          leading: Container(
            padding: EdgeInsets.all(Width/40),

              child: SvgPicture.asset("assets/img/logo.svg")),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(height/12),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Width/40),
              height: height/18,
              child: ScrollConfiguration(
                behavior: MyBehavior(),

                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: (){
                      con.changeposition_assistant(index: index,collectionname: con.assistant_cat[index]);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: Width/22),
                      height: height/18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Width/15),
                        gradient: con.assistant_pos==index?LinearGradient(colors: [
                          ColorsManager.burble,
                          Color.fromRGBO(105, 114, 240, 1),
                        ]):LinearGradient(colors: [
                          ColorsManager.white,
                          ColorsManager.white,

                        ]),
                        border: Border.all(width: Width/350,color: Color.fromRGBO(224, 231, 242, 1)),
                      ),
                      child: Text(con.assistant_cat[index],style: TextStyle(
                        color: con.assistant_pos==index?Colors.white:Colors.black,
                        fontSize: Width/25,
                        fontWeight: FontWeight.w400,
                      ),),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemCount: con.assistant_cat.length,
                ),
              ),
            ),
          ),
        ),
        body:  ScrollConfiguration(

          behavior: MyBehavior(),
          child: SingleChildScrollView(

            child:Padding(
              padding: EdgeInsets.symmetric(horizontal: Width/40,vertical: height/150),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                  itemBuilder: (BuildContext context, int index) => items_view(width: Width,
                      height: height,listname: con.usedItems?.keys.toList()[index] as String,
                  itemsdata: con.usedItems![con.usedItems?.keys.toList()[index]] as List<CategoryItem>,
                  ),
              itemCount: con.usedItems!.length,
              ),
            ),
          ),
        )
      ),
    );
  }
}

class items_view extends StatelessWidget {
  const items_view({
    super.key,
    required this.width,
    required this.height, required this.itemsdata,
    required this.listname,
  });

  final double width;
  final double height;
  final List<CategoryItem> itemsdata;
  final String listname;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: height/60),
          child: Text(listname,style:TextStyle(
            fontSize: width/21,
            fontWeight: FontWeight.w600
          ) ,),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing:width/45,
            mainAxisSpacing: width/45,
            mainAxisExtent: height/3.2
          ),
          itemCount: itemsdata.length,
          itemBuilder: (context, index) {
            return Container(
                child: category_item_view(height: height,width: width,currentitemdata: itemsdata[index],)
            );
          },
        ),
      ],
    );
  }
}

class category_item_view extends StatelessWidget {
  const category_item_view({
    super.key,
    required this.width,required this.height, required this.currentitemdata,
    

  });
  final double height;
  final double width;
  final CategoryItem currentitemdata;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>Chat_screen(msgsdata: [], docid: "", searchtitle:currentitemdata.Searchtitle,),transition: kTransition2,duration: kTransitionDuration);
      },

      child: Container(
        padding: EdgeInsets.symmetric(vertical: height/50,horizontal: width/20),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(width/25)
        ),
      
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(currentitemdata.img,height: height/18,width: height/18,fit: BoxFit.fill,),
            SizedBox(height: height/50,),
            Text(currentitemdata.title,style: TextStyle(

              overflow: TextOverflow.ellipsis,
              fontSize: width/30,
              fontWeight: FontWeight.w600
            ),),
            SizedBox(height: height/50,),
            Text(currentitemdata.hint,style: TextStyle(
                fontSize: width/27,
                color: Colors.black54,
                fontWeight: FontWeight.w300
            ),),
          ],
        ),
      ),
    );
  }
}
