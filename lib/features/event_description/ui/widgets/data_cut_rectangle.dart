import 'package:flutter/material.dart';

class DataCutRectangle extends StatelessWidget {
  const DataCutRectangle({
    super.key,
    required this.size,
    required this.percent,
    required this.eventName,
  });

  final Size size;
  final double percent;
  final String eventName;

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive design and determining width/height
    final mediaQuery = MediaQuery.of(context);
    double h = mediaQuery.size.height;

    return Stack(
      children: [
        Container(
          height: size.height * 0.5,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 10,
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
            color: Colors.black,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
              top: h * 0.065,
              // right: h * 0.03,
            ),
            child: Text(
              eventName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.amber,
                fontSize: h * 0.027,
                fontFamily: 'Wallpoet',
              ),
            ),
          ),
        ),
        // if (percent < 0.50) ...[
        //   Positioned(
        //     top: size.height * 0.15,
        //     child: AnimatedOpacity(
        //       duration: const Duration(milliseconds: 200),
        //       opacity: (1 - pow(percent, 0.001)).toDouble(),
        //       // Optional: Add any child widget for additional description or content
        //     ),
        //   ),
        // ],
      ],
    );
  }
}
