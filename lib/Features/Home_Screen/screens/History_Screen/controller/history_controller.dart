import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:quickai/Features/Home_Screen/screens/Chat_Screen/Chat/view/chat_view.dart';
import 'package:quickai/core/entities/msg.dart';
import 'package:quickai/core/models/His_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:quickai/core/models/msg_model.dart';

import '../../../../../core/constants.dart';
import '../../../../../data/getched_data_helper.dart';
import '../../Chat_Screen/Chat/controller/chat_controller.dart';

class HistoryController extends GetxController {
  BaseFetcheddataHelper _fetcheddataHelper=RemoteDBhelperdatasource();
  late ScrollController scrollController;
  final int perPage = 10;

  QueryDocumentSnapshot? lastDocument;
  bool isLoading = false;
  List<His_Model> historyDoc = [];
  List<String> historyDocids = [];



  @override
  Future<void> onInit() async {
    super.onInit();


    scrollController = ScrollController()
      ..addListener(_scrollListener);



    // Trigger initial data load
    getData();
  }

  Future<void> getData() async {
    print("Fetching data...");
    if (isLoading) return;

    isLoading = true;

    try {
      QuerySnapshot querySnapshot;
        print("isnotempty");
        print(historyDoc.length);

        if (lastDocument == null) {
          querySnapshot = await FirebaseFirestore.instance
              .collection('historycollectionlist')
              .doc(currentuserdata!.userid)
              .collection('hislist')
              .orderBy('timestamp')
              .limit(perPage)
              .get();

          print(historyDoc.length);
        } else {
          querySnapshot = await FirebaseFirestore.instance
              .collection('historycollectionlist')
              .doc(currentuserdata!.userid)
              .collection('hislist')
              .orderBy('timestamp')
              .startAfterDocument(lastDocument!)
              .limit(perPage)
              .get();
          print("last");
          print(historyDoc.length);
          update();
        }

      print(querySnapshot.docs.length);


      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
        historyDoc.addAll(querySnapshot.docs.map((el) =>
            His_Model.fromjson(el.data() as Map<String, dynamic>)));
        historyDocids.addAll(querySnapshot.docs.map((el) =>el.id));
        print("Fetching data...");

      }
      print(historyDoc.length);
      update();
    } catch (e) {
      // Handle exceptions, e.g., log or display an error message.
      print('Error fetching data: $e');
    }

    isLoading = false;
    update();
  }

  void _scrollListener() async{
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent &&
        !isLoading) {
      print("object");
      // Trigger fetching more data
      await getData();
      print("suc");

    }
    update();
  }

  Future<void> fetchData(int indx) async {
    try {
      // Fetch documents from Firestore without specifying a document ID
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('historydata')
          .doc(currentuserdata!.userid)
          .collection('history').doc(historyDoc[indx].id).collection("msgs")
          .get();
      print(querySnapshot.docs.length);
      List<msg_model> msgs=[];
      // Print the document IDs and data
      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = await querySnapshot.docs.last;
        msgs.addAll(querySnapshot.docs.map((el) =>
            msg_model.fromjson(el.data() as Map<String, dynamic>)));
        msgs.sort((a,b)=>a.timestamp.compareTo(b.timestamp));

        print("Fetching data...${msgs.length}");


      }
      Get.to(()=>Chat_screen(msgsdata:msgs,docid:historyDoc[indx].id.toString(),searchtitle:"",),transition: kTransition2,duration: kTransitionDuration);
      //Get.find<AssistantController>().onInit();

    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void Deletehistoryhistoryitem(int itemindex)
  async {
    await _fetcheddataHelper.DeleteHistoryitem(docid:historyDocids[itemindex] ,msgdoc:historyDoc[itemindex].id);
    historyDoc.removeWhere((element) => element.id==historyDoc[itemindex].id);
    historyDocids.removeAt(itemindex);
    update();

  }

  Deleteallitems()
  async {
    await _fetcheddataHelper.deleteAllHistory();
    historyDoc.clear();
    update();

  }




}
