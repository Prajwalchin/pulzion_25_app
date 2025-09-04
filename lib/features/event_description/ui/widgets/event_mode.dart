import 'package:flutter/material.dart';

import '/constants/styles.dart';
import '../../../../constants/models/event_model.dart';

class EventMode extends StatelessWidget {
  final Events event;
  const EventMode({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.only(right: 2),
      child: Container(
        padding: const EdgeInsets.all(1.5),
        child: Text(
          ' ${event.mode ?? ''} Event ',
          style: AppStyles.NormalText().copyWith(
            fontSize: MediaQuery.of(context).size.height * 0.02,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
