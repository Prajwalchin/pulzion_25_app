import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pulzion_25_app/constants/widgets/app_background.dart';
import 'package:pulzion_25_app/constants/widgets/custom_buttons.dart';
import 'package:pulzion_25_app/constants/widgets/error_dialog.dart';
import 'package:pulzion_25_app/constants/widgets/loader.dart';

import '/config/size_config.dart';
import '/constants/styles.dart';
import '/features/login_page/logic/login_cubit.dart';
import '/features/login_page/ui/login.dart';
import '/features/login_page/ui/widgets/text_field.dart';
import '../../../../project/cubit/animation_toggle_cubit.dart';

class GetUserEmail extends StatefulWidget {
  const GetUserEmail({super.key});

  @override
  State<GetUserEmail> createState() => _GetUserEmailState();
}

class _GetUserEmailState extends State<GetUserEmail> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late String email;
  @override
  void dispose() {
    otpController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is UserNotFound) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "User Not Found!",
                    style: AppStyles.NormalText().copyWith(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.teal,
                ),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Something went wrong...",
                    style: AppStyles.NormalText().copyWith(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.teal,
                ),
              );
            } else if (state is OTPSent) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "OTP Sent Successfully!",
                    style: AppStyles.NormalText().copyWith(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.teal,
                ),
              );
            } else if (state is PasswordChangedSuccess) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Password Changed Successfully!",
                    style: AppStyles.NormalText().copyWith(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.teal,
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => LoginCubit(),
                    child: const Login(),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is UserNotFound) {
              return const Center(
                child: ErrorDialog('User not found!'),
              );
            } else if (state is LoginFailure || state is LoginFailure) {
              return const Center(
                child: ErrorDialog('Something went wrong...'),
              );
            } else if (state is OTPSent) {
              return Material(
                color: Colors.transparent,
                child: SafeArea(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    alignment: Alignment.center,
                    // color: Colors.red,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color.fromARGB(255, 109, 223, 211),
                            width: 1),
                        gradient: LinearGradient(colors: [
                          const Color.fromARGB(255, 16, 108, 124)
                              .withOpacity(0.3),
                          const Color.fromARGB(255, 10, 98, 89)
                              .withOpacity(0.2),
                          const Color.fromARGB(255, 4, 71, 91).withOpacity(0.3)
                        ])),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Text(
                            'Enter new Password',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 208, 168, 116),
                                fontSize:
                                    SizeConfig.getProportionateScreenFontSize(
                                        20),
                                fontFamily: 'Wallpoet'),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          Form(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Enter OTP',
                                    style: AppStyles.NormalText().copyWith(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.06,
                                      color: Color.fromARGB(255, 221, 175, 113),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02, // Space between the label and OTP input
                                  ),
                                  PinCodeTextField(
                                    textStyle: TextStyle(
                                      color: Colors.amber,
                                      fontFamily: 'VT323',
                                    ),
                                    appContext: context,
                                    length: 6,
                                    controller: otpController, // OTP Controller
                                    obscureText: false,
                                    keyboardType: TextInputType.number,
                                    pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      fieldHeight:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      fieldWidth:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      activeFillColor: Colors.transparent,
                                      activeColor: Colors.amber,
                                      selectedFillColor: Colors.transparent,
                                      selectedColor: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      inactiveFillColor: Colors.transparent,
                                      inactiveColor:
                                          const Color.fromARGB(255, 8, 153, 161)
                                              .withOpacity(0.8),
                                    ),
                                    backgroundColor: Colors.transparent,
                                    enableActiveFill:
                                        true, // Keeps the fields filled with background color
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  LoginSignUpTextField(
                                    'Enter new password',
                                    Icons.password,
                                    controller: passwordController,
                                    obscureText: true,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  LoginSignUpTextField(
                                    'Confirm Password',
                                    Icons.lock,
                                    controller: confirmPasswordController,
                                    obscureText: true,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width / 3.5,
                            ),
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: TechButton(
                              buttonText: "Reset",
                              scale: 1,
                              onTap: () async {
                                if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Passwords do not match!",
                                        style: AppStyles.NormalText().copyWith(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      backgroundColor: Colors.teal,
                                    ),
                                  );

                                  return;
                                }
                                await BlocProvider.of<LoginCubit>(context)
                                    .resetPassword(
                                  otpController.text,
                                  passwordController.text,
                                  email,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is LoginInitial) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.height * 0.01),
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.height * 0.01),
                      height: MediaQuery.of(context).size.height * 0.36,
                      alignment: Alignment.center,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color.fromARGB(255, 109, 223, 211),
                              width: 1),
                          gradient: LinearGradient(colors: [
                            const Color.fromARGB(255, 16, 108, 124)
                                .withOpacity(0.3),
                            const Color.fromARGB(255, 10, 98, 89)
                                .withOpacity(0.2),
                            const Color.fromARGB(255, 4, 71, 91)
                                .withOpacity(0.3)
                          ])),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            Text(
                              'Reset Password',
                              style: AppStyles.NormalText().copyWith(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03,
                                color: const Color.fromARGB(255, 208, 168, 116),
                                // fontWeight: FontWeight.bold,
                                fontFamily: 'Wallpoet',
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.04,
                            ),
                            LoginSignUpTextField(
                              'Enter your email',
                              Icons.email,
                              controller: emailController,
                              obscureText: false,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            TechButton(
                              buttonText: 'Send OTP',
                              scale: 1,
                              onTap: () async {
                                email = emailController.text;
                                await BlocProvider.of<LoginCubit>(context)
                                    .sendOTP(
                                  emailController.text,
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: Loader(),
              );
            }
          },
        ),
      ],
    );
  }
}
