import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion_25_app/constants/audio.dart';
import 'package:pulzion_25_app/constants/widgets/app_background.dart';
import 'package:pulzion_25_app/constants/widgets/custom_buttons.dart';

import '/features/login_page/ui/widgets/enter_email.dart';
import '../../../constants/styles.dart';
import '../../../constants/widgets/loader.dart';
import '../../../project/cubit/animation_toggle_cubit.dart';
import '../cubit/check_login_cubit.dart';
import '../logic/login_cubit.dart';
import 'widgets/go_back_button.dart';
import 'widgets/text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var padding = MediaQuery.of(context).padding;

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
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: GoBackButton(context),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: true,
          body: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) async {
              if (state is LoginSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Login Successful",
                      style: AppStyles.NormalText().copyWith(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                );
                await context.read<CheckLoginCubit>().checkLogin();
                if (mounted) {
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
              }
              if (state is LoginFailure) {
                if (mounted) {
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
              } else if (state is LoginError) {
                if (mounted) {
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
              }
            },
            builder: (context, state) {
              if (state is LoginInitial ||
                  state is LoginFailure ||
                  state is LoginError) {
                return SingleChildScrollView(
                    child: Container(
                  padding: EdgeInsets.all(size.width * 0.04),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color.fromARGB(255, 109, 223, 211),
                          width: 1),
                      gradient: LinearGradient(colors: [
                        const Color.fromARGB(255, 16, 108, 124)
                            .withOpacity(0.3),
                        const Color.fromARGB(255, 10, 98, 89).withOpacity(0.2),
                        const Color.fromARGB(255, 4, 71, 91).withOpacity(0.3)
                      ])),
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height * 0.31,
                          width: size.height * 0.37,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.00),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                border:
                                    Border.all(color: Colors.amber, width: 0.5),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/login_intro_image.gif'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          'Please login to continue.',
                          style: AppStyles.NormalText().copyWith(
                            fontSize: size.height * 0.025,
                            color: const Color.fromARGB(255, 208, 168, 116),
                          ),
                        ),
                        LoginSignUpTextField(
                          'Email',
                          Icons.email,
                          controller: emailController,
                          obscureText: false,
                        ),
                        LoginSignUpTextField(
                          'Password',
                          Icons.lock,
                          controller: passwordController,
                          obscureText: true,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Singleton().player.playClick();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => LoginCubit(),
                                    child: const GetUserEmail(),
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Forgot Password?',
                                style: AppStyles.NormalText().copyWith(
                                  fontSize: 20,
                                  color:
                                      const Color.fromARGB(255, 190, 232, 228),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TechButton(
                            buttonText: 'Login',
                            scale: size.height * 0.0012,
                            onTap: () async {
                              context.read<LoginCubit>().login(
                                    emailController.text,
                                    passwordController.text,
                                  );
                            },
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ));
              }
              if (state is LoginLoading) {
                return const Center(child: Loader());
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
