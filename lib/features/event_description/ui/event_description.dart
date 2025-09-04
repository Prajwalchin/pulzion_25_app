// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion_25_app/features/event_description/ui/widgets/custom_tabbar.dart';
import 'package:pulzion_25_app/features/event_description/ui/widgets/dynamic_button.dart';
import 'package:pulzion_25_app/features/event_description/ui/widgets/event_description_tabbar.dart';
import 'package:pulzion_25_app/features/event_description/ui/widgets/slivers.dart';

import '../../../config/size_config.dart';
import '../../../constants/colors.dart';
import '../../../constants/models/event_model.dart';
import '../../../constants/styles.dart';
import '../../cart_page/cubit/cart_page_cubit.dart';

Widget getEventLogo(
  Events event,
  double w,
  double fontSizeFactor,
  bool isDark,
) {
  return Stack(
    children: [
      Positioned(
        left: w / 3.7,
        top: w / 7,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black.withOpacity(0.5) : Colors.black,
                // : const Color.fromARGB(255, 4, 15, 30).withOpacity(0.5),
                blurRadius: 1.0,
                spreadRadius: 7.0,
                offset: const Offset(0.0, 0.0),
              ),
            ],
          ),
          child: Container(
            width: w / 2.6,
            height: w / 2.6,
            padding: EdgeInsets.all(
              SizeConfig.getProportionateScreenWidth(15),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: RadialGradient(
                radius: fontSizeFactor * 0.5,
                colors: [
                  const Color.fromARGB(255, 4, 15, 30).withOpacity(0.15),
                  Colors.black,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                SizeConfig.getProportionateScreenWidth(27),
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withAlpha(60)
                          : Colors.orange.withAlpha(50),
                      blurRadius: 30.0,
                      spreadRadius: 10.0,
                      offset: const Offset(
                        0.0,
                        0.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

class EventDescription extends StatefulWidget {
  final bool isDark;
  final Events? event;
  final Function()? onChange;
  final Function()? getTheme;
  final List<Events> eventList;
  const EventDescription({
    required this.isDark,
    required this.event,
    required this.onChange,
    required this.getTheme,
    required this.eventList,
    super.key,
  });

  @override
  State<EventDescription> createState() => _EventDescriptionState();
}

class _EventDescriptionState extends State<EventDescription>
    with TickerProviderStateMixin {
  bool isCart = true;
  late final TabController tabBarController =
      TabController(length: 4, vsync: this);

  @override
  void initState() {
    super.initState();
    tabBarController.addListener(() {
      Future.delayed(const Duration(seconds: 0), () {
        if (tabBarController.index == 3) {
          setState(() {
            isCart = false;
          });
        } else {
          setState(() {
            isCart = true;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabBarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event!;

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    final fontSizeFactor = h / w;
    //log("iscart = $isCart");
    return Scaffold(
      bottomNavigationBar: isCart
          ? Container(
              padding: EdgeInsets.only(top: h * 0.01),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 39, 77).withOpacity(0.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    spreadRadius: 3,
                    blurRadius: 9,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.1,
                      ),
                      child: SizedBox(
                        height: h / 10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "PRICE",
                              style: AppStyles.NormalText().copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "Rs. ${event.price}",
                              style: AppStyles.NormalText().copyWith(
                                color: Colors.amber.withOpacity(0.8),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (isCart)
                    SizedBox(
                      height: h / 12,
                      width: w / 2.2,
                      child: BlocProvider(
                        create: (context) => CartPageCubit()..loadCart(),
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: h * 0.01,
                              right: MediaQuery.of(context).size.width * 0.03),
                          alignment: Alignment.center,
                          child: DynamicButton(event: event),
                        ),
                      ),
                    ),
                ],
              ),
            )
          : null,
      body: Stack(
        children: [
          BlocListener<CartPageCubit, CartPageState>(
            listenWhen: (previous, current) =>
                current is CartItemAdded ||
                current is CartItemNotAdded ||
                current is CartItemDeleted ||
                current is CartItemNotDeleted,
            listener: (context, state) {
              if (state is CartItemAdded) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: AppStyles.NormalText().copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                );
                BlocProvider.of<CartPageCubit>(context).loadCart();
              } else if (state is CartItemNotAdded) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: AppStyles.NormalText().copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                );
                // BlocProvider.of<CartPageCubit>(context).loadCart();
              } else if (state is CartItemDeleted) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: AppStyles.NormalText().copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                );
                BlocProvider.of<CartPageCubit>(context).loadCart();
              } else if (state is CartItemNotDeleted) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: AppStyles.NormalText().copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                );
                // BlocProvider.of<CartPageCubit>(context).loadCart();
              } else {
                BlocProvider.of<CartPageCubit>(context).loadCart();
              }
            },
            child: Stack(
              children: [
                CustomScrollView(slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: AppBarNetflix(
                      event: event,
                      description: event.description!,
                      minExtended: kToolbarHeight,
                      maxExtended: h * 0.35,
                      size: MediaQuery.of(context).size,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Divider(
                          color: Colors.transparent,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: h * 0.02),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: DefaultTabController(
                                  length: 4,
                                  child: TabBar(
                                    labelPadding: const EdgeInsets.all(7),
                                    controller: tabBarController,
                                    indicator: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.teal.withOpacity(0.7),
                                        ),
                                      ),
                                    ),
                                    unselectedLabelColor:
                                        AppColors.cardSubtitleTextColor,
                                    tabs: [
                                      Text(
                                        "Details",
                                        style: AppStyles.TitleText().copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: 'VT323',
                                          fontSize: h * 0.024,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        "Rounds",
                                        style: AppStyles.TitleText().copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: 'VT323',
                                          fontSize: h * 0.024,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        "Rules",
                                        style: AppStyles.TitleText().copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: 'VT323',
                                          fontSize: h * 0.024,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        "Combos",
                                        style: AppStyles.TitleText().copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontFamily: 'VT323',
                                          fontSize: h * 0.024,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomTabsView(
                                tabIndex: tabBarController.index,
                                firstTab: getDetails(context, event, h, w),
                                secondTab: getRounds(context, event, h, w),
                                thirdTab: getRules(context, event, h, w),
                                fourthTab: getCombos(
                                    context, event, h, w, widget.eventList),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
