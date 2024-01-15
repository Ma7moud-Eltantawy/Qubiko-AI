import 'package:quickai/core/entities/history_model.dart';
import 'package:quickai/core/entities/msg.dart';

class His_Model extends His{
  His_Model({required super.title, required super.timestamp, required super.id});
  factory His_Model.fromjson(Map <String,dynamic> json){
    return His_Model(title: json['title'], timestamp: json['timestamp'],id: json['id']);

  }


  Map <String,dynamic> tojson()=>
      {
        'title': title,
        'timestamp': timestamp,
        'id':id
      };

}