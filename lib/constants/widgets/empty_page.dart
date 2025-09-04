import 'package:flutter/material.dart';
import 'package:pulzion_25_app/constants/images.dart';

import '../colors.dart';
import '../styles.dart';

class EmptyPage extends StatelessWidget {
  final String title;
  final String errorMessage;
  final VoidCallback? refreshFunction;
  final String asset;

  const EmptyPage({
    required this.errorMessage,
    this.asset = AppImages.emptyDialog,
    super.key,
    this.refreshFunction,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.height * 0.02),
      // height: size.height * 0.4,
      width: size.width * 0.6,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.4),
            Colors.black.withOpacity(0.4),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.teal[700]!.withOpacity(0.8),
          width: 0.7,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 1.0,
            spreadRadius: 2.0,
            color: Colors.teal[900]!.withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            asset,
            height: size.height * 0.2,
            width: size.width * 0.6,
          ),
          Text(
            title,
            style: AppStyles.NormalText().copyWith(
              fontSize: 23,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            textAlign: TextAlign.center,
            errorMessage,
            style: AppStyles.NormalText().copyWith(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          if (refreshFunction != null)
            TextButton(
              onPressed: () {
                refreshFunction!();
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
                    style: AppStyles.NormalText()
                        .copyWith(fontSize: 20, color: Colors.white),
                  ),
                ],
              ),
            ),
          SizedBox(
            height: size.height * 0.04,
          )
        ],
      ),
    );
  }
}
