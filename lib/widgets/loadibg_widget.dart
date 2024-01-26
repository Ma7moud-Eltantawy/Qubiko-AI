import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class loadingwidget extends StatelessWidget {
  const loadingwidget({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(


      shaderCallback: (bounds) {
        return RadialGradient(
          center: Alignment.topLeft,
          radius: 2,
          colors: [Color.fromRGBO(126, 146, 248, 1), Color.fromRGBO(126,146 ,248, .9),Color.fromRGBO(126,146 ,248, .8)],
          tileMode: TileMode.repeated,
        ).createShader(bounds);
      },
      child:   Container(
        margin: EdgeInsets.all(width/20),
        padding: EdgeInsets.all(width/20),

        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width/3),
          child: Opacity(
            opacity: .9,
            child: LoadingIndicator(
                indicatorType: Indicator.ballSpinFadeLoader, /// Required, The loading type of the widget
                colors: const [Colors.white],       /// Optional, The color collections
                strokeWidth: 1,

                backgroundColor: Colors.transparent,      /// Optional, Background of the widget
                pathBackgroundColor: Colors.transparent   /// Optional, the stroke backgroundColor
            ),
          ),
        ),
      ),
    );
  }
}