import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickai/core/manager/text_style_manager.dart';
import '../../../../core/manager/colors_manager.dart';
import '../../../../core/styles/Local_Styles.dart';
import '../../../../core/styles/icons.dart';
import '../../../../options/Localization_options.dart';

import '../controller/otp_controller.dart';

class OtpScreen extends StatelessWidget {
  static const scid = "otpsc";

  final TextEditingController n1 = TextEditingController();
  final TextEditingController n2 = TextEditingController();
  final TextEditingController n3 = TextEditingController();
  final TextEditingController n4 = TextEditingController();
  final TextEditingController n5 = TextEditingController();
  final TextEditingController n6 = TextEditingController();

  String txt = "";
  final controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var loc= AppLocalizations.of(context);
    var height = size.height;
    var width = size.width;

    return GetBuilder<OtpController>(
      builder:(con)=> Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width / 13),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      loc.translate(scid, "title"),
                      style: getBoldStyle(color: Colors.black, fontSize: width/14)
                    ),

                    Text(
                      loc.translate(scid, "hint"),

                      style: getRegularStyle(color: Colors.black54, fontSize: width/22)
                    ),
                    SizedBox(
                      height: height / 15,
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 4,
                      direction: Axis.horizontal,
                      runSpacing: 10,
                      children: [
                        _otpTextField(context, false, 1, n1,controller),
                        _otpTextField(context, false, 2, n2,controller),
                        _otpTextField(context, false, 3, n3,controller),
                        _otpTextField(context, false, 4, n4,controller),
                        _otpTextField(context, false, 5, n5,controller),
                        _otpTextField(context, false, 6, n6,controller),
                      ],
                    ),
                    SizedBox(
                      height: height / 15,
                    ),
                    Text(
                        loc.translate(scid, "check"),

                        style: getRegularStyle(color: Colors.black54, fontSize: width/22)
                    ),
                    SizedBox(
                      height: height / 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "${loc.translate(scid, "hintcheck")} ",

                            style: getRegularStyle(color: Colors.black54, fontSize: width/22)
                        ),
                        Text(
                            " ${con.countdown.toString()} ",

                            style: getRegularStyle(color: ColorsManager.burble, fontSize: width/22)
                        ),
                        Text(
                            "${loc.translate(scid, "timecode")}",

                            style: getRegularStyle(color: Colors.black54, fontSize: width/22),

                        ),
                      ],
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpTextField(BuildContext context, bool autoFocus, int num, TextEditingController con,OtpController controller) {
    return Container(
      height: MediaQuery.of(context).size.shortestSide * 0.13,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: TextField(
          maxLength: 1,
          controller: con,
          autofocus: autoFocus,
          decoration: InputDecoration(
            counter: Offstage(),
            border: InputBorder.none,
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(),
          cursorColor: ColorsManager.red,
          maxLines: 1,
          onTap: () {},
          onChanged: (value) {
            txt = n1.text + n2.text + n3.text + n4.text + n5.text + n6.text;

            print(txt);
            print(value.toString());
            if(controller.otptxt.length<txt.length)
              {
                controller.otptxt=txt.toString();
                print(controller.otptxt);
                if (txt.length != 6 && num != 6) {

                  FocusScope.of(context).nextFocus();
                }
                if(txt.length == 6 && num == 6)
                  {
                    print("function call");
                    FocusScope.of(context).requestFocus(FocusNode());
                    controller.verifyOTP();

                  }
              }
            else
              {
                controller.otptxt=txt.toString();
                print(controller.otptxt);
                if (txt.length != 6 && num != 1) {

                  FocusScope.of(context).previousFocus();
                }

              }

          },
        ),
      ),
    );
  }
}

