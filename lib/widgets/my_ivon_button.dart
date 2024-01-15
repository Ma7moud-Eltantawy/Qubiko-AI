import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class iconbutton extends StatelessWidget {
  const iconbutton({
    super.key,
    required this.height,
    required this.width,
    required this.wid,
    required this.onpress,
    required this.bordercolor
  });

  final double height;
  final double width;
  final Widget wid;
  final Function onpress;
  final Color bordercolor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>onpress(),
      child: Container(
        height: height/12,
        width: width/3.5,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color:bordercolor),
          borderRadius: BorderRadius.circular(width/5),
        ),
        child: Center(
          child: Container(
            height: height/24,
            width: width/7,
            child:wid,
          ),
        ),

      ),
    );
  }
}