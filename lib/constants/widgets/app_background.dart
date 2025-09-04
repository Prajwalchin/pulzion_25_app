import 'package:flutter/widgets.dart';
import 'package:pulzion_25_app/constants/images.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImages.appBackground,
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    );
  }
}
