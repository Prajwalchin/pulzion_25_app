import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion_25_app/constants/audio.dart';
import 'package:pulzion_25_app/constants/widgets/app_background.dart';

import '../../../constants/colors.dart';
import '../../../constants/styles.dart';
import '../../../project/cubit/animation_toggle_cubit.dart';
import '../logic/login_cubit.dart';
import '../logic/sign_up_cubit.dart';
import 'login.dart';
import 'sign_up.dart';

class LoginSignUpIntro extends StatelessWidget {
  const LoginSignUpIntro({super.key});

  @override
  Widget build(BuildContext context) {
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
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          body: const LoginSignupBody(),
        ),
      ],
    );
  }
}

class LoginSignupBody extends StatelessWidget {
  const LoginSignupBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              const Color.fromARGB(255, 65, 177, 166).withOpacity(0.3),
              const Color.fromARGB(255, 60, 155, 209).withOpacity(0.3),
              const Color.fromARGB(255, 20, 99, 145).withOpacity(0.3),
            ]),
            border: Border.all(
                color: const Color.fromARGB(255, 128, 184, 230), width: 2),
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.02),
        // margin: EdgeInsets.only(
        //   left: padding.top / 2,
        //   right: padding.top / 2,
        //   bottom: padding.top / 2 + 40,
        // ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.25,
              width: size.height * 0.36,
              decoration: const BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                // border: const Border.fromBorderSide(
                //   BorderSide(
                //     // color: AppColors.cardBRorder,
                //     width: 0.2,
                //   ),
                // ),
              ),
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.003),
                child: Container(
                  // height: ,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(13),
                        topRight: Radius.circular(13)),
                    border: Border.all(color: Colors.amber, width: 0.5),
                    image: const DecorationImage(
                      // image: NetworkImage('https://i.pinimg.com/originals/62/da/61/62da615e1c6e29ab501928aba4a20b5b.gif'),
                      image: AssetImage('assets/images/login_intro_image.gif'),
                      // image: NetworkImage('https://i.pinimg.com/originals/09/cc/14/09cc14191586aa0c5bb8938672534f4f.gif'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Pulzion 2024',
                  style: TextStyle(
                    fontFamily: 'Wallpoet',
                    fontSize: MediaQuery.of(context).size.height * 0.035,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 213, 182, 44),
                  ),
                ),
                Text(
                  'Tech Across Ages',
                  style: TextStyle(
                    fontFamily: 'Wallpoet',
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 213, 182, 44),
                  ),
                ),
                // Reduce the SizedBox height to decrease spacing
                SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.005), // Reduced height
                Text(
                  '3rd, 4th and 5th October',
                  style: TextStyle(
                    fontFamily: 'VT323',
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.01), // Reduced from 15
                Text(
                  textAlign: TextAlign.center,
                  'A 3-day event that includes a plethora of events and workshops, and is a platform for students to showcase their talents and skills.',
                  style: TextStyle(
                    fontFamily: 'VT323',
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
            Container(
              // padding: EdgeInsets.only(top: 30),
              height: size.height * 0.060,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.02,
                  top: MediaQuery.of(context).size.height * 0.01),
              width: size.width * 0.6,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.4),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color:
                      const Color.fromARGB(255, 68, 195, 211).withOpacity(0.8),
                  width: 0.7,
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1.0,
                    spreadRadius: 2.0,
                    color: const Color.fromARGB(255, 140, 213, 217)
                        .withOpacity(0.3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Singleton().player.playClick();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => SignUpCubit(),
                              child: const SignUp(),
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Register',
                          style: AppStyles.NormalText().copyWith(
                            fontSize: 20,
                            color: AppColors.cardTitleTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    color: Color.fromARGB(204, 85, 191, 205),
                    width: 2,
                    thickness: 2,
                    indent: 8.0,
                    endIndent: 8.0,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Singleton().player.playClick();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => LoginCubit(),
                              child: const Login(),
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Log In',
                          style: AppStyles.NormalText().copyWith(
                            fontSize: 20,
                            color: AppColors.cardTitleTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
