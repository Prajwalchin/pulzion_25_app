import 'package:flutter/material.dart';
import 'package:pulzion_25_app/constants/images.dart';

import '/constants/styles.dart';

Widget cardDesign(
  String data,
  double h,
  double w,
  var value,
  Widget iconWidget,
) {
  return Center(
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: h * 0.01),
                child: Stack(
                  children: [
                    SizedBox(
                      height: h * 0.11,
                      width: w * 0.88,
                      child: Image.asset(
                        AppImages.cartFrame,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: h * 0.05,
                      left: w * 0.04,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.06),
                            child: iconWidget,
                          ),
                          SizedBox(width: w * 0.05),
                          LimitedBox(
                            maxWidth: w - w * 0.4,
                            child: FittedBox(
                              child: Center(
                                child: Text(
                                  value.toString().toUpperCase(),
                                  style: AppStyles.NormalText().copyWith(
                                    fontSize: h * 0.027,
                                    color: Colors.amberAccent,
                                    fontFamily: 'VT323',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: h * 0.025,
          left: h * 0.018,

          child: Container(
            padding: EdgeInsets.only(left: w * 0.03),
            width: w / 3.5,
            child: Text(
              (data.toString()[0].toUpperCase() +
                  data.toString().substring(1).toLowerCase()),
              style: AppStyles.NormalText().copyWith(
                color: const Color.fromARGB(255, 36, 199, 183),
                fontSize: w * 0.047,
              ),
            ),
          ),
          //   ),
        ),
      ],
    ),
  );
}
