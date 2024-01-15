import 'package:quickai/core/entities/msg.dart';

class msg_model extends msg{
  msg_model({required super.textmsg, required super.sender, required super.timestamp});
  factory msg_model.fromjson(Map <String,dynamic> json){
    return msg_model(textmsg: json['msg'], sender: json['sender'], timestamp: json['timestamp']);

  }


  Map <String,dynamic> tojson()=>
      {
        'msg': textmsg,
        'sender': sender,
        'timestamp': timestamp
    };

}