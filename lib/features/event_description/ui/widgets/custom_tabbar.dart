import 'package:flutter/material.dart';
import 'package:pulzion_25_app/config/size_config.dart';

class CustomTabsView extends StatelessWidget {
  const CustomTabsView({
    super.key,
    required this.tabIndex,
    required this.firstTab,
    required this.secondTab,
    required this.thirdTab,
    required this.fourthTab,
  });

  final int tabIndex;
  final Widget firstTab;
  final Widget secondTab;
  final Widget thirdTab;
  final Widget fourthTab;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedContainer(
          width: SizeConfig.screenWidth,
          transform: Matrix4.translationValues(
              tabIndex == 0 ? 0 : SizeConfig.screenWidth!, 0, 0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          child: firstTab,
        ),
        AnimatedContainer(
          width: SizeConfig.screenWidth,
          transform: Matrix4.translationValues(
              tabIndex == 1 ? 0 : SizeConfig.screenWidth!, 0, 0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          child: secondTab,
        ),
        AnimatedContainer(
          width: SizeConfig.screenWidth,
          transform: Matrix4.translationValues(
              tabIndex == 2 ? 0 : SizeConfig.screenWidth!, 0, 0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          child: thirdTab,
        ),
        AnimatedContainer(
          width: SizeConfig.screenWidth,
          transform: Matrix4.translationValues(
              tabIndex == 3 ? 0 : SizeConfig.screenWidth!, 0, 0),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
          child: fourthTab,
        )
      ],
    );
  }
}
