import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pulzion_25_app/constants/audio.dart';
import 'package:pulzion_25_app/constants/widgets/app_background.dart';

import '/constants/urls.dart';
import '/features/mcq/features/mcq_login/ui/mcq_login.dart';
import '../config/size_config.dart';
import '../features/cart_page/cubit/cart_page_cubit.dart';
import '../features/cart_page/ui/cart_page_final.dart';
import '../features/home_page/ui/home_page_final.dart';
import '../features/home_page/ui/wigets/custom_appbar.dart';
import '../features/login_page/cubit/check_login_cubit.dart';
import '../features/login_page/ui/login_signup_intro.dart';
import '../features/registered_events_and_orders/ui/registered_events_and_orders.dart';
import '../pages/about_us_page/ui/about_us.dart';
import '../pages/more_page/ui/more_main.dart';
import 'cubit/animation_toggle_cubit.dart';
import 'cubit/bottom_bar_cubit.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});
  final Map<int, String> pages = {
    0: (EndPoints.mcqStarted ?? false) ? 'MCQ' : 'About Us',
    1: 'Orders',
    2: 'Home',
    3: 'Cart',
    4: 'Settings',
  };

  @override
  Widget build(BuildContext context) {
    final iconSize = MediaQuery.of(context).size.width;

    // Initialize the size config for responsive UI
    SizeConfig.init(context);

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
        BlocBuilder<BottomBarCubit, BottomBarState>(
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: const CustomAppBar(),
              backgroundColor: Colors.transparent,
              body: BlocBuilder<CheckLoginCubit, CheckLoginState>(
                builder: (context, loginState) {
                  return BlocBuilder<BottomBarCubit, BottomBarState>(
                    builder: (context, state) {
                      //log(EndPoints.mcqStarted.toString());
                      if (state is BottomBarAboutUs) {
                        return EndPoints.mcqStarted == true
                            ? const MCQLogin()
                            : AboutUsPage(false);
                      } else if (state is BottomBarRegisteredEvents) {
                        return loginState is CheckLoginSuccess
                            ? const RegisteredEventsAndOrders()
                            : const LoginSignupBody();
                      } else if (state is BottomBarHome) {
                        return const HomePageContent();
                      } else if (state is BottomBarCart) {
                        BlocProvider.of<CartPageCubit>(context).loadCart();
                        return loginState is CheckLoginSuccess
                            ? const Center(
                                child: CartPageFinal(),
                              )
                            : const LoginSignupBody();
                      } else {
                        return const FrostedGlassTile();
                      }
                    },
                  );
                },
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  border: const Border(
                    top: BorderSide(
                      color: Colors.transparent,
                      width: 0.2,
                    ),
                  ),
                ),
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom),
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  bottom: MediaQuery.of(context).size.height * 0.01,
                ),
                child: GNav(
                  selectedIndex: 2,
                  tabs: [
                    _buildNavBarItem(Icons.info_outline, iconSize, 0),
                    _buildNavBarItem(
                        Icons.calendar_month_outlined, iconSize, 1),
                    _buildNavBarItem(Icons.home_outlined, iconSize, 2),
                    _buildNavBarItem(Icons.shopping_cart_outlined, iconSize, 3),
                    _buildNavBarItem(Icons.settings_outlined, iconSize, 4),
                  ],
                  color: Colors.white,
                  activeColor: Colors.amber,
                  tabBackgroundColor: Colors.teal.shade800.withOpacity(0.3),
                  gap: MediaQuery.of(context).size.height * 0.005,
                  duration: const Duration(milliseconds: 300),
                  tabActiveBorder: Border.all(color: Colors.teal, width: 0.5),
                  onTabChange: (index) {
                    Singleton().player.playClick();
                    context.read<BottomBarCubit>().changeIndex(index);
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  GButton _buildNavBarItem(IconData icon, double size, int index) {
    return GButton(
      icon: icon,
      iconSize: size * 0.068,
      iconActiveColor: const Color.fromARGB(206, 255, 193, 7),
      textColor: Colors.white,
      text: pages[index]!,
      textStyle: TextStyle(
        fontFamily: 'VT323',
        fontWeight: FontWeight.w300,
        fontSize: size * 0.048,
        color: Colors.white.withOpacity(0.9),
      ),
      padding:
          EdgeInsets.symmetric(vertical: size * 0.03, horizontal: size * 0.02),
      margin: EdgeInsets.symmetric(horizontal: size * 0.02),
      borderRadius: BorderRadius.circular(50),
    );
  }
}
