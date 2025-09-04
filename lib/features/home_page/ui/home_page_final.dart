import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulzion_25_app/constants/widgets/error_dialog.dart';
import 'package:pulzion_25_app/constants/widgets/loader.dart';
import 'package:pulzion_25_app/features/home_page/logic/event_details_cubit_cubit.dart';
import 'package:pulzion_25_app/features/home_page/ui/wigets/custom_button.dart';
import 'package:pulzion_25_app/features/home_page/ui/wigets/wheel_scroll.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent>
    with TickerProviderStateMixin {
  late TabController tabBarController;
  int a = 0;
  int _currentIndex = 0; // Track the current index for the PageIndicator

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 2, vsync: this);
    tabBarController.addListener(() {
      setState(() {
        a = tabBarController.index;
      });
    });
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive layouts
    ScreenUtil.init(context,
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlocBuilder<EventDetailsCubitCubit, EventDetailsCubitState>(
        builder: (context, state) {
          if (state is EventDetailsCubitLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      PreferredSize(
                        preferredSize:
                            Size.fromHeight(50.h), // Adjust height as needed
                        child: DefaultTabController(
                          length: 2,
                          child: TabBar(
                            dividerColor: Colors.transparent,
                            indicatorColor: Colors.transparent,
                            labelPadding: const EdgeInsets.all(12),
                            indicator: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.teal,
                                  width: 2,
                                ),
                              ),
                            ),
                            unselectedLabelColor: Colors.transparent,
                            labelColor: Colors.transparent,
                            controller: tabBarController,
                            tabs: const [
                              CustomButton(text: 'Tech'),
                              CustomButton(text: 'Non-Tech'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        height: 260
                            .h, // Adjust the height of the TabBarView if necessary
                        child: TabBarView(
                          controller: tabBarController,
                          children: [
                            // First Tab content (Tech events)
                            WheelScroll(
                              eventList: state.events.events!
                                  .where(
                                      (element) => element.type == "Technical")
                                  .toList(),
                              itemCount: state.events.events!
                                  .where(
                                      (element) => element.type == "Technical")
                                  .toList()
                                  .length,
                              onItemChanged: (index) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),

                            // Second Tab content (Non-Tech events)
                            WheelScroll(
                              eventList: state.events.events!
                                  .where((element) =>
                                      element.type == "Non Technical")
                                  .toList(),
                              itemCount: state.events.events!
                                  .where((element) =>
                                      element.type == "Non Technical")
                                  .toList()
                                  .length,
                              onItemChanged: (index) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      _hologram()
                    ],
                  ),
                ],
              ),
            );
          } else if (state is EventDetailsCubitLoading) {
            return const Loader();
          } else {
            return Center(
              child: ErrorDialog(
                'Error while fetching events...',
                refreshFunction: () {
                  //log("refreshing");
                  context.read<EventDetailsCubitCubit>().getEventsDetails();
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _topComponent(context),
      ],
    );
  }

  Widget _hologram() {
    return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      height: 0.20.sh,
      width: 0.7.sw,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(66, 78, 169, 185),
            blurRadius: 45.r,
            offset: Offset(0.01.sw, 0.00),
            spreadRadius: 0.02.sw,
          ),
        ],
        color: Colors.transparent,
      ),
      child: Image.asset(
        'assets/images/hologram.png',
        fit: BoxFit.fill,
        opacity: const AlwaysStoppedAnimation(.6),
      ),
    );
  }
}

Widget _topComponent(BuildContext context) {
  return Container(
    // color: Colors.red,
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    width: 1.sw,
    height: 0.14.sh,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: 0.7.sw,
            height: 0.1.sh,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    ),
  );
}
