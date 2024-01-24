import 'package:get/get.dart';
import 'package:quickai/core/enums.dart';
import 'package:quickai/options/Localization_options.dart';

import '../../../data/Google_Ads.dart';
class Aboutitem{
  String title;
  Function onpress;
  Aboutitem({required this.title,required this.onpress});

}
class AboutappController extends GetxController{
  BaseAdsHelper _adsHelper=RemoteAdsHelper();

  List<Aboutitem> Aboutappitemlist=[
    Aboutitem(title: AppLocalizations.of(Get.context!).translate("aboutsc", "title0"), onpress:(){}),
    Aboutitem(title: AppLocalizations.of(Get.context!).translate("aboutsc", "title1"), onpress:(){}),
    Aboutitem(title: AppLocalizations.of(Get.context!).translate("aboutsc", "title2"), onpress:(){}),
    Aboutitem(title: AppLocalizations.of(Get.context!).translate("aboutsc", "title3"), onpress:(){}),
    Aboutitem(title: AppLocalizations.of(Get.context!).translate("aboutsc", "title4"), onpress:(){}),
    Aboutitem(title: AppLocalizations.of(Get.context!).translate("aboutsc", "title5"), onpress:(){}),
    Aboutitem(title: AppLocalizations.of(Get.context!).translate("aboutsc", "title6"), onpress:(){}),
    Aboutitem(title: AppLocalizations.of(Get.context!).translate("aboutsc", "title7"), onpress:(){}),
    Aboutitem(title: AppLocalizations.of(Get.context!).translate("aboutsc", "title8"), onpress:(){}),

  ];
@override
  Future<void> onReady() async {
    // TODO: implement onReady
    super.onReady();
    print("object");
    await _adsHelper.createInterstitialAd().then((value){
      if(value.requestState==RequestState.success)
        {
          _adsHelper.showInterstitialAd();
        }
    });

  }

}