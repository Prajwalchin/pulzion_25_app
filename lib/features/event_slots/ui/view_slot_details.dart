import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';
import 'package:pulzion_25_app/config/event_logo_urls.dart';
import 'package:pulzion_25_app/constants/widgets/app_background.dart';
import 'package:pulzion_25_app/constants/widgets/loader.dart';
import 'package:pulzion_25_app/features/home_page/ui/wigets/custom_appbar.dart';

import '/constants/models/booked_slot_model.dart';
import '/constants/styles.dart';
import '/features/registered_events_and_orders/cubit/registered_events_and_orders_cubit.dart';
import '/project/cubit/animation_toggle_cubit.dart';

class ViewSlotDetails extends StatefulWidget {
  final int id;
  final String logo;
  final String name;
  final Function onPop;

  const ViewSlotDetails({
    super.key,
    required this.id,
    required this.logo,
    required this.name,
    required this.onPop,
  });

  @override
  State<ViewSlotDetails> createState() => _TicketState();
}

class _TicketState extends State<ViewSlotDetails> {
  final _cacheManager = CacheManager(
    Config(
      'my_custom_cache_key',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        //log("calling onPop");
        // if (didPop) {
        widget.onPop();
        // }
      },
      child: Stack(
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
            appBar: const CustomAppBar(),
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenheight * 0.11,
                  horizontal: screenwidth * 0.01),
              child: BlocConsumer<RegisteredEventsAndOrdersCubit,
                  RegisteredEventsAndOrdersState>(
                listener: (context, state) {},
                buildWhen: (previous, current) =>
                    current is! RegisteredEventsAndOrdersLoaded,
                builder: (context, state) {
                  //log("View Slot details state = $state");
                  if (state is RegisteredEventsAndOrdersLoading) {
                    return const Center(
                      child: Center(child: Loader()),
                    );
                  } else if (state is RegisteredEvents) {
                    final BookedSlotModel bookedSlotModel = state
                        .bookedEventList
                        .firstWhere((element) => element.id == widget.id);

                    return Center(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color.fromARGB(255, 20, 99, 145)
                                  .withOpacity(0.2),
                              const Color.fromARGB(255, 60, 155, 209)
                                  .withOpacity(0.2),
                              const Color.fromARGB(255, 5, 6, 6)
                                  .withOpacity(0.2),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.teal[700]!.withOpacity(0.8),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1.0,
                              spreadRadius: 2.0,
                              color: Colors.teal[900]!.withOpacity(0.3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: screenheight * 0.04,
                              ),
                              Container(
                                padding: EdgeInsets.all(screenheight * 0.023),
                                height: screenheight * 0.12,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent),
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: CachedNetworkImage(
                                    imageUrl: widget.logo,
                                    color: Colors.white,
                                    placeholder: (context, url) => Container(),
                                    errorWidget: (context, url, error) =>
                                        Image.network(
                                      eventLogoImageUrlMap[widget.id]!,
                                    ),
                                    cacheManager: _cacheManager,
                                    fadeInDuration: const Duration(
                                      milliseconds: 100,
                                    ),
                                    fit: BoxFit.fitWidth,
                                    key: UniqueKey(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: screenheight * 0.02,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.amber,
                                        fontFamily: 'Wallpoet',
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenheight * 0.02,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: screenheight * 0.02),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.amber,
                                          width: 0.6,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: screenwidth * 0.09,
                                                top: 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.calendar_month,
                                                  color: Colors.amber,
                                                  size: 20.0,
                                                ),
                                                SizedBox(
                                                  width: screenwidth * 0.01,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Date',
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenheight * 0.025,
                                                      color: Colors.amber,
                                                      fontFamily: 'VT323',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.access_time,
                                                  color: Colors.amber,
                                                  size: 20.0,
                                                ),
                                                SizedBox(
                                                  width: screenwidth * 0.01,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Time',
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenheight * 0.025,
                                                      color: Colors.amber,
                                                      fontFamily: 'VT323',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: screenwidth * 0.09,
                                              bottom: 0,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(
                                                      DateTime.parse(
                                                        bookedSlotModel
                                                                .start_time ??
                                                            '',
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenheight * 0.025,
                                                      color: Colors.white,
                                                      fontFamily: 'VT323',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                const VerticalDivider(
                                                  color: Colors.transparent,
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${DateFormat('hh:mm a').format(DateTime.parse(bookedSlotModel.start_time!))} - ${DateFormat('hh:mm a').format(DateTime.parse(bookedSlotModel.end_time!))}',
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenheight * 0.025,
                                                      color: Colors.white,
                                                      fontFamily: 'VT323',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: screenheight * 0.02),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: screenwidth * 0.09,
                                                top: 20),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.laptop,
                                                  color: Colors.amber,
                                                  size: 20.0,
                                                ),
                                                SizedBox(
                                                  width: screenwidth * 0.01,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Mode',
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenheight * 0.025,
                                                      color: Colors.amber,
                                                      fontFamily: 'VT323',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.airplane_ticket,
                                                  color: Colors.amber,
                                                  size: 20.0,
                                                ),
                                                SizedBox(
                                                  width: screenwidth * 0.01,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Ticket ID',
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenheight * 0.025,
                                                      color: Colors.amber,
                                                      fontFamily: 'VT323',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: screenheight * 0.005,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: screenwidth * 0.09,
                                                bottom: 8),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    bookedSlotModel.mode
                                                        .toString(),
                                                    style:
                                                        AppStyles.NormalText()
                                                            .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    bookedSlotModel.id
                                                        .toString(),
                                                    style:
                                                        AppStyles.NormalText()
                                                            .copyWith(
                                                      color: Colors.white,
                                                      fontSize:
                                                          screenheight * 0.025,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
