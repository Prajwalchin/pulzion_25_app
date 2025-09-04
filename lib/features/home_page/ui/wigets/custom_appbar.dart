import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion_25_app/constants/audio.dart';
import 'package:pulzion_25_app/constants/images.dart';

import '../../../login_page/cubit/check_login_cubit.dart';
import '../../../login_page/ui/login_signup_intro.dart';
import '../../../profile_page/cubit/profile_cubit.dart';
import '../../../profile_page/ui/profileui.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actions: [
        Container(
          margin:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.02),
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          child: BlocBuilder<CheckLoginCubit, CheckLoginState>(
            builder: (context, state) {
              return state is CheckLoginFailure
                  ? InkWell(
                      onTap: (() {
                        Singleton().player.playError();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginSignUpIntro(),
                          ),
                        );
                      }),
                      child: getProfileIcon(context),
                    )
                  : InkWell(
                      onTap: (() {
                        Singleton().player.playClick();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider<ProfileCubit>(
                              create: (BuildContext context) =>
                                  ProfileCubit()..getUser(),
                              child: const ProfilePage(),
                            ),
                          ),
                        );
                      }),
                      child: getProfileIcon(context));
            },
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

Widget getProfileIcon(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
    decoration: BoxDecoration(
      // color: Colors.teal.shade200,
      gradient: RadialGradient(
        colors: [
          const Color.fromARGB(255, 0, 0, 0),
          const Color.fromARGB(255, 0, 0, 0),
          const Color.fromARGB(255, 5, 88, 104).withOpacity(0.5),
          const Color.fromARGB(255, 46, 112, 153).withOpacity(0.7),
        ],
      ),
      shape: BoxShape.circle,
      border: Border.all(
        color: const Color.fromARGB(255, 49, 163, 188),
      ),
    ),
    child: Image.asset(
      AppImages.profileIcon,
      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
    ),
  );
}
