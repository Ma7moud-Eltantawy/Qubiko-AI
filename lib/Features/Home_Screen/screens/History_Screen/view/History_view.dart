import 'package:quickai/Features/Home_Screen/screens/Ai_assistant/view/Ai_Assistant_view.dart';
import 'package:quickai/Features/Home_Screen/screens/History_Screen/controller/history_controller.dart';
import 'package:quickai/Features/Search_screen/view/search_view.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/models/His_model.dart';
import 'package:quickai/core/styles/icons.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => SearchScreenView(),
                  duration: kTransitionDuration, transition: kTransition2);
            },
            icon: Icon(IconBroken.Search, color: ColorsManager.burble),
          ),
          IconButton(
            onPressed: () {},
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
          if(controller.historyDoc.isEmpty)
            {
              return Container();
            }

          return GetBuilder<HistoryController>(
            builder: (con) => controller.historyDoc.isEmpty
                ? Center(
              child: loadingwidget(height: height, width: width),
            )
                : ScrollConfiguration(
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
                      child: Histoty_item_model(
                          width: width, height: height, data: data),
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
        },
      ),
    );
  }
}
