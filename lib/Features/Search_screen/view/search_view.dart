import 'package:quickai/Features/Search_screen/view/search_view.dart';
import 'package:quickai/core/manager/text_style_manager.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:quickai/widgets/PreviousSearchList.dart';
import 'package:quickai/widgets/his_item.dart';
import 'package:quickai/widgets/loadibg_widget.dart';
import 'package:quickai/widgets/search_Bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:quickai/Features/Search_screen/controller/search_controller.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/models/previousSearchItemModel.dart';
import 'package:quickai/core/styles/icons.dart';
import 'package:quickai/widgets/search_textfield.dart';
import 'package:quickai/widgets/textfield.dart';
import 'package:lottie/lottie.dart';

class SearchScreenView extends StatelessWidget {
  final Searchscreencontroller controller = Get.put(Searchscreencontroller());

  @override
  Widget build(BuildContext context) {
    var loc=AppLocalizations.of(context);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(

    
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: width/10,

                  child: IconButton(

                    icon: Icon(IconBroken.Arrow___Left_2),
                    onPressed: (){
                      Get.back();
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: width/50),
                    child: Container(
                        child: Searchbar(controller: controller, height: height,
                          width: width,hinttext: loc.translate("searchscreen","search_hint"),)),
                  ),
                ),

              ],
            ),

            Expanded(
              child: StreamBuilder<List<PrevSearchmodel>>(

                stream: controller.streamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData) {
                    return loadingwidget(width: width,height: height,);
                  }
                  var dataList = snapshot.data!;
                  if (controller.historyseachlist.isNotEmpty && controller.searchcon.text.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: height/30),
                      child: ListView.builder(
                        itemCount: controller.historyseachlist.length+1 ,
                        itemBuilder: (context, index) {
                          return index==0?
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: width/30,vertical: height/240),
                                  child: Text(loc.translate("searchscreen", "search_result")))


                              :
                             Histoty_item_model(width: width, height: height, data: controller.historyseachlist[index-1]);

                        },
                      ),
                    );
                  }
                  if(controller.searchState.value==search_state.loading)
                    {
                      return loadingwidget(width: width,height: height,);

                    }
                  if(controller.searchState.value==search_state.success && controller.historyseachlist.isEmpty)
                  {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: width/20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: height/4,
                              margin: EdgeInsets.all(width/15),
                              child: SvgPicture.asset("assets/img/serchnotfound.svg")),
                          Text(loc.translate("searchscreen", "foundtitle"),style: getBoldStyle(color: ColorsManager.black, fontSize: width/20),),
                          Text(loc.translate("searchscreen", "foundhint")
                          ,style: getRegularStyle(

                                   color: ColorsManager.black.withOpacity(.8), fontSize: width/25,
                            ),
                          textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );

                  }


                  return dataList.isEmpty
                      ? Container()
                      : controller.searchcon.text.isNotEmpty
                      ? Container(
                    child: Center(
                      child: Lottie.asset("assets/img/searchlottie.json"),
                    ),
                  )
                      : PreviousSearchList(dataList: dataList,title: loc.translate("searchscreen", "prv_title"), controller: controller, height: height, width: width);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
