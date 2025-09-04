import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pulzion_25_app/constants/widgets/app_background.dart';
import 'package:pulzion_25_app/pages/developers_page/ui/card_responsive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/styles.dart';
import '../../../features/home_page/ui/wigets/custom_appbar.dart';
import '../../../project/cubit/animation_toggle_cubit.dart';
import 'info.dart';

class DevelopersPage extends StatefulWidget {
  const DevelopersPage({super.key});

  @override
  State<DevelopersPage> createState() => _DevelopersPageState();
}

class _DevelopersPageState extends State<DevelopersPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _move = !_move;
        }));
    super.initState();
  }

  var count = 20;
  bool _move = true;
  final _cacheManager = CacheManager(Config(
    'my_custom_cache_key',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
  ));

  var developersList = data;
  Future<void> _launchUniversalLinkApp(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  // Future<void> _launchInBrowser(Uri url) async {
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.externalApplication,
  //   )) {
  //     throw Exception('Could not launch $url');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        BlocConsumer<GlobalParameterCubit, bool>(
          listener: (context, state) {},
          buildWhen: (previous, current) {
            if (previous != current) {
              return true;
            }

            return false;
          },
          builder: (context, state) {
            return const AppBackground();
          },
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomAppBar(),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        top: h / 30,
                        left: h / 100,
                        right: h / 90,
                        child: Center(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.only(
                                left: h * 0.05,
                                right: h * 0.05,
                                top: h * 0.02,
                                bottom: h * 0.02,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.6),
                                    Colors.black.withOpacity(0.4),
                                    Colors.black.withOpacity(0.4),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 116, 194, 188)
                                          .withOpacity(0.8),
                                  width: 0.7,
                                ),
                              ),
                              child: Center(
                                child: FittedBox(
                                  clipBehavior: Clip.hardEdge,
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "{Developers Page}",
                                    style: AppStyles.TitleText().copyWith(
                                      fontFamily: 'Wallpoet',
                                      fontSize: 45,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container()),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? w * 0.25
                                : w * 0.5,
                        childAspectRatio: 1 / h * 650,
                        crossAxisSpacing: h * 0.009,
                        mainAxisSpacing: h * 0.009,
                      ),
                      itemCount: developersList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return DeveloperCard(
                          name: developersList[index].name,
                          imageUrl: developersList[index].imageUrl,
                          linkedInId: developersList[index].linkedInId,
                          emailId: developersList[index].emailId,
                          gitHubId: developersList[index].gitHubId,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
