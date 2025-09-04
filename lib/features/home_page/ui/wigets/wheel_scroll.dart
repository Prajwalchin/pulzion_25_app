import 'dart:async';

import 'package:flutter/material.dart';
import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';
import 'package:pulzion_25_app/constants/models/event_model.dart';
import 'package:pulzion_25_app/features/home_page/ui/wigets/new_card.dart';

class WheelScroll extends StatefulWidget {
  final List<Events> eventList;
  final int itemCount;
  final Function(int) onItemChanged; // Callback to notify current index

  const WheelScroll({
    super.key,
    required this.eventList,
    required this.itemCount,
    required this.onItemChanged,
  });

  @override
  State<WheelScroll> createState() => _WheelScrollState();
}

class _WheelScrollState extends State<WheelScroll> {
  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  // Start auto-scrolling the cards
  void _startAutoScroll() {
    _timer = Timer.periodic(
      const Duration(seconds: 8),
      (Timer timer) {
        if (_currentIndex < widget.eventList.length - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }
        _scrollController.animateToItem(
          _currentIndex,
          duration: const Duration(seconds: 4),
          curve: Curves.easeInOut,
        );
        widget.onItemChanged(_currentIndex);
      },
    );
  }

  void _pauseAutoScroll() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
  }

  void _resumeAutoScroll() {
    if (_timer == null || !_timer!.isActive) {
      _startAutoScroll();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.only(top: size.height * 0.01),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.3,
            child: ListWheelScrollViewX(
              controller: _scrollController,
              itemExtent: MediaQuery.of(context).size.width * 0.7,
              squeeze: 1,
              scrollDirection: Axis.horizontal,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
                widget.onItemChanged(
                    _currentIndex); // Notify parent of manual scroll change
              },
              children: widget.eventList.map((event) {
                return GestureDetector(
                  // onTapDown: (_) {
                  //   _pauseAutoScroll(); // Pause auto-scroll when the card is pressed
                  // },
                  // onTapUp: (_) {
                  //   _resumeAutoScroll(); // Resume auto-scroll when the card is released
                  // },
                  // onTapCancel: () {
                  //   _resumeAutoScroll(); // Resume auto-scroll if the tap is canceled
                  // },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: NewCard(
                      event: event,
                      title: event.name ?? "Event Name",
                      description: event.tagline ?? "Event Description",
                      logoPath: event.logo ?? 'assets/default_logo.png',
                      pauseTimeFunction: _pauseAutoScroll,
                      resumeTimeFunction: _resumeAutoScroll,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
