import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';
import 'package:pulzion_25_app/config/event_logo_urls.dart';
import 'package:pulzion_25_app/config/size_config.dart';
import 'package:pulzion_25_app/constants/widgets/app_background.dart';
import 'package:pulzion_25_app/constants/widgets/custom_buttons.dart';
import 'package:pulzion_25_app/constants/widgets/loader.dart';

import '/constants/styles.dart';
import '/constants/widgets/empty_page.dart';
import '/features/event_slots/logic/booked_slot_cubit.dart';
import '/features/event_slots/ui/view_slot_details.dart';
import '/features/registered_events_and_orders/cubit/registered_events_and_orders_cubit.dart';
import '/project/cubit/animation_toggle_cubit.dart';
import '../../../constants/models/slot_model.dart';

class BookSlots extends StatefulWidget {
  final int id;
  final String name;
  final String logo;

  const BookSlots({
    super.key,
    required this.id,
    required this.name,
    required this.logo,
  });

  @override
  State<BookSlots> createState() => _BookSlotsState();
}

class _BookSlotsState extends State<BookSlots> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  final _cacheManager = CacheManager(Config(
    'my_custom_cache_key',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
  ));

  Widget slotContainer(BuildContext ctx, Slot slot) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      height: MediaQuery.of(context).size.height * 0.02,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(slot.start_time!))}',
                      style: AppStyles.NormalText()
                          .copyWith(fontSize: 15, color: Colors.white),
                    ),
                    Text(
                      'Capacity: ${slot.capacity}',
                      style: AppStyles.NormalText()
                          .copyWith(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const VerticalDivider(
                color: Colors.teal,
                thickness: 0.3,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Time: ',
                      style: AppStyles.NormalText()
                          .copyWith(fontSize: 15, color: Colors.white),
                      children: [
                        TextSpan(
                          text:
                              '${DateFormat('hh:mm a').format(DateTime.parse(slot.start_time!))} - ${DateFormat('hh:mm a').format(DateTime.parse(slot.end_time!))}',
                          style: AppStyles.NormalText()
                              .copyWith(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: TechButton(
                      onTap: () {
                        BlocProvider.of<EventSlotsCubit>(ctx)
                            .bookSlot(
                              widget.id.toString(),
                              slot.id.toString(),
                            )
                            .then((value) {});
                      },
                      buttonText: 'Book Slot',
                      scale: 0.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final bloc =
        BlocProvider.of<RegisteredEventsAndOrdersCubit>(context, listen: false);

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
        SafeArea(
          top: true,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: h / 4.5,
                  pinned: false,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    centerTitle: true,
                    title: Padding(
                      padding: EdgeInsets.all(h * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Flexible(
                          //   child: SizedBox(
                          //     height: h / 20,
                          //   ),
                          // ),
                          const Spacer(),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Text(
                                'BOOK SLOTS',
                                style: AppStyles.TitleText().copyWith(
                                  fontSize:
                                      SizeConfig.getProportionateScreenFontSize(
                                          15),
                                  color: Colors.amber,
                                  fontFamily: 'Wallpoet',
                                ),
                              ),
                            ),
                          ),

                          Flexible(
                            fit: FlexFit.tight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                  width:
                                      MediaQuery.of(context).size.height * 0.03,
                                  child: FittedBox(
                                    child: CachedNetworkImage(
                                      imageUrl: widget.logo,
                                      color: Colors.white,
                                      placeholder: (context, url) =>
                                          Container(),
                                      errorWidget: (context, url, error) =>
                                          Image.network(
                                        eventLogoImageUrlMap[widget.id]!,
                                      ),
                                      cacheManager: _cacheManager,
                                      fadeInDuration:
                                          const Duration(milliseconds: 100),
                                      fit: BoxFit.fitWidth,
                                      key: UniqueKey(),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: w / 25,
                                ),
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Text(
                                      widget.name,
                                      style: AppStyles.NormalText().copyWith(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.08,
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
                    background: Container(
                      width: w / 4,
                      height: w / 4,
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
                        // border: Border.all(
                        //   color: Colors.orange[700]!.withOpacity(0.8),
                        //   width: 0.7,
                        // ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1.0,
                            spreadRadius: 2.0,
                            color: Colors.teal[900]!.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocConsumer<EventSlotsCubit, EventSlotStateCubit>(
                  listener: (context, state) {
                    if (state is BookingSuccessful) {
                      BlocProvider.of<RegisteredEventsAndOrdersCubit>(context)
                          .getUpdatedEvents(context);

                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Text(
                          'Slot Booked Successfully!',
                          style: AppStyles.NormalText().copyWith(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.teal,
                      ));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => BlocProvider<
                              RegisteredEventsAndOrdersCubit>.value(
                            value: bloc..getOnlyRegisteredEvents(),
                            child: ViewSlotDetails(
                              id: widget.id,
                              logo: widget.logo,
                              name: widget.name,
                              onPop: () {
                                // bloc.getRegisteredEventsAndOrders();
                              },
                            ),
                          ),
                        ),
                      );
                    } else if (state is EventSlotErrorState) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: const Duration(seconds: 3),
                        content: Text(
                          state.message.toString(),
                          style: AppStyles.NormalText().copyWith(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.teal,
                      ));
                    }
                  },
                  builder: (context, state) {
                    //log(state.toString());
                    if (state is EventSlotLoadingState) {
                      return SliverToBoxAdapter(
                        child: Center(
                            child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                            ),
                            const Loader()
                          ],
                        )),
                      );
                    } else if (state is NotBookedSlotState) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                top: 10.0,
                                bottom: 8.0,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.02),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    const Color.fromARGB(255, 16, 108, 124)
                                        .withOpacity(0.5),
                                    const Color.fromARGB(255, 10, 98, 89)
                                        .withOpacity(0.4),
                                    const Color.fromARGB(255, 4, 71, 91)
                                        .withOpacity(0.3),
                                  ]),
                                  // color: const Color.fromARGB(255, 15, 57, 65).withOpacity(0.03)
                                  //     .withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 106, 198, 238),
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color.fromARGB(
                                              255, 98, 154, 182)
                                          .withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 15,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                height: h * 0.2,
                                width: w,
                                child: slotContainer(
                                  context,
                                  state.slot_list.slots![index],
                                ),
                              ),
                            );
                          },
                          childCount: state.slot_list.slots!.length,
                        ),
                      );
                    } else if (state is EventSlotErrorState) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: w / 2.5,
                              ),
                              EmptyPage(
                                title: 'Error',
                                errorMessage: state.message.toString(),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is NoAvailableSlots) {
                      return SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SizedBox(
                              height: w / 2.7,
                            ),
                            const EmptyPage(
                              errorMessage:
                                  'Slot Booking isn\'t active for this event yet! ',
                              title: 'Slots Unavailable',
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SliverToBoxAdapter(
                        child: Center(child: Loader()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
