import 'package:quickai/core/manager/colors_manager.dart';
import 'package:flutter/material.dart';

class materialbutton extends StatelessWidget {
  const materialbutton({
    super.key,
    required this.height,
    required this.width,
    required this.colors,
    required this.text,
    required this.onpress,
    required this.textcolor,
  });

  final double height;
  final double width;
  final String text;
  final List<Color> colors;
  final Color textcolor;
  final Function onpress;


  @override
  Widget build(BuildContext context) {
    return MaterialButton(


        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,






        child: Container(

          margin: EdgeInsets.symmetric(vertical: height/80),
          width: width,
          height: height/15,
          decoration: BoxDecoration(

            gradient: LinearGradient(
              colors: colors
            ),
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
