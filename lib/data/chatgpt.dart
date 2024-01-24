


import 'package:quickai/core/enums.dart';
import 'package:quickai/core/models/His_model.dart';
import 'package:quickai/core/models/msg_model.dart';
import 'package:quickai/core/networking/request_result.dart';
import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'dart:convert';

import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/constants.dart';

abstract class BaseChatGptDataSource{
   Future<RequestResult<String>> Sendmsg({required String msg});
   Future<RequestResult>Savemsgs({required String userid,required String docid,required msg_model msgmodel});
   Future<RequestResult>setnewhistorycollection({required String userid,required String docid, required String msg});
   Future<RequestResult>Setinitialvalues({required String userid,required String docid, required String msg});



}
class RemoteChatGptDataSource implements BaseChatGptDataSource{
  @override
  Future<RequestResult<String>> Sendmsg({required String msg}) async {
     var dio = Dio();
     var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer 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',
        'Cookie': '__cf_bm=IxRdrxi3Rh_W.7XewovJCvi.C3.lV_PaVl5ioX83Qr8-1702005011-0-AZHx4wXCGSiImNhAmUqSYm4SispTTYnR1Qe51i+8PDu3WE3rjqncWgCjsph6uYWo291cDHBjk06dGs+MOEGxJCU=; _cfuvid=Eh2KUZmhcSPUFIVIuu.nAIWhgiq.8fZvRqCP.bLEVh4-1702005011325-0-604800000'
     };
     try {
        var response = await dio.post(
           'https://api.openai.com/v1/chat/completions',
           options: Options(headers: headers),
           data: {
              "model": "gpt-3.5-turbo",
              "messages": [
                 {
                    "role": "user",
                    "content": "$msg"
                 }
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
        print(await response.data.toString());
        String msgdata=await response.data["choices"][0]["message"]["content"].toString();

        print(msgdata);
        print("---------");
        return RequestResult(requestState:RequestState.success,data:msgdata);
     } catch (e) {
        return RequestResult(requestState:RequestState.success,errorMessage: e.toString());
     }
  }

  @override
  Future<RequestResult> Savemsgs({required String userid,required String docid,required msg_model msgmodel}) async {
     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
     try{
        print("Savingmsg ${msgmodel.textmsg}");
        await _firestore
            .collection('historydata')
            .doc(currentuserdata!.userid)
            .collection('history').doc(docid).collection('msgs').add(msgmodel.tojson() );
        print(RequestState);
        return RequestResult(requestState: RequestState.success);
     }
     on FirebaseException catch(e){
        return RequestResult(requestState: RequestState.failed);
     }

  }

  @override
  Future<RequestResult> setnewhistorycollection({required String userid,required String docid, required String msg}) async {
     try{
        await FirebaseFirestore.instance
            .collection('historycollectionlist').doc(userid).collection("hislist").add(His_Model(title:msg  , timestamp: DateTime.now().toString(), id:docid ).tojson());
        print(RequestState);
        return RequestResult(requestState: RequestState.success);
     }
     on FirebaseException catch(e){
        print(e);
        return RequestResult(requestState: RequestState.failed);
     }
  }

  @override
  Future<RequestResult> Setinitialvalues({required String userid, required String docid, required String msg}) {
    // TODO: implement Setinitialvalues
    throw UnimplementedError();
  }


}





class RemoteDataSource {
   final String userId;

   RemoteDataSource(this.userId);

   Future<List<msg_model>> getMessages({
      QueryDocumentSnapshot? lastDocument,
      int perPage = 2,
   }) async {
      try {
         CollectionReference msgCollection = FirebaseFirestore.instance
             .collection('history')
             .doc(userId)
             .collection('msgs');

         QuerySnapshot querySnapshot;
         if (lastDocument == null) {
            querySnapshot = await msgCollection
                .orderBy('timestamp')
                .limit(perPage)
                .get();
         } else {
            querySnapshot = await msgCollection
                .orderBy('timestamp')
                .startAfterDocument(lastDocument)
                .limit(perPage)
                .get();
         }

         if (querySnapshot.docs.isNotEmpty) {
            return querySnapshot.docs
                .map((el) => msg_model.fromjson(el.data() as Map<String, dynamic>))
                .toList();
         } else {
            return [];
         }
      } catch (e) {
         // Handle exceptions, e.g., log or display an error message.
         print('Error fetching data: $e');
         return [];
      }
   }
}