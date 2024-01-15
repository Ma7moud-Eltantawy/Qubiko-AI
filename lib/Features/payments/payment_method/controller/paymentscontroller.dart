import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:get/get.dart';
import 'package:quickai/Features/on_boarding/view/on_boarding_screen.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/enums.dart';
import 'package:quickai/data/Payment_helper.dart';

import '../../../../core/entities/proplanitems.dart';
import '../../../../core/utils/functions.dart';
import '../../review_summary/view/reviewSummary_Screen.dart';
import '../../upgrade_to_pro/controller/proplacontrooler.dart';


class PaymentController extends GetxController {


  final PaymentBaseDataSource dataSource = RemotePaymentDataSource();
  late final PaymentManager payment;
  RxBool isCheckoutLoading = false.obs;
  bool progresshudstate=false;


  late PaymentMethod selectedPaymentMethod;
  late PaymentMethodItem selectedpaymentmethoditem;
  late Proplandataitem proplandataitem;
  List<PaymentMethodItem> paymentItems = [
    PaymentMethodItem(imgAsset: "assets/img/Stripe_icon.svg", title: "Stripe", paymentMethod: PaymentMethod.stripe),
    PaymentMethodItem(imgAsset: "assets/img/paypal.svg", title: "PayPal", paymentMethod: PaymentMethod.paypal),
  ];
  Proplasncontroller controller=Get.put(Proplasncontroller());

  @override
  void onInit() {
    super.onInit();
    payment = PaymentManager(dataSource);
    selectedPaymentMethod= PaymentMethod.nopay;
    print(controller.paymentplan.toString());
    proplandataitem=getproplandata(plan: controller.paymentplan);

    // Any additional initialization logic can go here
  }

  Future<void> makePayment() async {
    print(selectedPaymentMethod);
    if (selectedPaymentMethod == PaymentMethod.stripe)
      {
        payment.makePayment(proplandataitem.total , "USD").then((value) {
          if(value==RequestState.success)
            {
              changeprogresshudstate();
            }
          else
          {
            snackBarError(
                "error found when payment process."
            );
          }

        });
      }
    if (selectedPaymentMethod == PaymentMethod.paypal)
    {
       initiatePaypalCheckout(proitem:proplandataitem );
    }


    update();
  }

  void changeIndexCheck(int index, bool indexValue) {
    paymentItems.forEach((item) => item.checkboxState = false);
    paymentItems[index].checkboxState = indexValue;

    if (indexValue) {
      selectedPaymentMethod = paymentItems[index].paymentMethod;
    }
    else{
      selectedPaymentMethod = PaymentMethod.nopay;
    }
    print(selectedPaymentMethod);

    update();
  }


  Future<void> initiatePaypalCheckout({required Proplandataitem proitem}) async {
    try {
      final result = await Get.to(() => PaypalCheckout(
        sandboxMode: true,
        clientId: "AYQ68ierakZ4f95eLnWumYseWp0EHR99GQoucj53cpeaAGEAkU9s5DiJE4ZRSLxbYzVqnDyHyzimCD17",
        secretKey: "EIV3fZ_oYcpAzOj2ZuIPz1ihmVWh8qqMMK0WiH9slnMGup6suVwcHiB_GWH80NxpGoSrAroGJ13ZBSZu",
        returnURL: "https://cdn.dribbble.com/users/911154/screenshots/3332845/media/20e5d28e19e4f52c634fd3786a5a1a28.gif", // Replace with your actual return URL
        cancelURL: "https://www.paypal.com/eg/home", // Replace with your actual cancel URL
        transactions:  [
          {
            "amount": {
              "total": "${proitem.total}",
              "currency": "USD", // Use a valid ISO currency code (e.g., "USD" for US Dollar)
              "details": {
                "subtotal":"${proitem.amount}",
                "tax": "${proitem.tax}",
                "shipping_discount": 0
              }
            },

          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          print("onSuccess: $params");
          changeprogresshudstate();

        },
        onError: (error) {
          print("onError: $error");
          Get.back();
          snackBarError(
            "error found when payment process."
          );
        },
        onCancel: () {
          print('cancelled:');
          snackBarError(
              "payment process canceled."
          );
        },
      ),
      transition: kTransition2,
        duration: kTransitionDuration

      );
      isCheckoutLoading(result);
    } catch (error) {
      print("Error during PayPal checkout: $error");
    }
  }
   continuepayment()
   {
     if(selectedPaymentMethod!=PaymentMethod.nopay)
       {
         if(selectedPaymentMethod==PaymentMethod.paypal)
           {
             selectedpaymentmethoditem=paymentItems[1];

           }
         if(selectedPaymentMethod==PaymentMethod.stripe)
         {
           selectedpaymentmethoditem=paymentItems[0];

         }

         Get.to(()=>reviewsummaryScreen(),transition: kTransition2,duration: kTransitionDuration);
       }


   }
   changeprogresshudstate()
   {
     progresshudstate=!progresshudstate;
     update();
   }



}

class PaymentMethodItem {
  final String imgAsset;
  final String title;
  final PaymentMethod paymentMethod;
  bool checkboxState;

  PaymentMethodItem({
    required this.imgAsset,
    required this.title,
    required this.paymentMethod,
    this.checkboxState = false,
  });
}
