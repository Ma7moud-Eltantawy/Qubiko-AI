



import 'dart:convert';

import 'package:quickai/core/networking/request_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants.dart';
import '../core/enums.dart';
import '../core/models/Userdatamodel.dart';


abstract class BaseDBhelperdatasource {

  Future<void>SaveuserinDB({required Userdatamodel user});
  Future<RequestResult<Userdatamodel>>getuserfromDB();
  Future<void>cleanDB();
  Future<RequestResult>OnBoardingseen();
  Future<RequestResult<Onboardseenenum>>OnBoardingseencheck();




}
class RemoteDBhelperdatasource implements BaseDBhelperdatasource{
  @override
  Future<RequestResult<Userdatamodel>> getuserfromDB() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonString =await prefs.getString('userdata');
      Map<String, dynamic> jsonMap = json.decode(jsonString!);
      currentuserdata=Userdatamodel.fromjson(jsonMap);
      print("get from db");


      return RequestResult(requestState: RequestState.success,data:Userdatamodel.fromjson(jsonMap));
    }
    catch(e)
    {
      return RequestResult(requestState: RequestState.failed,errorMessage: e.toString());
    }

  }


  @override
  Future<void> cleanDB() async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('userdata');
    }
    catch(e)
    {
      print(e);
    }
  }


  @override
  Future<void> SaveuserinDB({required Userdatamodel user}) async {

    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonstring=json.encode(user.tojson());
      prefs.setString('userdata', jsonstring);
      print("save in db");
    }
    catch(e)
    {
      print(e);
    }


  }

  @override
  Future<RequestResult> OnBoardingseen() async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
       prefs.setBool('onboardingseen',true);
       return RequestResult(requestState: RequestState.success);

    }
    catch(e)
    {
      return RequestResult(requestState: RequestState.failed);

    }
  }

  @override
  Future<RequestResult<Onboardseenenum>> OnBoardingseencheck() async {
    Onboardseenenum onboardstate=Onboardseenenum.NotSeen;
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool seen = prefs.getBool('onboardingseen') ?? false;
      seen==true?onboardstate=Onboardseenenum.Seen:onboardstate=Onboardseenenum.NotSeen;
      return RequestResult(requestState: RequestState.success,data: onboardstate);

    }
    catch(e)
    {
      return RequestResult(requestState: RequestState.success,data: onboardstate);

    }
  }




}



