import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickai/core/enums.dart';
import 'package:quickai/core/networking/request_result.dart';
import 'package:quickai/data/DB_Helper.dart';
import 'package:uuid/uuid.dart';

import '../core/constants.dart';
import '../core/models/His_model.dart';

abstract class BaseFetcheddataHelper {
  Future<RequestResult> addPreviousSearchItem({required String searchtitle});
  Future<RequestResult> deleteAllSearchPrev();
  Future<RequestResult>DeleteSearchitem({required String docid});
  Future<RequestResult> deleteAllHistory();
  Future<RequestResult>DeleteHistoryitem({required String docid,required String msgdoc});


}

class RemoteDBhelperdatasource implements BaseFetcheddataHelper{
  @override
  Future<RequestResult> DeleteSearchitem({required String docid}) async {
    try {
      print(docid);
      await FirebaseFirestore.instance
          .collection('history')
          .doc(currentuserdata!.userid)
          .collection('search_prev')
          .doc(docid)
          .delete();

      print('Document deleted successfully.');
      return RequestResult(requestState: RequestState.success);
    } catch (e) {
      print('Error deleting document: $e');
      return RequestResult(requestState: RequestState.failed);
    }
  }




  @override
  Future<RequestResult> addPreviousSearchItem({required String searchtitle}) async {
    var uuid = Uuid();
    String id = uuid.v4();

    print("Generated ID: $id");
    try {
      await FirebaseFirestore.instance
          .collection('history')
          .doc(currentuserdata!.userid)
          .collection('search_prev') // Corrected collection name
          .doc(id)
          .set(
          His_Model(
            title:searchtitle,
            timestamp: DateTime.now().toString(),
            id: id,
          ).tojson()

      );
      return RequestResult(requestState:RequestState.success );
    } catch (e) {
      print("Error adding previous search item: $e");
      return RequestResult(requestState:RequestState.success );
    }
  }

  @override
  Future<RequestResult> deleteAllSearchPrev() async {
    try {

      CollectionReference searchPrevCollection = FirebaseFirestore.instance
          .collection('history')
          .doc(currentuserdata!.userid)
          .collection('search_prev');

      QuerySnapshot querySnapshot = await searchPrevCollection.get();
      WriteBatch batch = FirebaseFirestore.instance.batch();
      querySnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });

      await batch.commit();
      print('All documents in search_prev deleted successfully.');
      return RequestResult(requestState: RequestState.success);
    } catch (error) {
      print('Error deleting documents: $error');
      return RequestResult(requestState: RequestState.failed);
    }
  }

  @override
  Future<RequestResult> DeleteHistoryitem({required String docid,required String msgdoc}) async {
    try {
      print(docid);
      await FirebaseFirestore.instance
          .collection('historycollectionlist')
          .doc(currentuserdata!.userid)
          .collection('hislist')
          .doc(docid)
          .delete();

      CollectionReference searchPrevCollection = FirebaseFirestore.instance
          .collection('historydata')
          .doc(currentuserdata!.userid)
          .collection('history').doc(msgdoc).collection("msgs");

      QuerySnapshot querySnapshot = await searchPrevCollection.get();
      WriteBatch batch = FirebaseFirestore.instance.batch();
      querySnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });


      print('Document deleted successfully.');
      return RequestResult(requestState: RequestState.success);
    } catch (e) {
      print('Error deleting document: $e');
      return RequestResult(requestState: RequestState.failed);
    }
  }

  @override
  Future<RequestResult> deleteAllHistory() async {
    try {

      CollectionReference searchPrevCollection1 = FirebaseFirestore.instance
          .collection('historycollectionlist')
          .doc(currentuserdata!.userid)
          .collection('hislist');

      QuerySnapshot querySnapshot1 = await searchPrevCollection1.get();
      WriteBatch batch1 = FirebaseFirestore.instance.batch();
      querySnapshot1.docs.forEach((doc) {
        batch1.delete(doc.reference);
      });

      await batch1.commit();
      print('All documents in search_prev deleted successfully.');


      CollectionReference searchPrevCollection = FirebaseFirestore.instance
          .collection('historydata')
          .doc(currentuserdata!.userid)
          .collection('history');

      QuerySnapshot querySnapshot = await searchPrevCollection.get();
      print(querySnapshot.docs.length);
      WriteBatch batch = FirebaseFirestore.instance.batch();
      querySnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
        print("deleted");
      });
      await batch.commit();


      print('History deleted successfully.');
      return RequestResult(requestState: RequestState.success);
    } catch (e) {
      print('History deleting document: $e');
      return RequestResult(requestState: RequestState.failed);
    }
  }

}