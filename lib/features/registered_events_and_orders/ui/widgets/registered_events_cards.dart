import 'package:flutter/material.dart';

import '/constants/models/event_model.dart';
import '../../../../constants/widgets/empty_page.dart';
import 'ticket_widget.dart';

class RegisteredEventsCards extends StatelessWidget {
  final List<Events> registeredEvents;
  final List<String> regsieteredCombos;

  const RegisteredEventsCards({
    super.key,
    required this.registeredEvents,
    required this.regsieteredCombos,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return registeredEvents.isEmpty
        ? const Center(
            child: EmptyPage(
              errorMessage:
                  'Go ahead and purchase some events and enjoy Pulzion\'24',
              title: 'No event registered',
            ),
          )
        : Padding(
            padding: EdgeInsets.all(size.width * 0.01),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: registeredEvents.length + regsieteredCombos.length,
              itemBuilder: (context, index) {
                return index < registeredEvents.length
                    ? MyTicketView(
                        id: registeredEvents[index].id!,
                        name: registeredEvents[index].name!,
                        description: registeredEvents[index].description!,
                        eventType: registeredEvents[index].type!,
                        logo: registeredEvents[index].logo!,
                        isBooked: registeredEvents[index].fk_slot,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: MyTicketView(
                          id: null,
                          name: regsieteredCombos[
                              index - registeredEvents.length],
                          description: null,
                          eventType: null,
                          logo: null,
                          isBooked: null,
                        ),
                      );
              },
            ),
          );
  }
}
