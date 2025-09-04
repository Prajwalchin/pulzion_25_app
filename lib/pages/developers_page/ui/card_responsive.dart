import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulzion_25_app/constants/audio.dart';
import 'package:pulzion_25_app/constants/images.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String linkedInId;
  final String emailId;
  final String gitHubId;

  const DeveloperCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.linkedInId,
    required this.emailId,
    required this.gitHubId,
  });

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.teal,
            ),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 26, 175, 175).withOpacity(0.4),
                const Color.fromARGB(255, 4, 77, 70).withOpacity(0.4),
                const Color.fromARGB(255, 42, 132, 157).withOpacity(0.4),
                const Color.fromARGB(255, 42, 132, 157).withOpacity(0.3),
              ],
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.05,
                  horizontal: screenWidth * 0.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.2),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 100, 98, 98),
                              Color.fromARGB(255, 33, 33, 33),
                              Color.fromARGB(255, 61, 59, 59),
                            ],
                          ),
                        ),
                        width: screenWidth * 0.55,
                        height: screenWidth * 0.55,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            placeholder: (context, url) => Image.asset(
                              color: Colors.amber.shade100,
                              AppImages.developerPlaceholder,
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey,
                            ),
                            fadeInDuration: const Duration(milliseconds: 200),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: screenWidth * 0.8,
                        minWidth: screenWidth * 0.4,
                      ),
                      child: Column(
                        children: [
                          Text(
                            '<${name.split(' ')[0]}',
                            style: TextStyle(
                              fontSize: screenWidth * 0.08,
                              fontFamily: 'Wallpoet',
                              color: Colors.amber, // Text color
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow
                                .ellipsis, // If text exceeds the maxWidth, it will be truncated with '...'
                          ),
                          Text(
                            '${name.split(' ')[1]}/>',
                            style: TextStyle(
                              fontSize: screenWidth * 0.08,
                              fontFamily: 'Wallpoet',
                              color: Colors.amber, // Text color
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow
                                .ellipsis, // If text exceeds the maxWidth, it will be truncated with '...'
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    // const Divider(
                    //   color: Colors.teal,
                    // ),
                    // SizedBox(
                    //   height: screenHeight * 0.03,
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(0.4),
                              child: IconButton(
                                onPressed: () {
                                  Singleton().player.playClick();
                                  _launchUniversalLinkApp(
                                      Uri.parse(linkedInId));
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.linkedin,
                                  color: Colors.blue.shade300,
                                  size: 20,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(0.4),
                              child: IconButton(
                                onPressed: () async {
                                  Singleton().player.playClick();
                                  String email = Uri.encodeComponent(emailId);
                                  Uri mail =
                                      Uri.parse("mailto:$email?subject=&body=");
                                  launchUrl(mail);
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.red.shade400,
                                  size: 20,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(0.4),
                              child: IconButton(
                                onPressed: () {
                                  Singleton().player.playClick();
                                  _launchUniversalLinkApp(Uri.parse(gitHubId));
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.github,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
