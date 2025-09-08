import 'package:flutter/material.dart';
import 'package:pulzion_25_app/constants/urls.dart';
// import 'package:share_plus/share_plus.dart'; // Ensure you import the share_plus package for sharing functionality.
import 'package:pulzion_25_app/constants/images.dart'; // Replace with your correct import paths

class BackgroundSliver extends StatelessWidget {
  final String
      eventDescription; // Assuming you have event description passed to this widget

  const BackgroundSliver({
    super.key,
    required this.eventDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AppImages.eventDescriptionGIF,
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height *
              0.05, // Adjust vertical position
          left: MediaQuery.of(context).size.height *
              0.025, // Adjust horizontal position
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white, // Adjust color according to the background
              size: MediaQuery.of(context).size.height * 0.032, // Adjust size
            ),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous page
            },
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height *
              0.056, // Adjust vertical position
          right: MediaQuery.of(context).size.height * 0.028,
          child: InkWell(
            onTap: () {
              // Share.share(
              //   '$eventDescription\n\nPulzion App: ${EndPoints.playStoreURL}',
              //   subject: 'Pulzion Tech Across Ages', // Subject for sharing
              //   sharePositionOrigin:
              //       const Rect.fromLTWH(0, 0, 10, 10), // Share position origin
              // );
            },
            child: Icon(
              size: MediaQuery.of(context).size.height * 0.03,
              Icons.share,
              color: Colors.white, // Adjust color according to the background
            ),
          ),
        ),
      ],
    );
  }
}
