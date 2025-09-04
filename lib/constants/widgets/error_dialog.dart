import 'package:flutter/material.dart';
import 'package:pulzion_25_app/constants/audio.dart';

import '../colors.dart';
import '../images.dart';
import '../styles.dart';

class ErrorDialog extends StatefulWidget {
  final String errorMessage;
  final VoidCallback? refreshFunction;

  const ErrorDialog(
    this.errorMessage, {
    super.key,
    this.refreshFunction,
  });

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  void initState() {
    super.initState();
    Singleton().player.playError();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: size.height * 0.40,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 16, 108, 124).withOpacity(0.3),
              const Color.fromARGB(255, 10, 98, 89).withOpacity(0.2),
              const Color.fromARGB(255, 4, 71, 91).withOpacity(0.3)
            ]),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color.fromARGB(255, 18, 166, 185).withOpacity(0.9),
              width: 0.7,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.1),
              Text(
                'Error',
                style: AppStyles.bodyTextStyle2().copyWith(
                    fontSize: 35, fontFamily: 'Wallpoet', color: Colors.amber),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  widget.errorMessage,
                  style: AppStyles.NormalText().copyWith(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (widget.refreshFunction != null) {
                    widget.refreshFunction!();
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.refresh_rounded,
                      color: AppColors.white,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      textAlign: TextAlign.center,
                      'Retry',
                      style: AppStyles.NormalText().copyWith(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          // bottom: size.height * 1,
          // left: size.width * 0.2,
          left: size.width * 0.23,
          bottom: size.height * 0.30,
          child: Container(
            padding: const EdgeInsets.only(right: 5, bottom: 2),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(200),
              // border: Border.all(
              //   color: const Color.fromARGB(255, 18, 166, 185).withOpacity(0.9),
              //   width: 1
              // )
            ),
            child: Image.asset(
              // color: Colors.black,
              // AppImages.errorImg,
              AppImages.errorImg,
              // height: size.height * 0.3,
              // width: size.width * 0.65,
            ),
          ),
        ),
      ],
    );
  }
}
