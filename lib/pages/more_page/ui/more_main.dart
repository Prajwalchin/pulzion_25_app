import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulzion_25_app/constants/audio.dart';
import 'package:url_launcher/url_launcher.dart';

import '/features/splash_screen/cubit/splash_cubit.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';
import '../../../constants/urls.dart';
import '../../../features/login_page/cubit/check_login_cubit.dart';
import '../../../features/login_page/ui/login_signup_intro.dart';
import '../../about_us_page/ui/about_us.dart';
import '../../developers_page/ui/developers_page.dart';
import 'child_wild.dart';
import 'frostedglass.dart';

class FrostedGlassTile extends StatefulWidget {
  const FrostedGlassTile({super.key});

  @override
  State<FrostedGlassTile> createState() => _FrostedGlassTileState();
}

class _FrostedGlassTileState extends State<FrostedGlassTile> {
  bool isRocket = true;
  bool imgC = true;
  // late baudio;
  late bool _splashToggle;
  late bool _audioToggle;

  Future<void> _launchUniversalLinkApp(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  Future<void> _logout() async {
    await context.read<CheckLoginCubit>().logout();
    if (mounted) {
      await context.read<CheckLoginCubit>().checkLogin();
    }
  }

  Widget titleBar(double ht) {
    return Container(
      padding: EdgeInsets.only(bottom: ht * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              ColorizeAnimatedText(
                "<Welcome to Pulzion/>",
                textAlign: TextAlign.left,
                textStyle: AppStyles.NormalText().copyWith(
                  fontSize: ht / 22,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                  color: const Color.fromARGB(255, 16, 39, 82),
                ),
                colors: [
                  Colors.white.withOpacity(0.5),
                  Colors.white.withOpacity(1),
                  Colors.white.withOpacity(0.2),
                  Colors.white.withOpacity(1),
                  Colors.white.withOpacity(0.5),
                ],
                speed: const Duration(
                  milliseconds: 300,
                ),
              ),
            ],
            repeatForever: true,
            pause: Duration.zero,
          ),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                '13 Fun-filled Events!',
                textStyle: AppStyles.NormalText().copyWith(
                  color: Colors.amberAccent,
                  overflow: TextOverflow.ellipsis,
                  fontSize: ht / 40,
                ),
                speed: const Duration(
                  milliseconds: 100,
                ),
              ),
            ],
            totalRepeatCount: 3,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _audioToggle = Singleton().player.getAudioStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // final SensorControl sensorControl = SensorControl.AbsoluteOrientation;
    // audio = BlocProvider.of<GlobalParameterCubit>(context).controller;
    _splashToggle = BlocProvider.of<SplashCubit>(context).isSplashScreen;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height / 40),
          child: Column(
            children: [
              titleBar(
                height - height * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                child: Container(
                  height: height * 0.13,
                  padding: EdgeInsets.all(height * 0.015),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                      opacity: 0.7,
                      image: AssetImage(AppImages.cartFrame),
                      fit: BoxFit.fill, // Adjust this based on your needs
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: height / 90,
                      right: height / 90,
                    ),
                    child: SizedBox(
                      height: height / 11,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(7),
                            child: IconButton(
                              onPressed: () {
                                _launchUniversalLinkApp(
                                  Uri.parse(
                                    'https://www.instagram.com/acm.pict/',
                                  ),
                                );
                              },
                              icon: const FaIcon(FontAwesomeIcons.instagram),
                              color: Colors.white,
                              iconSize: height / 22,
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.grey.withOpacity(0.3),
                            width: 0.1,
                          ),
                          Container(
                            padding: const EdgeInsets.all(7),
                            child: IconButton(
                              onPressed: () {
                                _launchUniversalLinkApp(
                                  Uri.parse(
                                    'https://www.linkedin.com/in/pict-acm-student-chapter-09004a132/',
                                  ),
                                );
                              },
                              color: Colors.white,
                              iconSize: height / 22,
                              icon: const FaIcon(FontAwesomeIcons.linkedin),
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.grey.withOpacity(0.3),
                            width: 0.1,
                          ),
                          Container(
                            padding: const EdgeInsets.all(7),
                            child: IconButton(
                              onPressed: () {
                                _launchUniversalLinkApp(
                                  Uri.parse(
                                    'https://www.facebook.com/acmpict/',
                                  ),
                                );
                              },
                              color: Colors.white,
                              iconSize: height / 22,
                              icon: const FaIcon(FontAwesomeIcons.facebook),
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.grey.withOpacity(0.3),
                            width: 0.1,
                          ),
                          Container(
                            padding: const EdgeInsets.all(7),
                            child: IconButton(
                              onPressed: () {
                                _launchUniversalLinkApp(
                                  Uri.parse(
                                    'https://twitter.com/_pict_acm_?lang=en',
                                  ),
                                );
                              },
                              color: Colors.white,
                              iconSize: height / 22,
                              icon: const FaIcon(FontAwesomeIcons.xTwitter),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              BlocBuilder<CheckLoginCubit, CheckLoginState>(
                builder: (context, state) {
                  List<List<FrostedTile>> f = [
                    [
                      FrostedTile(
                        tilename: 'Sponsors',
                        tileicon: Icons.monetization_on_outlined,
                        onTap: () {
                          launchUrl(
                            Uri.parse(EndPoints.sponsorsUrl ?? ''),
                            mode: LaunchMode.inAppWebView,
                          );
                        },
                      ),
                    ],
                    [
                      FrostedTile(
                        tilename: 'About Us',
                        tileicon: Icons.info_outline,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUsPage(true),
                            ),
                          );
                        },
                      ),
                    ],
                    [
                      FrostedTile(
                        tilename: 'Developers',
                        tileicon: Icons.laptop,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DevelopersPage(),
                            ),
                          );
                        },
                      ),
                    ],
                    [
                      FrostedTile(
                        tilename: 'Privacy Policy',
                        tileicon: Icons.privacy_tip_outlined,
                        url: EndPoints.privacyPolicyURL,
                      ),
                    ],
                    [
                      FrostedTile(
                        tilename: 'Rate us on Play Store',
                        tileicon: FontAwesomeIcons.googlePlay,
                        url: EndPoints.playStoreURL,
                      ),
                    ],
                  ];
                  if (state is CheckLoginSuccess) {
                    f.insert(
                      0,
                      [
                        FrostedTile(
                          tilename: 'Logout',
                          tileicon: Icons.person_off_outlined,
                          onTap: _logout,
                        ),
                      ],
                    );
                  }
                  if (state is CheckLoginFailure) {
                    f.insert(
                      0,
                      [
                        FrostedTile(
                          tilename: 'Sign Up',
                          tileicon: Icons.login,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginSignUpIntro(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }

                  f.insert(0, [
                    FrostedTile(
                      tilename: "Splash Screen",
                      tileicon: Icons.phone,
                      child: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: height / 50),
                              child: CircleAvatar(
                                maxRadius: height * 0.025,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.phone_android_sharp,
                                  color: Colors.white,
                                  size: height * 0.0255,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: height / 40),
                              child: Text(
                                'Splash Screen',
                                style: AppStyles.NormalText().copyWith(
                                  fontSize: height / 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            CupertinoSwitch(
                              value: _splashToggle,
                              activeColor:
                                  Colors.teal.shade300.withOpacity(0.8),
                              trackColor: Colors.grey.withOpacity(0.3),
                              onChanged: (val) {
                                BlocProvider.of<SplashCubit>(context)
                                    .toggleParameter()
                                    .then((value) => {
                                          setState(() {
                                            _splashToggle = !_splashToggle;
                                          }),
                                        });
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        BlocProvider.of<SplashCubit>(context).toggleParameter();
                      },
                    ),
                  ]);

                  f.insert(0, [
                    FrostedTile(
                      tilename: "Splash Screen",
                      tileicon: Icons.phone,
                      child: Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: height / 50),
                              child: CircleAvatar(
                                maxRadius: height * 0.025,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.phone_android_sharp,
                                  color: Colors.white,
                                  size: height * 0.0255,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: height / 40),
                              child: Text(
                                'Sound Effects',
                                style: AppStyles.NormalText().copyWith(
                                  fontSize: height / 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            CupertinoSwitch(
                              value: !_audioToggle,
                              activeColor:
                                  Colors.teal.shade300.withOpacity(0.8),
                              trackColor: Colors.grey.withOpacity(0.3),
                              onChanged: (val) {
                                Singleton().player.toggleAudioStatus();
                                setState(() {
                                  _audioToggle = !_audioToggle;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        BlocProvider.of<SplashCubit>(context).toggleParameter();
                      },
                    ),
                  ]);

                  return Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(top: height / 70),
                      padding: EdgeInsets.only(
                        left: height / 80,
                        right: height / 80,
                      ),
                      child: AnimationLimiter(
                        child: ListView.builder(
                          itemCount: f.length,
                          itemBuilder: (context, index) =>
                              AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 1200),
                            child: SlideAnimation(
                              child: ScaleAnimation(
                                curve: Curves.easeInOut,
                                child: FadeInAnimation(
                                  child: FrostedGlassBox(
                                    cheight: height / 11.8,
                                    cwidth: MediaQuery.of(context).size.width,
                                    childWid: f[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
