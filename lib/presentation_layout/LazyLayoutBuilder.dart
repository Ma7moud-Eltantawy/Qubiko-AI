import 'dart:developer';

import 'package:flutter/material.dart';

import '../core/utils/sizeconfig.dart';

class LazyLayoutBuilder extends StatelessWidget {
  const LazyLayoutBuilder(
      {super.key,
        required this.mobileLayoutView,
        required this.tabletLayoutView,});

  final WidgetBuilder mobileLayoutView, tabletLayoutView;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < SizeConfig.tabletBreakPoint) {
          return mobileLayoutView(context);
        } else  {
          return tabletLayoutView(context);
        }
      },
    );
  }
}
