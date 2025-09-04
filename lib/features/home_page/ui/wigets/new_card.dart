import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulzion_25_app/config/event_logo_urls.dart';
import 'package:pulzion_25_app/constants/audio.dart';
import 'package:pulzion_25_app/constants/images.dart';
import 'package:pulzion_25_app/constants/models/event_model.dart';
import 'package:pulzion_25_app/features/event_description/ui/widgets/lightOnOff.dart';
import 'package:pulzion_25_app/features/home_page/logic/event_details_cubit_cubit.dart';

class NewCard extends StatelessWidget {
  NewCard(
      {super.key,
      required this.description,
      required this.title,
      required this.logoPath,
      required this.event,
      required this.pauseTimeFunction,
      required this.resumeTimeFunction});

  final String description;
  final String title;
  final String logoPath;
  final Events event;
  final Function pauseTimeFunction;
  final Function resumeTimeFunction;
  final _cacheManager = CacheManager(
    Config(
      'my_custom_cache_key',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );

  @override
  Widget build(BuildContext context) {
    String? errorImg = eventLogoImageUrlMap[event.id];
    return GestureDetector(
      child: Container(
        width: 237.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26.r),
        ),
        child: Container(
          width: 240.w,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 16, 24, 31),
            borderRadius: BorderRadius.circular(26.r),
            image: const DecorationImage(
              opacity: 0.7,
              fit: BoxFit.cover,
              image: AssetImage(AppImages.homePageFrame),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                CircleAvatar(
                    radius: 34.r,
                    backgroundColor: Colors.transparent,
                    child: CachedNetworkImage(
                      imageUrl: logoPath,
                      color: Colors.white,
                      fadeInCurve: Curves.decelerate,
                      height: 50.r,
                      placeholder: (context, url) => Container(),
                      errorWidget: (context, url, error) =>
                          Image.network(eventLogoImageUrlMap[event.id]!),
                      cacheManager: _cacheManager,
                      fadeInDuration: const Duration(milliseconds: 100),
                      fit: BoxFit.fitWidth,
                      key: UniqueKey(),
                    )),
                SizedBox(height: 7.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  margin: EdgeInsets.symmetric(horizontal: 3.h),
                  child: Text(
                    '<${title.toUpperCase()}/>',
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Wallpoet',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 5.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.47,
                  child: Text(
                    description,
                    style: TextStyle(
                      color: const Color.fromRGBO(225, 186, 102, 1),
                      fontSize: 16.sp,
                      height: 1.2,
                      fontFamily: 'VT323',
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 14.h),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        pauseTimeFunction();
        Singleton().player.playClick();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DarkSample(
              event: event,
              resumeTimeFunction: resumeTimeFunction,
            ),
            settings: RouteSettings(
              arguments: (BlocProvider.of<EventDetailsCubitCubit>(context).state
                      as EventDetailsCubitLoaded)
                  .events
                  .events as List<Events>,
            ),
          ),
        );
      },
    );
  }
}
