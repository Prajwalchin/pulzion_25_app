import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '/constants/models/event_model.dart';
import '/constants/styles.dart';

Future<void> openWhatsAppChat(String phoneNumber) async {
  final whatsappUrl = Uri.parse('whatsapp://send?phone=$phoneNumber');
  if (!await launchUrl(whatsappUrl)) {
    throw 'Could not launch WhatsApp URL';
  }
}

String extractPhoneNumbers(String message) {
  return message.replaceAll(RegExp(r'[^0-9]'), '');
}

class ContactCard extends StatelessWidget {
  final Events event;
  const ContactCard({super.key, required this.event});

  List<String> extractedNames(String msg) {
    return msg.split('\n');
  }

  List<List<String>> extractLeads() {
    RegExp nameRegExp = RegExp(r'name:\s*([A-Za-z]+)');
    RegExp phoneRegExp = RegExp(r'phone:\s*(\d{10})');

    List<String> names = [];
    List<String> phones = [];

    Iterable<RegExpMatch> nameMatches = nameRegExp.allMatches(event.notes!);
    Iterable<RegExpMatch> phoneMatches = phoneRegExp.allMatches(event.notes!);

    for (var match in nameMatches) {
      names.add(match.group(1)!);
    }

    for (var match in phoneMatches) {
      phones.add(match.group(1)!);
    }

    return [names, phones];
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double w = MediaQuery.of(context).size.width;

    if (event.notes == null) {
      return Container();
    }

    final result = extractLeads();

    List<String> names = result[0];
    List<String> phones = result[1];

    if (names.isEmpty || names.length != phones.length) {
      return Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        // width: MediaQuery.of(context).size.width * 0.2,
        // margin: const EdgeInsets.only(bottom: 300),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 39, 77).withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromARGB(255, 106, 198, 238),
            width: 0.7,
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Text(
            event.notes!,
            style: AppStyles.NormalText().copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: phones.length,
      itemBuilder: (context, index) => MyWidget(
        name: names[index],
        phone: '+91${phones[index]}',
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final String name;
  final String phone;
  const MyWidget({super.key, required this.name, required this.phone});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => openWhatsAppChat(
        extractPhoneNumbers(phone),
      ),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
        // width: MediaQuery.of(context).size.width * 0.2,
        // margin: const EdgeInsets.only(bottom: 300),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 39, 77).withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromARGB(255, 106, 198, 238),
            width: 0.7,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => openWhatsAppChat(phone),
              icon: const Icon(
                FontAwesomeIcons.whatsapp,
                color: Colors.green,
              ),
              color: Colors.white,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                "$name : $phone",
                style: AppStyles.NormalText().copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
