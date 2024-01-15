import 'dart:async';

import 'package:quickai/core/enums.dart';
import 'package:quickai/core/models/His_model.dart';
import 'package:quickai/core/models/previousSearchItemModel.dart';
import 'package:quickai/core/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

enum search_state {
  previous,
  loading,
  success,
  failed,
}


class Searchscreencontroller extends GetxController {

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

    paginatedDataStream.listen((dataList) {
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



  Stream<List<PrevSearchmodel>> get paginatedDataStream async* {
    DocumentSnapshot? lastDocument;

    while (true) {
      try {
        isLoading.value = true;

        Query<Map<String, dynamic>> query = FirebaseFirestore.instance
            .collection('history')
            .doc('oMI8mG5Ei7Ty9KV9XCYMxxYeVYk1')
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
            .collection('history')
            .doc('oMI8mG5Ei7Ty9KV9XCYMxxYeVYk1')
            .collection('history')
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
  Future<RequestState> addPreviousSearchItem() async {
    var uuid = Uuid();
    String id = uuid.v4();

    print("Generated ID: $id");
    try {
      await FirebaseFirestore.instance
          .collection('history')
          .doc('oMI8mG5Ei7Ty9KV9XCYMxxYeVYk1')
          .collection('search_prev') // Corrected collection name
          .doc(id)
          .set(
        His_Model(
            title: searchcon.text,
          timestamp: DateTime.now().toString(),
          id: id,
        ).tojson()

      );
      return RequestState.success;
    } catch (e) {
      print("Error adding previous search item: $e");
      return RequestState.failed;
    }
  }


  DeleteSearchitem({required String docid})
  async {


    print(docid);
    dataList.removeWhere((element) => element.id == docid);
    print("------------------------------------------");
    print(dataList.length);

    await FirebaseFirestore.instance
        .collection('history')
        .doc('oMI8mG5Ei7Ty9KV9XCYMxxYeVYk1')
        .collection('search_prev')
        .doc(docid)
        .delete()
        .then((value) {

      print('Document deleted successfully.');



    })
        .catchError((error) {
      searchState=search_state.failed as Rx<search_state>;
          snackBarError("try agin");
          print('Error deleting document: $error');

    });
    update();
  }
  Future<void> deleteAllSearchPrev() async {
    try {

      CollectionReference searchPrevCollection = FirebaseFirestore.instance
          .collection('history')
          .doc('oMI8mG5Ei7Ty9KV9XCYMxxYeVYk1')
          .collection('search_prev');

      QuerySnapshot querySnapshot = await searchPrevCollection.get();
      WriteBatch batch = FirebaseFirestore.instance.batch();
      querySnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });

      await batch.commit();
      dataList.clear();
      print('All documents in search_prev deleted successfully.');
    } catch (error) {
      snackBarError('Error deleting documents: $error');
      print('Error deleting documents: $error');
    }

    update();
  }
  Searchbyprevitem({required String prevtext})
  {
    searchcon.text=prevtext;
    GetSearchItem();
    update();
  }
}
