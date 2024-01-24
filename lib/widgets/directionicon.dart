import 'package:flutter/cupertino.dart';

import '../core/styles/icons.dart';

class DirectionIcon extends StatelessWidget {
  const DirectionIcon({
    super.key,
    required this.iconcolor,
  });
  final Color iconcolor;

  @override
  Widget build(BuildContext context) {
    return Directionality.of(context)==TextDirection.ltr?Icon(IconBroken.Arrow___Right_2,color: iconcolor,):Icon(IconBroken.Arrow___Left_2,color: iconcolor,);
  }
}
