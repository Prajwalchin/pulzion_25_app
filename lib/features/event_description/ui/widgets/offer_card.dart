import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pulzion_25_app/features/event_description/ui/widgets/dynamic_button_combo.dart';

import '/constants/models/event_model.dart';
import '/features/event_description/ui/widgets/lightOnOff.dart';
import '../../../../constants/styles.dart';
import '../../../combo_cubit/models/combo_model.dart';

// ignore: must_be_immutable
class OfferCard extends StatefulWidget {
  Combo combo;
  final List<Events> eventList;
  OfferCard({
    required this.combo,
    required this.eventList,
    super.key,
  });

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  final cacheManager = CacheManager(Config(
    'my_custom_cache_key',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
  ));

  @override
  Widget build(BuildContext context) {
    return widget.combo.comboDetailsList == null ||
            widget.combo.comboDetailsList!.isEmpty
        ? const SizedBox()
        : Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 39, 77).withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color.fromARGB(255, 106, 198, 238),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 98, 154, 182).withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    widget.combo.comboName ?? "",
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.NormalText().copyWith(
                        color: Colors.amber,
                        fontSize: MediaQuery.of(context).size.width * 0.065),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Column(
                    children: [
                      Column(
                        children: widget.combo.comboDetailsList!.map((event) {
                          return InkWell(
                            onTap: () {
                              Events? foundEvent;
                              for (var element in widget.eventList) {
                                if (element.name == event.name) {
                                  foundEvent = element;
                                }
                              }
                              if (foundEvent != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DarkSample(
                                      event: foundEvent!,
                                      resumeTimeFunction: () {},
                                    ),
                                    settings: RouteSettings(
                                      arguments: widget.eventList,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3.5,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.teal.shade400
                                              .withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 7,
                                      child: Text(
                                        event.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppStyles.NormalText().copyWith(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.13,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.019,
                                left:
                                    MediaQuery.of(context).size.height * 0.019,
                              ),
                              width: MediaQuery.of(context).size.width * 0.33,
                              child: FittedBox(
                                child: DynamicButtonCombo(
                                  combo: widget.combo,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.01),
                              child: Column(
                                children: [
                                  Text(
                                    '₹${widget.combo.comboTotalPrice.toString()}',
                                    style: AppStyles.NormalText().copyWith(
                                      fontSize: 17,
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    '₹${widget.combo.comboDiscountedPrice.toString()}',
                                    style: AppStyles.NormalText().copyWith(
                                      fontSize: 25,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
