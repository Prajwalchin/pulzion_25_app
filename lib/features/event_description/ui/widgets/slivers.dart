import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pulzion_25_app/constants/models/event_model.dart';
import 'package:pulzion_25_app/features/event_description/ui/widgets/background_sliver.dart';
import 'package:pulzion_25_app/features/event_description/ui/widgets/cover_photo.dart';
import 'package:pulzion_25_app/features/event_description/ui/widgets/data_cut_rectangle.dart';

class AppBarNetflix extends SliverPersistentHeaderDelegate {
  const AppBarNetflix({
    required this.event,
    required this.description,
    required this.maxExtended,
    required this.minExtended,
    required this.size,
  });
  final String description;
  final double maxExtended;
  final double minExtended;
  final Events event;
  final Size size;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / maxExtended;
    const uploadlimit = 33 / 100;
    final valueback = (1 - percent - 0.77).clamp(0, uploadlimit);
    final fixrotation = pow(percent, 1.5);

    final card = _CoverCard(
      size: size,
      percent: percent,
      uploadlimit: uploadlimit,
      valueback: valueback,
      img: event.logo!,
      eventId: event.id!,
    );

    final bottomsliverbar = _CustomBottomSliverBar(
      eventName: event.name!,
      eventMode: event.mode!,
      size: size,
      fixrotation: fixrotation,
      percent: percent,
    );

    return Stack(
      children: [
        const BackgroundSliver(
          eventDescription: '',
        ),
        if (percent > uploadlimit) ...[
          card,
          bottomsliverbar,
        ] else ...[
          bottomsliverbar,
          card,
        ],
      ],
    );
  }

  @override
  double get maxExtent => maxExtended;

  @override
  double get minExtent => minExtended;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _CoverCard extends StatelessWidget {
  const _CoverCard(
      {required this.size,
      required this.percent,
      required this.uploadlimit,
      required this.valueback,
      required this.img,
      required this.eventId});

  final Size size;
  final double percent;
  final double uploadlimit;
  final num valueback;
  final String img;
  final int eventId;

  final double angleForCard = 6.5;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: size.height * 0.18,
      left: size.width / 24,
      child: Transform(
        alignment: Alignment.topRight,
        transform: Matrix4.identity()
          ..rotateZ(percent > uploadlimit
              ? (valueback * angleForCard)
              : percent * angleForCard),
        child: CoverPhoto(
          size: size,
          imgUrl: img,
          eventId: eventId,
        ),
      ),
    );
  }
}

class _CustomBottomSliverBar extends StatelessWidget {
  const _CustomBottomSliverBar({
    required this.size,
    required this.fixrotation,
    required this.percent,
    required this.eventMode,
    required this.eventName,
  });
  final Size size;
  final num fixrotation;
  final double percent;
  final String eventMode;
  final String eventName;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: _CustomBottomSliver(
        size: size,
        percent: percent,
        eventName: eventName,
      ),
    );
  }
}

class _CustomBottomSliver extends StatelessWidget {
  const _CustomBottomSliver({
    required this.size,
    required this.percent,
    required this.eventName,
  });

  final Size size;
  final double percent;
  final String eventName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.1,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // CustomPaint(
          //   painter: CutRectangle(),
          // ),
          DataCutRectangle(
            eventName: eventName,
            size: size,
            percent: percent,
          )
        ],
      ),
    );
  }
}
