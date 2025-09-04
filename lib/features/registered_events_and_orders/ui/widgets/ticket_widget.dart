import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion_25_app/constants/widgets/custom_buttons.dart';
import 'package:pulzion_25_app/features/home_page/logic/event_details_cubit_cubit.dart';

import '/config/size_config.dart';
import '/constants/styles.dart';
import '/features/event_slots/ui/booked_window.dart';
import '/features/event_slots/ui/view_slot_details.dart';
import '/features/registered_events_and_orders/cubit/registered_events_and_orders_cubit.dart';
import '../../../event_slots/logic/booked_slot_cubit.dart';

class MyTicketView extends StatelessWidget {
  final String name;
  final String? description;
  final int? isBooked;
  final String? eventType;
  final int? id;
  final String? logo;

  const MyTicketView({
    super.key,
    required this.name,
    required this.description,
    required this.eventType,
    required this.id,
    required this.logo,
    required this.isBooked,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var th = height / 2.3;
    var tw = width / 1.6;

    final bloc =
        BlocProvider.of<RegisteredEventsAndOrdersCubit>(context, listen: false);

    final registeredEvents =
        (bloc.state as RegisteredEventsAndOrdersLoaded).registeredEvents;
    final registeredOrders =
        (bloc.state as RegisteredEventsAndOrdersLoaded).registeredOrders;
    final registeredCombos =
        (bloc.state as RegisteredEventsAndOrdersLoaded).registeredCombos;

    return Container(
      padding: EdgeInsets.all(width * 0.02),
      margin: EdgeInsets.all(width * 0.02),
      child: Container(
        width: width * 0.9,
        height: height * 0.3,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(255, 83, 214, 192),
            width: 0.6,
          ),
          borderRadius: BorderRadius.circular(th * 0.02),
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 16, 108, 124).withOpacity(0.5),
              const Color.fromARGB(255, 10, 98, 89).withOpacity(0.4),
              const Color.fromARGB(255, 4, 71, 91).withOpacity(0.3),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              if (id == null)
                SizedBox(
                  child: Text(
                    'Combo',
                    textAlign: TextAlign.center,
                    style: AppStyles.NormalText().copyWith(
                      fontSize: SizeConfig.getProportionateScreenFontSize(25),
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Text(
                '<$name/>',
                textAlign: TextAlign.center,
                style: AppStyles.NormalText().copyWith(
                  color: Colors.amber,
                  fontFamily: 'Wallpoet',
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (eventType != null)
                Text(
                  eventType!,
                  textAlign: TextAlign.center,
                  style: AppStyles.NormalText().copyWith(
                    fontSize: SizeConfig.getProportionateScreenFontSize(17),
                    color: const Color.fromARGB(255, 83, 214, 192),
                  ),
                ),
              const Spacer(),
              Divider(
                color: const Color.fromARGB(255, 83, 214, 192).withOpacity(0.8),
                thickness: 0.8,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Padding(
                padding: EdgeInsets.only(
                  bottom: height * 0.02,
                  left: width * 0.01,
                  right: width * 0.01,
                ),
                child: isBooked != null
                    ? Text(
                        "You have booked slot for this event",
                        style: AppStyles.NormalText().copyWith(
                            fontSize: SizeConfig.getProportionateScreenFontSize(
                                MediaQuery.of(context).size.height * 0.02),
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        id == null
                            ? "You have booked this combo"
                            : "You haven't booked a slot for this event",
                        style: AppStyles.NormalText().copyWith(
                          fontSize:
                              SizeConfig.getProportionateScreenFontSize(16),
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ),
              if (id != null)
                Center(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.08,
                      bottom: MediaQuery.of(context).size.width * 0.02,
                    ),
                    width: tw * 0.6,
                    child: TechButton(
                      scale: 1,
                      buttonText:
                          isBooked != null ? 'View Ticket' : 'Book Slot',
                      onTap: () {
                        isBooked != null
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => BlocProvider<
                                      RegisteredEventsAndOrdersCubit>.value(
                                    value: bloc..getOnlyRegisteredEvents(),
                                    child: ViewSlotDetails(
                                      id: id!,
                                      logo: logo!,
                                      name: name,
                                      onPop: () {
                                        bloc.emitRegisteredEventsAndOrdersState(
                                          registeredEvents,
                                          registeredOrders,
                                          registeredCombos,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider(
                                        create: (context) => EventSlotsCubit()
                                          ..getAvailableSlots(id!),
                                      ),
                                      BlocProvider.value(
                                        value: BlocProvider.of<
                                            RegisteredEventsAndOrdersCubit>(
                                          context,
                                        ),
                                      ),
                                      BlocProvider.value(
                                        value: BlocProvider.of<
                                            EventDetailsCubitCubit>(
                                          context,
                                        ),
                                      ),
                                    ],
                                    child: BookSlots(
                                      id: id!,
                                      name: name,
                                      logo: logo!,
                                    ),
                                  ),
                                ),
                              );
                      },
                    ),
                  ),
                ),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketListView extends StatelessWidget {
  final List<MyTicketView> tickets;

  const TicketListView({super.key, required this.tickets});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: tickets.map((ticket) => ticket).toList(),
      ),
    );
  }
}
