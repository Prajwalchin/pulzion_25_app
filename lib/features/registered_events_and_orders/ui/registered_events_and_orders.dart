import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion_25_app/constants/widgets/loader.dart';
import 'package:pulzion_25_app/features/home_page/ui/wigets/custom_button.dart';

import '../../../config/size_config.dart';
import '../../../constants/colors.dart';
import '../../../constants/models/registered_event.dart';
import '../../../constants/styles.dart';
import '../../../constants/widgets/error_dialog.dart';
import '../cubit/registered_events_and_orders_cubit.dart';
import 'widgets/past_orders_card.dart';
import 'widgets/registered_events_cards.dart';

class RegisteredEventsAndOrders extends StatefulWidget {
  const RegisteredEventsAndOrders({super.key});

  @override
  State<RegisteredEventsAndOrders> createState() =>
      _RegisteredEventsAndOrdersState();
}

class _RegisteredEventsAndOrdersState extends State<RegisteredEventsAndOrders>
    with TickerProviderStateMixin {
  late TabController tabBarController;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }

  List<dynamic> getEventNames(List<RegisteredEvent> registeredEvents) {
    List<dynamic> eventNames = [];
    for (RegisteredEvent event in registeredEvents) {
      if (event.status == "accepted") {
        eventNames += event.events ?? [];
      }
    }

    return eventNames;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // print("helo");

        return RegisteredEventsAndOrdersCubit()..getRegisteredEventsAndOrders();
      },
      child: BlocConsumer<RegisteredEventsAndOrdersCubit,
          RegisteredEventsAndOrdersState>(
        listener: (context, state) {},
        // buildWhen: (previous, current) {
        //   if (current is RegisteredOrdersandEventsUpdates ||
        //       current is RegisteredEventsAndOrdersLoaded) {
        //     return true;
        //   }

        //   return false;
        // },
        buildWhen: (previous, current) {
          //log("PREVIOUS = $previous");
          //log("CURRENT = $current");

          if (previous is RegisteredEvents && current is! RegisteredEvents) {
            return true;
          }
          if (current is RegisteredEvents || previous is RegisteredEvents) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          //log('switch case $state');
          if (state is RegisteredEventsAndOrdersLoading) {
            return const Center(child: Loader());
          } else if (state is RegisteredEventsAndOrdersLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Your Events",
                    style: AppStyles.TitleText().copyWith(
                      fontSize: SizeConfig.getProportionateScreenFontSize(35),
                      color: Colors.amber,
                      fontFamily: 'Wallpoet',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  child: DefaultTabController(
                    length: 2,
                    child: TabBar(
                      labelPadding: const EdgeInsets.all(12),
                      controller: tabBarController,
                      indicator: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.teal,
                            width: 2,
                          ),
                        ),
                      ),
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.teal,
                      unselectedLabelColor: AppColors.cardSubtitleTextColor,
                      labelColor: const Color.fromARGB(255, 208, 168, 116),
                      tabs: [
                        CustomButton(
                          text: 'Registered Events',
                          fontSize: MediaQuery.of(context).size.height * 0.0125,
                        ),
                        CustomButton(
                          text: 'Past Orders',
                          fontSize: MediaQuery.of(context).size.height * 0.013,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    controller: tabBarController,
                    children: [
                      RegisteredEventsCards(
                        registeredEvents: (state).registeredEvents.toList(),
                        regsieteredCombos: (state).registeredCombos.toList(),
                      ),
                      PastOrdersCards(
                        (state).registeredOrders.toList(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is RegisteredEventsAndOrdersError) {
            return Center(
              child: ErrorDialog(
                (state).errorMessage,
                refreshFunction: () {
                  //log("refreshing");
                  context
                      .read<RegisteredEventsAndOrdersCubit>()
                      .getRegisteredEventsAndOrders();
                },
              ),
            );
          } else {
            return const Center(child: Loader());
          }
        },
      ),
    );
  }
}
