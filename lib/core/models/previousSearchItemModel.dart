import 'package:quickai/core/entities/history_model.dart';
import 'package:quickai/core/entities/msg.dart';
import 'package:quickai/core/entities/prev_search_item.dart';

class PrevSearchmodel extends prevsearchitem{
  PrevSearchmodel({required super.title, required super.timestamp, required super.id});
  factory PrevSearchmodel.fromjson(Map <String,dynamic> json){
    return PrevSearchmodel(title: json['title'], timestamp: json['timestamp'],id: json['id']);

  }


  Map <String,dynamic> tojson()=>
      {
        'title': title,
        'timestamp': timestamp,
        'id':id
      };

}