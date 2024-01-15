import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/styles/icons.dart';
import 'package:flutter/material.dart';

class search_feild extends StatelessWidget {
  search_feild({
    super.key,
    required this.controller, required this.width, required this.heigh, required this.onpress,


  });
  final TextEditingController controller;
  final double width;
  final double heigh;
  final Function onpress;


  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    return Container(
      width: width,
      child: TextFormField(
        controller: controller,
        cursorColor: ColorsManager.burble,
        keyboardType: TextInputType.text,

        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: width/30
        ),
        decoration: InputDecoration(
          errorStyle: TextStyle(
              fontSize: width/40,
              color: ColorsManager.red.withOpacity(.6),
              fontWeight: FontWeight.w600
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: width/16),

          filled: true,
          fillColor: Colors.grey[100], // Gray background color
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width/15),
            borderSide: BorderSide(color: Colors.grey[200]!), // Default border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width/15),
            borderSide: BorderSide(color: ColorsManager.burble), // Active (focused) border color
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width/15),
            borderSide: BorderSide(color: ColorsManager.red.withOpacity(.6)), // Active (focused) border color
          ) ,
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width/15),
            borderSide: BorderSide(color: ColorsManager.burble), // Active (focused) border color
          ),
          hintStyle: TextStyle(
              color: Colors.grey[400]
          ),
          suffixIcon: IconButton(
              onPressed:onpress(),
              icon: Icon(IconBroken.Search)), // Default prefix icon color
          suffixIconColor: ColorsManager.burble, // Active (focused) prefix icon color
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Data.';
          }
          return null;
        },

      ),
    );
  }
}
