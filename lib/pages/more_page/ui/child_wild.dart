import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/styles.dart';

class FrostedTile extends StatelessWidget {
  final IconData tileicon;
  final String tilename;
  final Widget? child;
  final String? url;
  final VoidCallback? onTap;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  const FrostedTile({
    super.key,
    required this.tilename,
    required this.tileicon,
    this.child,
    this.url,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: url != null
          ? () async {
              await _launchInBrowser(Uri.parse(url!));
            }
          : onTap ??
              () {
                // If Both URL and onTap are not present then do nothing
                null;
              },
      child: (child == null)
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: height / 50,
                    top: height / 95,
                  ),
                  child: CircleAvatar(
                    maxRadius: height * 0.025,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    child: Center(
                      child: Icon(
                        color: Colors.white,
                        tileicon,
                        size: height * 0.0255,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: height / 40,
                ),
                Text(
                  tilename,
                  style: AppStyles.NormalText().copyWith(
                    fontSize: height / 38,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : child!,
    );
  }
}
