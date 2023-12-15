import 'package:flutter/material.dart';

import '../manager/colors_manager.dart';



OutlineInputBorder focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(
    width: 1.3,
    color:  Color.fromRGBO(39, 140, 111, 1),
  ),
);

OutlineInputBorder enabledBorder =  OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(
    width: 1.3,
    color: ColorsManager.red,
  ),
);


