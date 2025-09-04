import 'package:flutter/material.dart';

import '../../../../constants/styles.dart';

class LoginSignUpTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;
  final Function? validator;

  const LoginSignUpTextField(
    this.hintText,
    this.icon, {
    super.key,
    required this.controller,
    required this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7, bottom: 7),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 88, 99, 102).withOpacity(0.1),
          // gradient: LinearGradient(
          //   colors: [
          //     Colors.black.withOpacity(0.6),
          //     Colors.black.withOpacity(0.4),
          //     Colors.black.withOpacity(0.4),
          //   ],
          //   begin: Alignment.centerLeft,
          //   end: Alignment.centerRight,
          // ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromARGB(228, 78, 226, 231).withOpacity(0.8),
            width: 0.7,
          ),
          boxShadow: const [
            // BoxShadow(
            //   blurRadius: 14.0,
            //   spreadRadius: 1.0,
            //   color: const Color.fromARGB(255, 59, 191, 178).withOpacity(0.8)
            // ),
          ],
        ),
        child: TextField(
          obscureText: obscureText,
          textInputAction: TextInputAction.next,
          style: (AppStyles.NormalText().copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          )),
          cursorColor: const Color.fromARGB(227, 76, 198, 217),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppStyles.NormalText().copyWith(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * 0.02,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            // fillColor: AppColors.primary.withAlpha(100),
            // filled: true,
            fillColor:
                Colors.grey.withOpacity(0.2), // Setting the background color
            prefixIcon: Icon(
              icon,
              color: Colors.white,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                      const Color.fromARGB(255, 58, 210, 203).withOpacity(0.7),
                  width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          controller: controller,
        ),
      ),
    );
  }
}
