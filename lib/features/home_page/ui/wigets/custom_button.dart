import 'package:flutter/material.dart';
import 'package:pulzion_25_app/constants/images.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final double? fontSize;
  const CustomButton({super.key, required this.text, this.fontSize});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center, // Center content inside the Stack
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.36,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 15, 93, 112).withOpacity(0.7),
                const Color.fromARGB(255, 28, 88, 167).withOpacity(0.3),
                const Color.fromARGB(255, 6, 90, 73).withOpacity(0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(66, 78, 169, 185),
                blurRadius: 20,
                offset: Offset(
                    size.width * 0.01, size.height * 0.01), // Responsive shadow
                spreadRadius: size.width * 0.03,
              ),
            ],
          ),
          child: Image.asset(
            AppImages.buttonFrame,
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.overlay,
          ),
        ),
        // Center the text inside the Stack
        Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Wallpoet',
              color: Colors.amber,
              fontSize: widget.fontSize ?? size.height * 0.020,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
