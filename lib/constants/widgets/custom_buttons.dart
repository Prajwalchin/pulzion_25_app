import 'package:flutter/material.dart';
import 'package:pulzion_25_app/constants/audio.dart';
import 'package:pulzion_25_app/constants/images.dart';

class TechButton extends StatefulWidget {
  const TechButton({
    super.key,
    required this.buttonText,
    required this.scale,
    required this.onTap,
  });

  final String buttonText;
  final double scale;
  final VoidCallback onTap;
  @override
  State<TechButton> createState() => _TechButtonState();
}

class _TechButtonState extends State<TechButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () {
            Singleton().player.playClick();
            widget.onTap();
          },
          child: Container(
            height: 43 * widget.scale,
            width: 110 * widget.scale,
            decoration: BoxDecoration(
              color: Colors.black,
              gradient: LinearGradient(colors: [
                const Color.fromARGB(223, 10, 150, 205),
                const Color.fromARGB(223, 10, 169, 205).withOpacity(0.3),
                const Color.fromARGB(161, 87, 154, 225).withOpacity(0.2),
                const Color.fromARGB(223, 10, 166, 205).withOpacity(0.3),
                const Color.fromARGB(172, 10, 169, 205).withOpacity(0.5),
              ]),
              image: const DecorationImage(
                image: AssetImage(AppImages.buttonFrame),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(5 * widget.scale),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04),
              child: Text(
                widget.buttonText,
                style: TextStyle(
                  fontSize: 11 * widget.scale,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Wallpoet',
                  color: const Color.fromARGB(255, 199, 167, 74),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Positioned(
          top: -3,
          left: -33 * widget.scale,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.teal, width: 1)),
            child: CircleAvatar(
              radius: 23 * widget.scale,
              backgroundColor: Colors.transparent,
              backgroundImage: const AssetImage(AppImages.buttonGIF),
            ),
          ),
        ),
      ],
    );
  }
}
