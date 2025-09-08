// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pulzion_25_app/constants/audio.dart';

import '/constants/urls.dart';
import '/features/event_slots/logic/booked_slot_cubit.dart';
import '/features/mcq/features/mcq_login/logic/cubit/mcq_login_cubit.dart';
import '/features/splash_screen/cubit/splash_cubit.dart';
import '/project/cubit/animation_toggle_cubit.dart';
import 'config/remote_config.dart';
import 'features/cart_page/cubit/cart_page_cubit.dart';
import 'features/compulsory_update/cubit/compulsory_update_cubit.dart';
import 'features/compulsory_update/ui/compulsary_update.dart';
import 'features/home_page/logic/event_details_cubit_cubit.dart';
import 'features/login_page/cubit/check_login_cubit.dart';
import 'features/splash_screen/splash-screen.dart';
import 'firebase_options.dart';
import 'project/cubit/bottom_bar_cubit.dart';
import 'project/landing_page.dart';
import 'services/bloc_observer.dart';
import 'services/local_notifications.dart';

Future<void> main() async {
  // await dotenv.load(fileName: StaticURLs.envPath);

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 75, 30, 30),
    ),
  );
  // await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform, name: 'pulzion-24-app');

  // await remoteConfig();

  // Then initialize the local notification service
  // LocalNotificationService.initialize();
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await Firebase.initializeApp();
  // await FirebaseNotifications.initialize();

  //log("Starting app");
  if (kDebugMode) {
    Bloc.observer = PulzionBlocObserver();
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SplashCubit()),
        BlocProvider(create: (context) => GlobalParameterCubit()),
      ],
      child: const SplashScreen(),
    ),
  );
}

class Pulzion24App extends StatefulWidget {
  const Pulzion24App({super.key});

  @override
  State<Pulzion24App> createState() => _Pulzion24AppState();
}

class _Pulzion24AppState extends State<Pulzion24App>
    with WidgetsBindingObserver {
  late AppLifecycleState appLifecycle;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    appLifecycle = state;
    //log(state.toString());
    setState(() {});
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      // check if MCQ was running or not
      // get sharedprefs
      // final prefs = await SharedPreferences.getInstance();
      // int? val = prefs.getInt('qID');
      // if (val != null) {
      //   if (val == 0) {
      //     //log('value of val changing from 0 to 1');
      //     await prefs.setInt('qID', 1);
      //     val = prefs.getInt('qID');
      //     //log('value of val is $val');
      //     Fluttertoast.showToast(
      //       msg: 'Warning: Quiz is running. Please do not leave the app!',
      //     );
      //   } else if (val == 2) {
      //     // stop the quiz
      //     await prefs.setInt('qID', 3);
      //     Fluttertoast.showToast(
      //       msg: 'Auto-submitting your quiz!',
      //     );
      //   }
      // }
      //stop your audio player

      // BlocProvider.of<GlobalParameterCubit>(context).stopSound();
    }
    else if (state == AppLifecycleState.resumed) {
      //start or resume your audio player
      // BlocProvider.of<GlobalParameterCubit>(context).initializeAudioPlayer();
      BlocProvider.of<GlobalParameterCubit>(context).init();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // void initFirebase() async {
  //   if (EndPoints.baseUrl != null || EndPoints.baseUrl != '') return;
  //   await remoteConfig();
  // }

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<List<ConnectivityResult>>(
    //   stream: Connectivity().onConnectivityChanged,
    //   builder: (context, snapshot) {
    //     final isConnected = snapshot.hasData &&
    //         !snapshot.data!.contains(ConnectivityResult.none);

    //     if (isConnected) {
          // initFirebase();
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CheckLoginCubit()..checkLogin(),
              ),
              BlocProvider(
                create: (context) => CompulsoryUpdateCubit()..needsUpdate(),
              ),
              BlocProvider(
                create: (context) => CartPageCubit()..loadCart(),
              ),
              BlocProvider(
                create: (context) => EventSlotsCubit(),
              ),
              BlocProvider(
                create: (context) => McqLoginCubit(),
              ),
            ],
            child: MaterialApp(
              theme: ThemeData(
                primaryColor: const Color.fromARGB(255, 78, 48, 21),
              ),
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: child!,
                );
              },
              title: 'Pulzion Tech Across Ages',
              debugShowCheckedModeBanner: false,
              home: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (BuildContext context) => BottomBarCubit(),
                  ),
                  BlocProvider(
                    create: (context) =>
                        EventDetailsCubitCubit()..getEventsDetails(),
                  ),
                ],
                child:
                    BlocBuilder<CompulsoryUpdateCubit, CompulsoryUpdateState>(
                  builder: (context, state) {
                    //log(state.toString());
                    if (state is CompulsoryUpdateLoading) {
                      return Container();
                    } else if (state is CompulsoryUpdateNeeded) {
                      return const CompulsoryUpdatePage();
                    } else if (state is CompulsoryUpdateNotNeeded) {
                      Singleton().player.loadAudioStatus();
                      return BottomNavBar();
                    } else {
                      return Center(child: ErrorWidget("Something went wrong"));
                    }
                  },
                ),
              ),
            ),
          );
    //     } else {
    //       return MaterialApp(
    //         builder: (context, child) {
    //           return MediaQuery(
    //             data: MediaQuery.of(context)
    //                 .copyWith(textScaler: const TextScaler.linear(1.0)),
    //             child: child!,
    //           );
    //         },
    //         home: Scaffold(
    //           backgroundColor: Colors.black,
    //           body: Center(
    //             child: Container(
    //               margin:
    //                   EdgeInsets.all(MediaQuery.of(context).size.width * 0.2),
    //               padding:
    //                   EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
    //               decoration: BoxDecoration(
    //                   border: Border.all(
    //                       color: const Color.fromARGB(255, 22, 172, 157),
    //                       width: 0.9),
    //                   color: const Color.fromARGB(255, 39, 176, 197)
    //                       .withOpacity(0.4),
    //                   borderRadius: BorderRadius.circular(12)),
    //               child: const Text(
    //                 'Please check your internet connection and try again...',
    //                 style: TextStyle(
    //                     fontSize: 18, color: Colors.amber, fontFamily: 'VT323'),
    //                 textAlign: TextAlign.center,
    //               ),
    //             ),
    //           ),
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
