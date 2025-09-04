import 'dart:math';

import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulzion_25_app/constants/audio.dart';
import 'package:pulzion_25_app/constants/images.dart';
import 'package:pulzion_25_app/constants/widgets/app_background.dart';
import 'package:pulzion_25_app/features/event_description/ui/widgets/custom_container.dart';
import 'package:pulzion_25_app/project/cubit/animation_toggle_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '/features/home_page/ui/wigets/custom_appbar.dart';
import '../../../constants/styles.dart';

class AboutUsPage extends StatefulWidget {
  bool isAppbar;

  AboutUsPage(this.isAppbar, {super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    with SingleTickerProviderStateMixin {
  final String aboutPulzion =
      "Pulzion is the annual technical fest organized by PICT ACM Student Chapter. Pulzion has hosted multiple events including coding competition ranging from amateur competitions two day-long as well as mock placements, business management based and quizzing events. It has become one of the most anticipated events taking place at PICT with participants from colleges all over Pune. With high aspirations, backed with sincerity and dedication, the PASC team aims to add value to the college and all the people in it.";

  AnimationController? _animationController;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    if (_animationController == null) {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 100,
        ),
      ); // Reduced the duration for faster rotation

      _rotation = Tween(begin: 0.0, end: 2 * pi).animate(_animationController!);

      _animationController?.repeat();
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Future<void> _launchUniversalLinkApp(String url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  Future<void> openWhatsAppChat(String phoneNumber) async {
    Singleton().player.playClick();
    final whatsappUrl = Uri.parse('whatsapp://send?phone=$phoneNumber');
    if (!await launchUrl(whatsappUrl)) {
      throw 'Could not launch WhatsApp URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    _animationController?.repeat();
    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Stack(
      children: [
        BlocConsumer<GlobalParameterCubit, bool>(
          listener: (context, state) {},
          buildWhen: (previous, current) {
            if (previous != current) {
              return true;
            }

            return false;
          },
          builder: (context, state) {
            return const AppBackground();
          },
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: widget.isAppbar ? const CustomAppBar() : null,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(width / 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height / 50),
                      child: CustomContainer(
                        w: MediaQuery.of(context).size.width * 0.7,
                        h: MediaQuery.of(context).size.height * 0.1,
                        thechild: Padding(
                            padding: EdgeInsets.all(height * 0.01),
                            child: Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.04),
                              child: Image.asset('assets/images/logo.png'),
                            )),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.8,
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.05),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.height * 0.15,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                  image: AssetImage(AppImages.aboutUs),
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Countup(
                                      begin: 0,
                                      end: 13,
                                      duration: const Duration(seconds: 2),
                                      separator: ',',
                                      style: AppStyles.NormalText().copyWith(
                                        // fontFamily: 'Quicksand',
                                        color: Colors.white,
                                        fontSize: width / 13,
                                      ),
                                    ),
                                    Text(
                                      "EVENTS",
                                      style: AppStyles.NormalText().copyWith(
                                        fontSize: width / 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.height * 0.15,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                  image: AssetImage(AppImages.aboutUs),
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Countup(
                                      begin: 0,
                                      end: 300,
                                      duration: const Duration(seconds: 2),
                                      separator: ',',
                                      style: AppStyles.NormalText().copyWith(
                                        // fontFamily: 'Quicksand',
                                        color: Colors.white,
                                        fontSize: width / 13,
                                      ),
                                    ),
                                    Text(
                                      "VOLUNTEERS",
                                      style: AppStyles.NormalText().copyWith(
                                        fontSize: width / 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height / 20),
                      child: Container(
                        padding: EdgeInsets.all(width * 0.04),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.withOpacity(0.2)),
                        child: Text(
                          aboutPulzion,
                          textAlign: TextAlign.justify,
                          style: AppStyles.NormalText().copyWith(
                            // fontFamily: ,
                            fontSize: width / 19,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height / 30),
                      child: Container(
                        padding: EdgeInsets.all(width * 0.04),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'CONTACT US',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: height * 0.02,
                                  fontFamily: 'Wallpoet'),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            GestureDetector(
                              onTap: () => openWhatsAppChat('+91 94203 24148'),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade700.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Colors.green,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: width / 80),
                                      child: Text(
                                        " Aashlesh Wawage",
                                        textAlign: TextAlign.center,
                                        style: AppStyles.NormalText().copyWith(
                                          fontSize: width / 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      " : +91 94203 24148",
                                      style: AppStyles.NormalText().copyWith(
                                        fontSize: width / 19,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                            GestureDetector(
                              onTap: () => openWhatsAppChat("+91 93226 78365"),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade700.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Colors.green,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: width / 200),
                                      child: Text(
                                        " Harsha Pareek",
                                        textAlign: TextAlign.justify,
                                        style: AppStyles.NormalText().copyWith(
                                          // fontFamily: 'Quicksand',
                                          fontSize: width / 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      " : +91 93226 78365",
                                      textAlign: TextAlign.justify,
                                      style: AppStyles.NormalText().copyWith(
                                        // fontFamily: 'Quicksand',
                                        fontSize: width / 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.05,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height / 20),
                      child: Container(
                        padding: EdgeInsets.all(width * 0.04),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey.withOpacity(0.2)),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: height * 0.01),
                              child: Text(
                                'SOCIALS',
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontSize: height * 0.02,
                                    fontFamily: 'Wallpoet'),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    Singleton().player.playClick();
                                    await _launchUniversalLinkApp(
                                      "https://www.facebook.com/acmpict/",
                                    );
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.facebook,
                                    size: width / 11,
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width / 12),
                                  child: IconButton(
                                    onPressed: () async {
                                      Singleton().player.playClick();
                                      await _launchUniversalLinkApp(
                                        'https://www.instagram.com/acm.pict/?hl=en',
                                      );
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.instagram,
                                      size: width / 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width / 12),
                                  child: IconButton(
                                    onPressed: () async {
                                      Singleton().player.playClick();
                                      await _launchUniversalLinkApp(
                                        "https://in.linkedin.com/company/pict-acm-student-chapter",
                                      );
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.linkedin,
                                      size: width / 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width / 12),
                                  child: IconButton(
                                    onPressed: () async {
                                      Singleton().player.playClick();
                                      await _launchUniversalLinkApp(
                                        "https://twitter.com/_pict_acm_?lang=en",
                                      );
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.xTwitter,
                                      size: width / 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
