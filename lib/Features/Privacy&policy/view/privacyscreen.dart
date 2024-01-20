import 'package:flutter/material.dart';
import 'package:quickai/core/constants.dart';
import 'package:quickai/core/manager/colors_manager.dart';
import 'package:quickai/core/manager/text_style_manager.dart';

import '../../../options/Localization_options.dart';

class Privacyscreen extends StatelessWidget {
  const Privacyscreen({Key? key}) : super(key: key);
  static String scid = "/Privacyscreen";

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
    String fileContent = loc.translate("privacysc", "txt0");


    // Split the string into words
    List<String> words = fileContent.split(' ');
    List<String> keywords = ['Qubiko', 'AI,'];

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.translate("privacysc", "sctitle")),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: width/30,vertical: height/120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: words.map((word) {
                    if (keywords.contains(word)) {
                      // Apply custom style to the keyword
                      return TextSpan(
                        text: '$word ',
                        style: getBoldStyle(color: ColorsManager.burble,
                            fontSize: width/20)
                      );
                    } else {
                      // Apply default style to other words
                      return TextSpan(
                        text: '$word ',
                        style: getRegularStyle(
                          color: Colors.black54,
                          fontSize: width / 22,
                        ),
                      );
                    }
                  }).toList(),
                ),
              ),
              SizedBox(height: height/30,),
              Text(loc.translate("privacysc", "title1"),style: getBoldStyle(color: Colors.black,
              fontSize: width/22)),
              Text(loc.translate("privacysc", "txt1"),style: getBoldStyle(color: Colors.black54,
                  fontSize: width/25)),
              SizedBox(height: height/30,),
              Text(loc.translate("privacysc", "title2"),style: getBoldStyle(color: Colors.black,
                  fontSize: width/22)),
              Text(loc.translate("privacysc", "txt2"),style: getBoldStyle(color: Colors.black54,
                  fontSize: width/25)),

            ],
          ),
        ),
      ),
    );
  }
}
