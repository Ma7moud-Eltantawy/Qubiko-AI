import 'package:flutter/material.dart';

import '../Features/Home_Screen/home/presentation/view/Home_Screen_view.dart';
import '../widgets/navigation_drawer_widget.dart';



class TabletLayoutView extends StatelessWidget {
  const TabletLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(flex: 46, child: NavigationDrawerWidget()),
        SizedBox(
          width: 28.0,
        ),
        Expanded(
          flex: 100,
          child: Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Home_screen(),
          ),
        ),
      ],
    ) ;
  }
}

