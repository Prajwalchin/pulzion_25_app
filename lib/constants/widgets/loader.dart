import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:glowy_borders/glowy_borders.dart';

import '../images.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Center(
        child: CustomContainerLoader(
      h: size.height * 0.25,
      w: size.width * 0.8,
      radius: 20,
      thechild: Container(
        height: size.height * 0.25,
        width: size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
            border: Border.all(
                color: const Color.fromARGB(255, 27, 154, 170), width: 1),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromARGB(255, 16, 108, 124).withOpacity(0.8),
                  const Color.fromARGB(255, 10, 98, 89).withOpacity(0.2),
                  const Color.fromARGB(255, 33, 177, 221).withOpacity(0.3)
                ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle(
              style: const TextStyle(
                  fontSize: 30.0, fontFamily: 'Wallpoet', color: Colors.amber),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Loading_',
                    speed: const Duration(milliseconds: 140),
                  ),
                ],
                onTap: () {
                  //log("Tap Event");
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Image.asset(
              AppImages.loader,
              width: size.width * 0.4,
              height: size.height * 0.019,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
          ],
        ),
      ),
    ));
  }
}

class CustomContainerLoader extends StatelessWidget {
  const CustomContainerLoader(
      {super.key,
      required this.thechild,
      required this.h,
      required this.w,
      required this.radius});

  final Widget thechild;
  final double h;
  final double w;

  final double radius;

  @override
  Widget build(BuildContext context) {
    double responsiveHeight = MediaQuery.of(context).size.height * (h / 812);
    double responsiveWidth = MediaQuery.of(context).size.width * (w / 375);

    return AnimatedGradientBorder(
      borderSize: 1.2,
      glowSize: 0,
      gradientColors: const [
        Color.fromARGB(255, 11, 140, 120),
        Color.fromARGB(255, 64, 144, 179),
        Color.fromARGB(255, 42, 83, 159),
      ],
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius:
              BorderRadius.circular(radius), // Set border radius to 100
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
