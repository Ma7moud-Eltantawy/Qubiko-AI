import 'package:ai_chatbot/Features/on_boarding/controller/on_boarding_controller.dart';
import 'package:ai_chatbot/core/manager/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class onBoarding_Screen extends StatelessWidget {
  const onBoarding_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    Onboarding_controller controller=Get.put(Onboarding_controller());
    return GetBuilder<Onboarding_controller>(
      builder: (con)=>Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              onPageChanged: (pos)
                {
                  con.changeposition(pos);

                },
              controller: con.pcon,
              itemCount: con.OnBoardingList.length,
                itemBuilder: (context,index){
              return Stack(
                alignment: Alignment.center,

                children: [

                  Column(
                    children: [
                      Expanded(child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.black
                        ),
                          child:Image.asset(con.OnBoardingList[index].Backgroundimg,fit: BoxFit.fill,)
                      ),

                      ),
                    ],
                  ),
                  Padding(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(con.OnBoardingList[index].title,
                          style: TextStyle(
                          color: Colors.black,
                          fontSize:width/15,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        ),
                        SizedBox(height: height/22,),
                        Text(con.OnBoardingList[index].text_info,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:width/20,

                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: width/150,vertical: height/3.5),
                  ),


                ],
              );

            }),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: SmoothPageIndicator(
                      controller:con.pcon ,
                      count: con.OnBoardingList.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.black12,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 4,
                        spacing: 5,
                        activeDotColor: ColorsManager.burble,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      con.pos==0?
                    materialbutton(height: height, width: width/2.5,color: ColorsManager.grey.withOpacity(.2),onpress: ()=>
                      con.Skipfunc(),text: "Skip",textcolor: ColorsManager.burble,)
                          :
                      materialbutton(height: height, width: width/2.5,color: ColorsManager.grey.withOpacity(.2),onpress: ()=>
                          con.Previousfunction(),text: "previous",textcolor: ColorsManager.burble,),

                      con.pos==con.OnBoardingList.length-1?
                      materialbutton(height: height, width: width/2.5,color: ColorsManager.burble,onpress: ()=>
                      con.Navigator(),text: "Done",textcolor: ColorsManager.white,)
                          :
                      materialbutton(height: height, width: width/2.5,color: ColorsManager.burble,onpress: ()=>
                      con.Nextfunc(),text: "Next",textcolor: ColorsManager.white,),




                    ],)



                ],
              ),
            ),
          ],

        )
      ),
    );
  }
}

class materialbutton extends StatelessWidget {
  const materialbutton({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.text,
    required this.onpress,
    required this.textcolor,
  });

  final double height;
  final double width;
  final String text;
  final Color color;
  final Color textcolor;
  final Function onpress;


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      
      highlightColor: ColorsManager.burble.withOpacity(.1),

      child: Container(
        margin: EdgeInsets.symmetric(vertical: height/80),
        width: width,
        height: height/15,
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.circular(width/5),
        ),
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(
              color: this.textcolor,
              fontSize: height/50,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
        ),
    ),
    onPressed:(){
        this.onpress();
    }
    );
  }
}
