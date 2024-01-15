import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quickai/core/enums.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/models/Userdatamodel.dart';
import 'package:quickai/core/networking/request_result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;

import '../core/constants.dart';

abstract class BaseAuthDataSource{
  Future <void>sendOTP({required String number});
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
        showsnackbar(content: "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showsnackbar(content: "Wrong password provided for that user.");
      }

      return RequestResult(requestState: RequestState.failed,errorMessage: e.message);


    }
  }

  @override
  Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userdata');
    //currentuserdata=null;
    //currentusermoreinfo=null;

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
  Future<void> sendOTP({required String number}) async{
    // TODO: implement sendOTP
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-verification if the SMS code is detected automatically
        await auth.signInWithCredential(credential);
        print("mahmoud");
        print(credential.smsCode);
        // Handle successful verification
      },
      verificationFailed: (FirebaseAuthException e) {
        print("exeption $e");
        // Handle verification failure
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID and show the OTP input UI
        // You can use the verification ID to manually enter the OTP
        print("ver id$verificationId");
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout
        print("ver id 2$verificationId");
      },
    );
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
       showsnackbar(content: "Email Not Verified, Please Check Your Emails");

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
      showsnackbar(content: "Account not found.");
      // You might return a result here indicating an error.
      return RequestResult(requestState: RequestState.failed);
    }
  }

  @override
  Future<RequestResult<verifiedenum>> Verifyaccount({required BuildContext ctx}) async {
    try{

     await FirebaseAuth.instance.currentUser?.sendEmailVerification();

       showsnackbar(content:"Please Check Your Emails");

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







}