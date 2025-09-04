import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pulzion_25_app/config/event_logo_urls.dart';

class CoverPhoto extends StatelessWidget {
  CoverPhoto({
    super.key,
    required this.size,
    required this.imgUrl,
    required this.eventId,
  });

  final Size size;
  final String imgUrl;
  final int eventId;

  final cacheManager = CacheManager(
    Config(
      'my_custom_cache_key',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.teal.shade100,
          width: 1,
        ),
        gradient: RadialGradient(
          colors: [
            // const Color.fromARGB(255, 0, 0, 0),
            const Color.fromARGB(255, 0, 0, 0),
            const Color.fromARGB(255, 0, 0, 0),
            const Color.fromARGB(255, 5, 88, 104).withOpacity(0.7),
            const Color.fromARGB(255, 46, 112, 153).withOpacity(0.7),
          ],
        ),
      ),
      width: size.width * 0.26,
      height: size.height * 0.13,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          color: Colors.white,
          placeholder: (context, url) => Container(),
          errorWidget: (context, url, error) => Image.network(
            eventLogoImageUrlMap[eventId]!,
          ),
          cacheManager: cacheManager,
          fadeInDuration: const Duration(
            milliseconds: 100,
          ),
          fit: BoxFit.fitWidth,
          key: UniqueKey(),
        ),
      ),
    );
  }
}
