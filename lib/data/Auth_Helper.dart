import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/core/enums.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/models/Userdatamodel.dart';
import 'package:quickai/core/networking/request_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickai/options/Localization_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;

import '../core/constants.dart';
import '../core/utils/functions.dart';

abstract class BaseAuthDataSource{
  Future <RequestResult<String>>sendOTP({required String number});
  Future <RequestResult>activeByphone({required String verifyid,required String smscode});

  Future<RequestResult<UserCredential>>SignUp({
    required String email,
    required String pass,
    required BuildContext ctx,

  });
  Future<RequestResult<UserCredential>>login({
    required String email,
    required String pass,
  });
  Future<RequestResult<OAuthCredential>>loginwithgoogle();
  Future<RequestResult<verifiedenum>>checkEmailVerified();
  Future<RequestResult<verifiedenum>>Verifyaccount({required BuildContext ctx});


  Future<RequestResult<Userdatamodel>>Getuserdata({required String id});
  Future<RequestResult<RequestState>>uploaduserdata({required Userdatamodel user});
  Future<RequestResult<String>>Uploadimgtostorage({required XFile img});
  Future<void> sendPasswordResetEmail({required String email});



  Future<void> logout();
}

class AuthRemoteDataSource implements BaseAuthDataSource{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Future<RequestResult<UserCredential>> SignUp(
      {required String email, required String pass,required BuildContext ctx}) async {
    late UserCredential credential;

    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return RequestResult(
        requestState: RequestState.success,
        data: credential,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(
              backgroundColor: ColorsManager.white,

                content: Text('The password provided is too weak.',style: TextStyle(color: ColorsManager.burble))));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(ctx).showSnackBar(

            const SnackBar(
                backgroundColor: Colors.white,
                content: Text('The account already exists for that email.',style: TextStyle(color: ColorsManager.burble))));
      }
      return RequestResult(
        requestState: RequestState.failed,
      );
    }
  }

  @override
  Future<RequestResult<UserCredential>> login({required String email, required String pass}) async{
    late UserCredential credential;
    try{
      credential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
      return RequestResult(requestState: RequestState.success,data: credential);
    }
    on FirebaseAuthException catch(e)
    {
      if (e.code == 'user-not-found') {
        showsnackbar(content: AppLocalizations.of(Get.context!).translate("snackbarmsg", "usernotfound"));
      } else if (e.code == 'wrong-password') {
        showsnackbar(content: AppLocalizations.of(Get.context!).translate("snackbarmsg", "wrongpass"));
      }

      return RequestResult(requestState: RequestState.failed,errorMessage: e.message);


    }
  }

  @override
  Future<void> logout() async{
    try {
      await FirebaseAuth.instance.signOut();
    }
    catch(e)
    {
      print(e);
    }
  }

  @override
  Future<RequestResult<OAuthCredential>> loginwithgoogle() async{
    final GoogleSignIn googleSignIn = await GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    late  OAuthCredential credential;
    try{
      credential= GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print(credential.toString());
      return RequestResult(requestState: RequestState.success,data: credential);
    }
    on FirebaseAuthException catch(e)
    {

      return RequestResult(requestState: RequestState.failed,errorMessage: e.message);

    }
  }
  @override
  Future<RequestResult<String>> sendOTP({required String number}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
     String ? _verificationId;
    try{

      await auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!
          // Sign the user in (or link) with the auto-generated credential
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException error) {
          print(error);
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          print(forceResendingToken);
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: "123456",
          );
          _verificationId=verificationId;
          print(credential.smsCode);

        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print(verificationId);
        },
      );
      return RequestResult(requestState: RequestState.success,data: _verificationId);

    }
    on FirebaseException catch(e)
    {
      return RequestResult(requestState: RequestState.failed);


    }
}

  @override
  Future<RequestResult<RequestState>> uploaduserdata({required Userdatamodel user}) async {

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    try{
      await _firestore.collection("user_data").doc("${user.userid}").set(user.tojson(),);
      return RequestResult(requestState: RequestState.success,data: RequestState.success);
    }
    catch(e)
    {
      return RequestResult(requestState: RequestState.success,data: RequestState.failed);


    }


  }



  @override
  Future<RequestResult<Userdatamodel>> Getuserdata({required String id}) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    Userdatamodel? userdata;

    try {
      final snapshot = await _firestore.collection("user_data").doc(id).get();

      if (snapshot.exists) {
        userdata = Userdatamodel.fromjson(snapshot.data() as Map<String, dynamic>);
        print(userdata.userid);
        //print(userdata.imglink);


        return RequestResult(requestState: RequestState.success, data: userdata);
      } else {
        // User not found
        return RequestResult(requestState: RequestState.failed, errorMessage: "User not found");
      }
    } catch (e) {
      print(e);
      return RequestResult(requestState: RequestState.failed, errorMessage: e.toString());
    }
  }









  @override
  Future<RequestResult<String>> Uploadimgtostorage({required XFile img}) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    try{
      final String fileName = path.basename(img.path);
      print(fileName);
      final imagefile=File(img.path);
      print(imagefile);
      print("object");

      var StorageTaskSnapshot = await storage.ref(fileName).putFile(
          imagefile);
      print(StorageTaskSnapshot.toString());
      String url = await StorageTaskSnapshot.ref.getDownloadURL();
      return RequestResult(requestState: RequestState.success,data: url);


    }
    catch(e){
      return RequestResult(requestState: RequestState.success,errorMessage: e.toString());
    }
  }

  @override
  Future<RequestResult<verifiedenum>> checkEmailVerified() async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      bool isEmailVerified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;

      if (!isEmailVerified) {
        showsnackbar(content: AppLocalizations.of(Get.context!).translate("snackbarmsg", "notverify"));


        // You might return a result here indicating that email is not verified.
        return RequestResult(requestState: RequestState.success,data:verifiedenum.notverify);
      } else {
        // You might return a result here indicating that email is verified.
        //FirebaseAuth.instance.currentUser?.sendEmailVerification();
        return RequestResult(requestState: RequestState.success,data: verifiedenum.Verify);
      }
    } catch (e) {
      // Handle errors during email verification
      print("Error during email verification: $e");
      // You might return a result here indicating an error.
      return RequestResult(requestState: RequestState.failed);
    }
  }

  @override
  Future<RequestResult<verifiedenum>> Verifyaccount({required BuildContext ctx}) async {
    try{

     await FirebaseAuth.instance.currentUser?.sendEmailVerification();
     showsnackbar(content: AppLocalizations.of(Get.context!).translate("snackbarmsg", "verifymsg"));

      return RequestResult(requestState: RequestState.failed,data: verifiedenum.Verify);



    }
    catch(e)
    {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 5), // Set the duration for the snackbar
        ),
      );
      return RequestResult(requestState: RequestState.failed);
    }
  }
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );

      print('Password reset email sent to $email');
      // You can inform the user that the password reset email has been sent
    } catch (e) {
      print('Error sending password reset email: $e');
      // Handle the error appropriately, e.g., show a message to the user
    }
  }

  @override
  Future<RequestResult> activeByphone({required String verifyid,required String smscode}) async{
    FirebaseAuth auth = FirebaseAuth.instance;

    try{
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verifyid,
          smsCode: smscode,);
      await auth.signInWithCredential(credential);

      return RequestResult(requestState: RequestState.success);
    }
    catch(e)
    {
      return RequestResult(requestState: RequestState.failed);
    }

  }






}