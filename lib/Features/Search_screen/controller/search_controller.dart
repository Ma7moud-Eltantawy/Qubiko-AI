import 'dart:async';

import 'package:quickai/core/constants.dart';
import 'package:quickai/core/enums.dart';
import 'package:quickai/core/models/His_model.dart';
import 'package:quickai/core/models/previousSearchItemModel.dart';
import 'package:quickai/core/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../../data/getched_data_helper.dart';

enum search_state {
  previous,
  loading,
  success,
  failed,
}


class Searchscreencontroller extends GetxController {
  BaseFetcheddataHelper _fetcheddataHelper =RemoteDBhelperdatasource();

  late TextEditingController searchcon;
  var dataList = <PrevSearchmodel>[];
  var isLoading = true.obs;
  List<His_Model> historyseachlist = [];
  Set<PrevSearchmodel> uniqueItemsSet = Set<PrevSearchmodel>();
   late StreamController<List<PrevSearchmodel>> streamController ;
  Rx<search_state> searchState = search_state.previous.obs;
  @override
  void onClose() {

    super.onClose();
    streamController.close();
    searchcon.dispose();
    // Close the stream controller when the controller is closed

  }




@override
  void onInit()async {
  try {
    searchcon=TextEditingController();
    streamController = StreamController<List<PrevSearchmodel>>.broadcast();

    getprevioussearchdata.listen((dataList) {
      if (!streamController.isClosed) {
        streamController.add(dataList);
      }
    });

    // Other initialization code...
  } catch (e) {
    print(e);
  }



      searchcon.addListener(() {
        if(searchcon.text.isEmpty)
        {
          print("empty");
          historyseachlist.clear();
          searchState.value = search_state.previous;
        }
      });
    super.onInit();

  }






  @override
  void dispose() {
    streamController.close();
    searchcon.dispose();
    super.dispose();


  }



  Stream<List<PrevSearchmodel>> get getprevioussearchdata async* {
    DocumentSnapshot? lastDocument;

    while (true) {
      try {
        isLoading.value = true;

        Query<Map<String, dynamic>> query = FirebaseFirestore.instance
            .collection('history')
            .doc(currentuserdata!.userid)
            .collection('search_prev');

        var result = await query.limit(10).get();

        if (result.docs.isNotEmpty) {

          for (var doc in result.docs) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            PrevSearchmodel prevSearchModel = PrevSearchmodel.fromjson(data);

            if (!dataList.any((item) => item.id == prevSearchModel.id)) {
              dataList.add(prevSearchModel);
            }
          }
          // Update lastDocument for pagination

        }

        isLoading.value = false;

        yield dataList.toList(); // Yield a copy of the list to avoid direct mutation
      } catch (e) {
        print("Error fetching data: $e");
        isLoading.value = false;
        yield []; // You might want to yield an empty list or an error indicator here
      }
    }
  }
  GetSearchItem()
  async {
    if(searchcon.text.isEmpty) {
      return;
    }
    historyseachlist.clear();
    searchState.value=search_state.loading ;
    await addPreviousSearchItem();
    print(searchcon.text);
    try {

      QuerySnapshot querySnapshot;
        querySnapshot = await FirebaseFirestore.instance
            .collection('historycollectionlist')
            .doc(currentuserdata!.userid)
            .collection('hislist')
            .orderBy('timestamp')
            .get();

      if (querySnapshot.docs.isNotEmpty) {

        historyseachlist.addAll(querySnapshot.docs
            .map((el) => His_Model.fromjson(el.data() as Map<String, dynamic>))
            .where((element) => element.title.contains(searchcon.text.toString())));
        print("sucsses");
        print(historyseachlist.length);
        searchState.value=search_state.success;
        update();
      }
    } catch (e) {
      // Handle exceptions, e.g., log or display an error message.
      print('Error fetching data: $e');
    }
  }
  addPreviousSearchItem() async {
    _fetcheddataHelper.addPreviousSearchItem(searchtitle: searchcon.text);

  }


  DeleteSearchitem({required String docid})
  async {

    dataList.removeWhere((element) => element.id == docid);
    _fetcheddataHelper.DeleteSearchitem(docid: docid );

    update();
  }
  Future<void> deleteAllSearchPrev() async {
    _fetcheddataHelper.deleteAllSearchPrev().then((value){
      if(value.requestState==RequestState.success){
        dataList.clear();
      }
    });
    update();
  }
  Searchbyprevitem({required String prevtext})
  {
    searchcon.text=prevtext;
    GetSearchItem();
    update();
  }
}
