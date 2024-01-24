import 'package:get/get.dart';

import '../../../../../options/Localization_options.dart';


class Faqitem {
  String question;
  String ans;
  bool show;
  String faqcollection;

  Faqitem({required this.question, required this.ans, required this.show,required this.faqcollection});
}



class FaqsController extends GetxController
{
  late List<Faqitem> usedFaqsitemslist;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    usedFaqsitemslist=Faqsitemslist.toList();

  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    usedFaqsitemslist=Faqsitemslist.toList();
  }



  var loc=AppLocalizations.of(Get.context!);

  int assistant_pos=0;
  int ?isTapped;

  List<String> assistant_cat=[
    AppLocalizations.of(Get.context!).translate("faqscat", "cat1"),
    AppLocalizations.of(Get.context!).translate("faqscat", "cat2"),
    AppLocalizations.of(Get.context!).translate("faqscat", "cat3"),
    AppLocalizations.of(Get.context!).translate("faqscat", "cat4"),

  ];
  List<Faqitem> Faqsitemslist = [
    Faqitem(
      question: AppLocalizations.of(Get.context!).translate("faqsc", "q1"),
      ans:AppLocalizations.of(Get.context!).translate("faqsc", "ans1"),
      show: false,
      faqcollection:"Genral",
    ),
    Faqitem(
      question: AppLocalizations.of(Get.context!).translate("faqsc", "q2"),
      ans:AppLocalizations.of(Get.context!).translate("faqsc", "ans2"),
      show: false,
      faqcollection:"Genral",
    ),
    Faqitem(
      question: AppLocalizations.of(Get.context!).translate("faqsc", "q3"),
      ans:AppLocalizations.of(Get.context!).translate("faqsc", "ans3"),
      show: false,
      faqcollection:"Genral",
    ),
    Faqitem(
      question: AppLocalizations.of(Get.context!).translate("faqsc", "q4"),
      ans:AppLocalizations.of(Get.context!).translate("faqsc", "ans4"),
      show: false,
      faqcollection:"Account",
    ),
    Faqitem(
      question: AppLocalizations.of(Get.context!).translate("faqsc", "q5"),
      ans:AppLocalizations.of(Get.context!).translate("faqsc", "ans5"),
      show: false,
      faqcollection:"Service",
    ),

  ];





  changeposition_faqs({required int index})
  {
    assistant_pos=index;
    if(index!=0)
      {
        usedFaqsitemslist=Faqsitemslist.where((element) => element.faqcollection==assistant_cat[index]).toList();

      }
    else{
      usedFaqsitemslist=Faqsitemslist;

    }

    update();
  }

  changeshowitem({required int index,required val})
  {
    Faqsitemslist[index].show=val;
    update();
  }



}