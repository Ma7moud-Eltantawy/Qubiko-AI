import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:quickai/core/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quickai/core/enums.dart';
import 'package:quickai/core/manager/colors_manager.dart';

abstract class PaymentBaseDataSource {
  Future<String> getClientSecret(String amount, String currency);
  Future<void> initializePaymentSheet(String clientSecret);
}

class RemotePaymentDataSource extends PaymentBaseDataSource {
  @override
  Future<String> getClientSecret(String amount, String currency) async {
    try {
      final dio = Dio();
      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer $Secretkey',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        data: {
          'amount': amount,
          'currency': currency,
        },
      );
      return response.data["client_secret"];
    } on DioError catch (e) {
      // Handle Dio errors more explicitly
      throw Exception('Dio error: ${e.message}');
    } catch (error) {
      throw Exception('Failed to get client secret: $error');
    }
  }

  @override
  Future<void> initializePaymentSheet(String clientSecret) async {


    try{
      var gpay = PaymentSheetGooglePay(merchantCountryCode: "GB",
          currencyCode: "GBP",
          testEnv: true);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
         // billingDetails: billingDetails,


          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "quickai",
          googlePay: gpay,
          appearance: PaymentSheetAppearance(

            primaryButton: PaymentSheetPrimaryButtonAppearance(
              shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
              colors: PaymentSheetPrimaryButtonTheme(
                light: PaymentSheetPrimaryButtonThemeColors(
                  background: ColorsManager.burble,
                  text: ColorsManager.white,
                  border: ColorsManager.purble2,
                ),
              ),
            ),
        ),
      ),
      );
    }
    catch(e)
    {
      print(e);
    }

  }
}

class PaymentManager {
  final PaymentBaseDataSource _dataSource;

  PaymentManager(this._dataSource);

  Future<RequestState> makePayment(int amount, String currency) async {
    try {
      final clientSecret = await _dataSource.getClientSecret((amount * 100).toString(), currency);
      print(clientSecret);
      await _dataSource.initializePaymentSheet(clientSecret);
      print("step2");
        await Stripe.instance.presentPaymentSheet();
        print("Success: Payment completed successfully");
      print("step3");
      return RequestState.success;
    } catch (error) {

      return RequestState.failed;
    }
  }
}




///---------------------------------------------------------///




