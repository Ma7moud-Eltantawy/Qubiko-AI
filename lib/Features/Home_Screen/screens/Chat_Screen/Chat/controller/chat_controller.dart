import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/models/msg_model.dart';
import 'package:quickai/data/chatgpt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../core/entities/msg.dart';

class MsgData {
  MsgData({required this.sendByMe, required this.msgTxt});
  final bool sendByMe;
  final String msgTxt;
}

class AssistantController extends GetxController {
  final TextEditingController msgController = TextEditingController();
  late List<msg_model>  msgs ;
  BaseChatGptDataSource baseChatGptDataSource = RemoteChatGptDataSource();
   ScrollController scrollController=ScrollController();
  var uuid;
  List<msg_model> Msgs;
  String userid;
  String searchtitle;



  // Factory constructor
  factory AssistantController({required List<msg_model> Msgs,required String userid,required String searchtitle}) {
    return AssistantController._(Msgs: Msgs,userid: userid,searchtitle: searchtitle);

  }

  // Private constructor
  AssistantController._({required this.Msgs,required this.userid,required this.searchtitle});





  Future<void> setmsgs()
  async {


  }



  @override
  void onInit() {
    super.onInit();
    uuid = userid.isEmpty?Uuid().v4():userid;

    print(uuid);
    msgs=Msgs;
    //print(msgs[0].textmsg);
    print(uuid);
    scrollToEnd();
    update();
  }
  @override
  void onReady() {
    // TODO: implement onReady

    super.onReady();
    uuid = userid.isEmpty?Uuid().v4():userid;
    print(uuid);
    msgs=Msgs;
    //print(msgs[0].textmsg);

    print(uuid);
    scrollToEnd();
    update();
  }


  void dispose() {
    msgController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void sendMsg() async {
    print(Msgs.length);
    print(msgs.length);


    QuerySnapshot querySnapshot;
    String msgsend= msgController.text.trim();
    print(msgController.text.toString());

    if (msgController.text.isNotEmpty) {
      if(msgs.isEmpty)
      {
        await baseChatGptDataSource.setnewhistorycollection(userid:  currentuserdata!.userid.toString(), msg: msgController.text,docid:uuid );

      }
      msgs.add(msg_model(sender:"me", textmsg: "$searchtitle$msgsend",timestamp: DateTime.now().toString()));
      update();
      scrollToEnd();
      msgController.clear();

      await baseChatGptDataSource.Savemsgs(userid: currentuserdata!.userid.toString(), docid: uuid, msgmodel: msg_model(
          textmsg: msgs.last.textmsg,
          sender: msgs.last.sender=="me"?"me":"ai",
          timestamp: DateTime.now().toString()));
      print(msgController.text.trim());
      await baseChatGptDataSource.Sendmsg(msg: msgsend).then((value) {
        msgs.add(msg_model(sender:"ai", textmsg: value.data.toString(),timestamp: DateTime.now().toString()));
        scrollToEnd();
        update();
      });
      baseChatGptDataSource.Savemsgs(userid: currentuserdata!.userid.toString(), docid: uuid, msgmodel: msg_model(
          textmsg: msgs.last.textmsg,
          sender: msgs.last.sender=="ai"?"ai":"me",
          timestamp: DateTime.now().toString()));



      update();
    }
  }

  Future<void> scrollToEnd() async {
    await Future.delayed(Duration(milliseconds: 100));
    if (scrollController.hasClients) {
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      print(scrollController.position);
    }
    print(scrollController.hasClients);
  }
}




/*import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final TextEditingController messageController = TextEditingController();
  final RxList<Message> messages = <Message>[].obs;
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  final _messageStreamController = StreamController<Message>.broadcast();


  Stream<Message> get messageStream => _messageStreamController.stream;

  Future<void> sendMessage(String text, String sender) async {
    final newMessage = Message(text: text, sender: sender);
    messages.add(newMessage);
    print(messages.length);
    listKey.currentState?.insertItem(messages.length - 1);
  }

  Future<void> getChatDataAndSend(String userMessage) async {
    try {
      final assistantResponse = await getChatData(userMessage);
      await sendMessage(assistantResponse.text, assistantResponse.sender);
      _messageStreamController.add(assistantResponse); // Emit the message through the stream
    } catch (e) {
      // Handle errors
      print("Error: $e");
    }
  }

  Future<Message> getChatData(String userMessage) async {
    var dio = Dio();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer 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',
    };

    try {
      var response = await dio.post(
        'https://api.openai.com/v1/chat/completions',
        options: Options(headers: headers),
        data: {
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": userMessage},
          ],
          "temperature": 1,
          "top_p": 1,
          "n": 1,
          "stream": false,
          "max_tokens": 250,
          "presence_penalty": 0,
          "frequency_penalty": 0,
        },
      );

      String msgData = response.data["choices"][0]["message"]["content"].toString();

      return Message(text: msgData, sender: "AI");
    } catch (e) {
      // Handle errors
      print("Error: $e");
      return Message(text: "Error fetching data", sender: "error");
    }
  }

  @override
  void dispose() {
    _messageStreamController.close();
    super.dispose();
  }
}

class Message {
  final String text;
  final String sender;

  Message({required this.text, required this.sender});
}*/