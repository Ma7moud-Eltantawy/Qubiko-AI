
import 'package:quickai/Features/Search_screen/controller/search_controller.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/manager/text_style_manager.dart';
import 'package:quickai/core/styles/icons.dart';
import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
    Key? key,
    required this.controller,
    required this.height,
    required this.width,
    required this.hinttext,
  }) : super(key: key);

  final Searchscreencontroller controller;
  final double height;
  final double width;
  final String hinttext;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 14,
      width: width/1.25,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(width / 30),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 55),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: controller.searchcon,
                  textAlignVertical: TextAlignVertical.top,
                  cursorColor: ColorsManager.purble2,
                  decoration: InputDecoration(
                    hintText: hinttext,
                    hintStyle: getRegularStyle(color: ColorsManager.black.withOpacity(.5), fontSize: width/20),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: width / 50),
                  ),
                  onChanged: (val) {
                    //controller.GetSearch(Searchkey:val );
                  },
                ),
              ),
            ),
            InkWell(
              onTap: () {
                controller.GetSearchItem();
                FocusScope.of(context).unfocus();
              },
              child: Container(
                margin: EdgeInsets.all(width / 120),
                padding: EdgeInsets.all(width / 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width / 40),
                ),
                child: Icon(
                  IconBroken.Search,
                  color: ColorsManager.purble2,
                  size: width / 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

