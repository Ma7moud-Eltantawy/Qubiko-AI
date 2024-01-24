import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:quickai/Features/Aboutapp/controller/aboutapp_controller.dart';

import '../Features/Home_Screen/screens/Ai_assistant/controller/Ai_assistant_con.dart';
import '../Features/Splash_Screen/controller/Splash_Controller.dart';
import '../Features/help_center/Screens/FaqsScreen/controller/faqscontroller.dart';
import '../Features/help_center/Screens/contactmescreen/controller/contactme_controller.dart';
import '../Features/help_center/controller/helpcenter_controller.dart';
import '../Features/language/controller/language_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Splash_controller>(() => Splash_controller());
    Get.lazyPut<helpcentercontroller>(() => helpcentercontroller());
    Get.lazyPut<FaqsController>(() => FaqsController());
    Get.lazyPut<ContatctmeController>(() => ContatctmeController());
    Get.lazyPut<AboutappController>(() => AboutappController());
    Get.lazyPut<LanguageController>(() => LanguageController());
    Get.lazyPut<Ai_Assistant_controller>(() => Ai_Assistant_controller());











  }
}