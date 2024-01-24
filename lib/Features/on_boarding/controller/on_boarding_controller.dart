import 'package:quickai/Features/hello_page/view/hello_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quickai/core/enums.dart';
import 'package:quickai/data/DB_Helper.dart';
class Pageviewmodel{
  final String Backgroundimg;
  final String title;
  final String text_info;
  final bool is_last;

  Pageviewmodel(
      {required this.title,required this.text_info,required this.is_last,required this.Backgroundimg});
}

class Onboarding_controller extends GetxController{
  BaseDBhelperdatasource _dBhelperdatasource=RemoteDBhelperdatasource();
  PageController pcon=PageController();
  int pos=0;
  List<Pageviewmodel> OnBoardingList=[
    Pageviewmodel(
        Backgroundimg:"assets/img/board1.png" ,
        title:"The Best Unparalleled \n Conversational Brilliance" ,
        text_info: "Lorem ipsum dolor sit amet, consectetur \n adipiscing elit, sed do eiusmod tempor...",
        is_last: false),
    Pageviewmodel(
        Backgroundimg:"assets/img/board2.png" ,
        title:"Harness the Power of AI Assistants for Productivity" ,
        text_info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...",
        is_last: false),
    Pageviewmodel(
        Backgroundimg:"assets/img/board3.png" ,
        title:"Diverse AI Helpers to Revolutionize Your Tasks" ,
        text_info: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...",
        is_last: false),

  ];
  changeposition(int position)
  {
    pos=position;
    update();
  }
  Skipfunc()
  {
    pcon.jumpToPage(OnBoardingList.length - 1);
    update();
  }
  Nextfunc()
  {
    pcon.nextPage(
      duration: Duration(milliseconds: 750),
      curve: Curves.fastLinearToSlowEaseIn,
    );
    update();
  }
  Previousfunction()
  {
    pcon.previousPage(
      duration: Duration(milliseconds: 750),
      curve: Curves.fastLinearToSlowEaseIn,
    );
    update();
  }
  Navigator()
  {
    _dBhelperdatasource.OnBoardingseen().then((seenstate)
    {

      if(seenstate.requestState==RequestState.success)
      Get.to(()=>Welcome_Screen(),transition: kTransition2,duration: kTransitionDuration);


    });
  }




}

