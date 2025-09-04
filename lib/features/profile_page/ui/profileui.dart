import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion_25_app/constants/images.dart';

import '/constants/styles.dart';
import '../../../constants/widgets/error_dialog.dart';
import '../../../constants/widgets/loader.dart';
import '../../../project/cubit/animation_toggle_cubit.dart';
import '../cubit/profile_cubit.dart';
import 'card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        BlocConsumer<GlobalParameterCubit, bool>(
          listener: (context, state) {},
          buildWhen: (previous, current) {
            if (previous != current) {
              return true;
            }

            return false;
          },
          builder: (context, state) {
            return Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                // color: Colors.transparent
                image: DecorationImage(
                  image: AssetImage(AppImages.appBackground),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: AppStyles.NormalText().copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.07,
                          ),
                          Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                AppImages.framebg,
                              ))),
                              height: h * 0.2,
                              width: w * 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                          'https://i.pinimg.com/originals/cd/6d/4d/cd6d4d9bc747cbf4ea72aeb06b1f2eb8.gif',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    width: h * 0.13,
                                    height: h * 0.13,
                                    // color: Colors.amber,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        //  top: h*0.04
                                        ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "<${state.user.firstName!}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.amber,
                                              fontFamily: 'Wallpoet'),
                                        ),
                                        Text(
                                          "${state.user.lastName!}/>",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.amber,
                                              fontFamily: 'Wallpoet'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      Container(
                        margin: EdgeInsets.all(w * 0.03),
                        padding: EdgeInsets.all(w * 0.02),
                        child: Column(
                          children: [
                            Container(
                              child: cardDesign(
                                "USERNAME",
                                h,
                                w,
                                state.user.email!.split('@')[0],
                                const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                // Image(image: AssetImage('assets/images/skull.png')),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Container(
                              child: cardDesign(
                                "EMAIL",
                                h,
                                w,
                                state.user.email!,
                                const Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                // Image(image: AssetImage('assets/images/potion.png')),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Container(
                              child: cardDesign(
                                "REFERRAL CODE",
                                h,
                                w,
                                state.user.referralCode,
                                const Icon(
                                  Icons.gamepad,
                                  color: Colors.white,
                                ),
                                // Image(image: AssetImage('assets/images/rip.png')),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Container(
                              child: cardDesign(
                                "CONTACT NO.",
                                h,
                                w,
                                state.user.mobileNumber,
                                const Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                // Image(image: AssetImage('assets/images/jar.png')),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Container(
                              child: cardDesign(
                                "YEAR",
                                h,
                                w,
                                state.user.year,
                                const Icon(
                                  Icons.school,
                                  color: Colors.white,
                                ),
                                // Image(image: AssetImage('assets/images/hallo.png')),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                            Container(
                              child: cardDesign(
                                "COLLEGE",
                                h,
                                w,
                                state.user.college,
                                const Icon(
                                  Icons.book,
                                  color: Colors.white,
                                ),
                                // Image(image: AssetImage('assets/images/rip.png')),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.01,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 0.0000001, width: double.infinity),
                    ],
                  ),
                );
              } else if (state is ProfileError) {
                return Column(
                  children: [
                    SizedBox(
                      height: h * 0.3,
                    ),
                    Center(
                      child: ErrorDialog(
                        state.message,
                        refreshFunction: () {
                          context.read<ProfileCubit>().getUser();
                        },
                      ),
                    ),
                  ],
                );
              }

              return Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.3,
                    ),
                    const Loader(),
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
