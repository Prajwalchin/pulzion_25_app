import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:pulzion_25_app/constants/models/event_model.dart';
import 'package:pulzion_25_app/constants/styles.dart';
import 'package:pulzion_25_app/features/event_description/ui/widgets/contact_card.dart';
import 'package:pulzion_25_app/features/event_description/ui/widgets/event_mode.dart';
import 'package:pulzion_25_app/features/event_description/ui/widgets/offer_card.dart';
import 'package:url_launcher/url_launcher.dart';

Widget getDetails(BuildContext context, Events event, double h, double w) {
  return Container(
    padding: EdgeInsets.all(h * 0.02),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        EventMode(event: event),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            event.tagline!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: h * 0.02,
              fontFamily: 'Wallpoet',
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          alignment: Alignment.center,
          padding: EdgeInsets.all(w * 0.02),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 39, 77).withOpacity(0.5),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: const Color.fromARGB(255, 106, 198, 238),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 98, 154, 182).withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              event.description!,
              style: AppStyles.NormalText().copyWith(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Team Details',
            style: AppStyles.NormalText().copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 39, 77).withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color.fromARGB(255, 106, 198, 238),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 98, 154, 182)
                      .withOpacity(0.2), // Slightly transparent shadow
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  event.teams!,
                  // textAlign: TextAlign.start,
                  style: AppStyles.NormalText().copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04),
          child: Text(
            'Event Leads',
            style: AppStyles.NormalText().copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        ContactCard(event: event),
      ],
    ),
  );
}

Widget parseAndDisplayLinks(String text, BuildContext context) {
  return Linkify(
    onOpen: (url) async {
      final bool nativeAppLaunchSucceeded = await launchUrl(
        Uri.parse(url.text),
      );
      if (!nativeAppLaunchSucceeded) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Registered Successfully',
              style: AppStyles.NormalText().copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.teal,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    },
    text: text,
    style: AppStyles.NormalText().copyWith(
      color: Theme.of(context).primaryColor,
      fontSize: 20,
    ),
    options: const LinkifyOptions(humanize: false),
    linkStyle: const TextStyle(
      color: Colors.orange,
      decoration: TextDecoration.underline,
    ),
  );
}

Widget getRounds(BuildContext context, Events event, double h, double w) {
  return Container(
    padding: EdgeInsets.all(h * 0.02),
    margin: EdgeInsets.all(h * 0.02),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 0, 39, 77).withOpacity(0.5),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: const Color.fromARGB(255, 106, 198, 238),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 98, 154, 182).withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 15,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Scrollbar(
      child: SingleChildScrollView(
        child: parseAndDisplayLinks(
          event.rounds ?? '',
          context,
        ),
      ),
    ),
  );
}

Widget getRules(BuildContext context, Events event, double h, double w) {
  return Container(
    padding: EdgeInsets.all(h * 0.02),
    margin: EdgeInsets.all(h * 0.02),
    alignment: Alignment.topCenter,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 0, 39, 77).withOpacity(0.5),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: const Color.fromARGB(255, 106, 198, 238),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 98, 154, 182).withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 15,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Text(
            event.rules ?? '',
            style: AppStyles.NormalText().copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

Widget getCombos(BuildContext context, Events event, double h, double w,
    List<Events> eventList) {
  return Builder(
    builder: (context) {
      return event.offers == null || event.offers!.isEmpty
          ? Container(
              padding: EdgeInsets.all(h * 0.02),
              margin: EdgeInsets.all(h * 0.02),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 39, 77).withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color.fromARGB(255, 106, 198, 238),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 98, 154, 182)
                        .withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20.0), // Adjust padding to place text near the top
                child: Text(
                  'No combos available for ${event.name}...\nPlease register for it as an individual event',
                  textAlign: TextAlign.center, // Center the text horizontally
                  style: AppStyles.NormalText().copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: event.offers == null
                  ? 0
                  : event.offers == null
                      ? 0
                      : event.offers!.length,
              itemBuilder: (context, index) {
                final comboo = event.offers![index];

                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: h * 0.015,
                    horizontal: h * 0.025,
                  ),
                  child: OfferCard(
                    combo: comboo,
                    eventList: eventList,
                  ),
                );
              },
            );
    },
  );
}
