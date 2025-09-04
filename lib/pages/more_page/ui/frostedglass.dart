import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/images.dart';
import 'child_wild.dart';

class FrostedGlassBox extends StatelessWidget {
  final double cwidth, cheight;
  final List<FrostedTile> childWid;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  const FrostedGlassBox({
    super.key,
    required this.cheight,
    required this.cwidth,
    required this.childWid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(cheight / 5),
      margin: EdgeInsets.only(
        bottom: cheight / 4,
      ),
      height: cheight * childWid.length * 1.3,
      decoration: const BoxDecoration(
        image: DecorationImage(
          opacity: 0.7,
          image: AssetImage(AppImages.cartFrame),
          fit: BoxFit.fill,
        ),
      ),
      child: AnimationLimiter(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: childWid.length,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 1200),
            child: ScaleAnimation(
              child: InkWell(
                onTap: childWid[index].url != null
                    ? () async {
                        await _launchInBrowser(
                          Uri.parse(childWid[index].url!),
                        );
                      }
                    : childWid[index].onTap ??
                        () {
                          // If Both URL and onTap are not present then do nothing
                          null;
                        },
                child: Column(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: cheight / 6,
                          right: cheight / 6,
                          top: cheight * 0.01,
                        ),
                        child: childWid[index],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: cheight / 17,
                        right: cheight / 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
