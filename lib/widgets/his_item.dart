import 'package:quickai/core/models/His_model.dart';
import 'package:quickai/core/styles/icons.dart';
import 'package:flutter/material.dart';

class Histoty_item_model extends StatelessWidget {
  const Histoty_item_model({
    super.key,
    required this.width,
    required this.height,
    required this.data,
  });

  final double width;
  final double height;
  final His_Model data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height/10,
      margin: EdgeInsets.symmetric(horizontal: width/30,vertical: height/240),

      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(width/30),

      ),
      child: ListTile(
        title: Container(child: Text(data.title,
          maxLines: 1,overflow:TextOverflow.ellipsis ,style: TextStyle(fontSize: width/30,fontWeight: FontWeight.w900),),),
        subtitle:Text(data.timestamp,style: TextStyle(fontSize: width/40,color: Colors.black38,fontWeight: FontWeight.w900)),
        trailing: Icon(IconBroken.Arrow___Right_2),
      ),
    );
  }
}
