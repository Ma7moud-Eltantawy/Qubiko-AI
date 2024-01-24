import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:quickai/Features/Home_Screen/screens/Ai_assistant/view/Ai_Assistant_view.dart';
import 'package:quickai/Features/Home_Screen/screens/History_Screen/controller/history_controller.dart';
import 'package:quickai/Features/Search_screen/view/search_view.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/manager/text_style_manager.dart';
import 'package:quickai/core/models/His_model.dart';
import 'package:quickai/core/styles/icons.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:quickai/widgets/his_item.dart';
import 'package:quickai/widgets/loadibg_widget.dart';
import 'package:quickai/widgets/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class History_Screen extends StatelessWidget {
  const History_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    HistoryController controller = Get.put(HistoryController());
    var loc=AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate("historysc", "sctitle")),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => SearchScreenView(),
                  duration: kTransitionDuration, transition: kTransition2);
            },
            icon: Icon(IconBroken.Search, color: ColorsManager.burble),
          ),
          IconButton(
            onPressed: () {
              controller.Deleteallitems();
            },
            icon: Icon(IconBroken.Delete, color: ColorsManager.burble),
          ),
        ],
        leading: Container(
          padding: EdgeInsets.all(width / 25),
          child: SvgPicture.asset("assets/img/logo.svg"),
        ),
      ),
      body: FutureBuilder<void>(
        future: controller.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.waiting) {
            return Center(child: loadingwidget(height: height, width: width));
          }

          else{

            return GetBuilder<HistoryController>(
              builder: (con) =>con.historyDoc.isEmpty?
               Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/img/empty_history.svg"),
                Text(loc.translate("historysc", "emptyhint"),style: getMediumStyle(color: Colors.black54, fontSize: width/25),),


              ],
            ),
          )

                  :ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  controller: con.scrollController,
                  itemCount: con.historyDoc.length + 1,
                  itemBuilder: (context, index){
                    if (index < con.historyDoc.length) {
                      final data = con.historyDoc[index];
                      return GestureDetector(
                        onTap: () async {
                          // await controller.getData();
                          await con.fetchData(index);
                        },
                        child: Slidable(
                          key:  ValueKey(index),

                          startActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),
                            dragDismissible: false,

                            // A pane can dismiss the Slidable.
                            dismissible: DismissiblePane(onDismissed: () {}),

                            // All actions are defined in the children parameter.
                            children:  [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                onPressed:(BuildContext context){
                                  con.Deletehistoryhistoryitem(index);
                                },
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',

                              ),
                            ],
                          ),

                          child: Histoty_item_model(
                              width: width, height: height, data: data),
                        ),
                      );
                    } else {
                      if (con.isLoading) {
                        return Center(
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: height / 20),
                            child: loadingwidget(
                                height: height / 3, width: width / 2.5),
                          ),
                        );
                      } else {
                        return Container(padding: EdgeInsets.all(16));
                      }
                    }
                  },
                ),
              ),
            );
          }



        },
      ),
    );
  }
}
