import 'package:quickai/Features/Search_screen/controller/search_controller.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/manager/text_style_manager.dart';
import 'package:quickai/core/models/previousSearchItemModel.dart';
import 'package:quickai/core/styles/icons.dart';
import 'package:quickai/widgets/scroll_behavior.dart';
import 'package:flutter/material.dart';

class PreviousSearchList extends StatelessWidget {
  const PreviousSearchList({
    Key? key,
    required this.dataList,
    required this.controller,
    required this.height,
    required this.width,
    required this.title
  }) : super(key: key);

  final List<PrevSearchmodel> dataList;
  final Searchscreencontroller controller;
  final double height;
  final double width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: ListView.separated(
        itemCount: dataList.length + 1,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return index == 0
              ? ListTile(
            title: Text(title,style: getBoldStyle(color: ColorsManager.black, fontSize: width/28),),
            trailing: IconButton(
              icon: Icon(IconBroken.Delete,color: ColorsManager.black,),
              onPressed: () {
                controller.deleteAllSearchPrev();
              },
            ),
          )
              : ListTile(
            onTap: (){
              controller.Searchbyprevitem(prevtext:dataList[index - 1].title );
            },
            title: Text(dataList[index - 1].title,style: getRegularStyle(color: Colors.black38, fontSize: width/25),overflow: TextOverflow.ellipsis,maxLines: 1,),
            trailing: IconButton(
              icon: Icon(IconBroken.Close_Square),
              onPressed: () {
                controller.DeleteSearchitem(docid: dataList[index - 1].id);
              },
            ),
          );
        },
      ),
    );
  }
}