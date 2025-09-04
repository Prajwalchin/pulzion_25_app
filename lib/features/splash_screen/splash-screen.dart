import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion_25_app/constants/widgets/error_dialog.dart';
import 'package:video_player/video_player.dart';

import '/features/splash_screen/cubit/splash_cubit.dart';
import '/main.dart';
import '/project/cubit/animation_toggle_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          //log(state.toString());
          if (state is SplashPreInitial) {
            BlocProvider.of<SplashCubit>(context).checkSplash();

            return Container();
          } else if (state is SplashInitial) {
            BlocProvider.of<SplashCubit>(context).init();

            return Container();
          } else if (state is SplashScreenDone || state is NoSplashScreen) {
            BlocProvider.of<GlobalParameterCubit>(context).init();
            // BlocProvider.of<GlobalParameterCubit>(context).soundOnOff();

            return const Pulzion24App();
          } else if (state is SplashStart) {
            BlocProvider.of<SplashCubit>(context).start();
            final controller = BlocProvider.of<SplashCubit>(context).controller;

            return Center(
              child: AspectRatio(
                aspectRatio: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height,
                child: VideoPlayer(controller),
              ),
            );
          } else if (state is SplashLoading) {
            return Container();
          }

          return const ErrorDialog("Something went wrong");
        },
      ),
    );
  }
}
