import 'package:flutter/material.dart';
import 'package:quickai/presentation_layout/tablet_layout_view.dart';

import '../../../../../core/utils/sizeconfig.dart';
import '../../../../../presentation_layout/LazyLayoutBuilder.dart';
import '../../../../../presentation_layout/mobile_layout_view.dart';
import '../../../../../widgets/navigation_drawer_widget.dart';


class HomepageLayout extends StatelessWidget {
   HomepageLayout({super.key});
   static const scid="/HomepageLayout";

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      /*appBar: MediaQuery.sizeOf(context).width<SizeConfig.tabletBreakPoint? AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
              setState(() {

              });
            },
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.white,
            )),
      ):null,*/
      body: LazyLayoutBuilder(
          mobileLayoutView: (context) => const MobileLayoutView(),
          tabletLayoutView: (context) => const TabletLayoutView(),
         ),
    );
  }
}
