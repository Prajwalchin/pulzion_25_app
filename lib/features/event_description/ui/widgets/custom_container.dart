import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.thechild,
    required this.h,
    required this.w,
  });

  final Widget thechild;
  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height * (h / 812);
    double responsiveWidth = MediaQuery.of(context).size.width * (w / 375);

    return AnimatedGradientBorder(
      borderSize: 2,
      glowSize: 0,
      gradientColors: const [
        Color.fromARGB(255, 11, 140, 120),
        Color.fromARGB(255, 64, 144, 179),
        Color.fromARGB(255, 42, 83, 159),
      ],
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black45,
          ),
          borderRadius: BorderRadius.circular(100), // Set border radius to 100
          color: Colors.black,
        ),
        height: responsiveHeight,
        width: responsiveWidth,
        child: Stack(
          children: [
            SizedBox(
              height: responsiveHeight,
              width: responsiveWidth,
              child: thechild,
            ),
          ],
        ),
      ),
    );
  }
}
