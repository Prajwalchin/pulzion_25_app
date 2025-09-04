import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pulzion_25_app/constants/widgets/app_background.dart';
import 'package:pulzion_25_app/constants/widgets/custom_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/size_config.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';
import '../../../constants/urls.dart';

class CompulsoryUpdatePage extends StatelessWidget {
  const CompulsoryUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Stack(
      children: [
        const AppBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.teal,
                    )),
                child: Image.asset(
                  AppImages.softwareUpdate,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                '<Update Available/>',
                style: AppStyles.NormalText().copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.04,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                child: Text(
                  textAlign: TextAlign.center,
                  'Seems like you are using an older version of the app.\nPlease update the app to the latest version to continue using it.',
                  style: AppStyles.NormalText().copyWith(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                    left: MediaQuery.of(context).size.width * 0.25,
                    right: MediaQuery.of(context).size.width * 0.2,
                  ),
                  child: TechButton(
                    buttonText: 'Update',
                    scale: 1.3,
                    onTap: () async {
                      if (Platform.isAndroid || Platform.isIOS) {
                        final String playStoreUrl =
                            (EndPoints.playStoreURL == null ||
                                    EndPoints.playStoreURL == '')
                                ? ((EndPoints.websiteURL == null ||
                                        EndPoints.websiteURL == '')
                                    ? "https://pulzion.co.in"
                                    : EndPoints.websiteURL!)
                                : EndPoints.playStoreURL!;
                        final Uri url = Uri.parse(playStoreUrl);
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
