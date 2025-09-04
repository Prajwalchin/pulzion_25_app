import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion_25_app/constants/styles.dart';
import 'package:pulzion_25_app/constants/widgets/custom_buttons.dart';

import '/constants/models/event_model.dart';
import '../../../cart_page/cubit/cart_page_cubit.dart';
import '../../../login_page/cubit/check_login_cubit.dart';
import '../../../login_page/ui/login_signup_intro.dart';

class DynamicButton extends StatelessWidget {
  final Events event;
  const DynamicButton({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckLoginCubit, CheckLoginState>(
      builder: (context, state) {
        //log(state.toString());
        if (state is CheckLoginFailure || state is CheckLoginLoading) {
          return event.price == 0
              ? SizedBox(
                  height: 200,
                  child: TechButton(
                    scale: 1,
                    buttonText: 'Register',
                    // icon: Icons.edit_rounded,
                    onTap: () {
                      // Navigate to LoginSignUpIntroPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginSignUpIntro(),
                        ),
                      );
                    },
                  ),
                )
              : SizedBox(
                  height: 200,
                  child: TechButton(
                    buttonText: 'Add to Cart',
                    // icon: Icons.shopping_cart,
                    scale: 1,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginSignUpIntro(),
                        ),
                      );
                    },
                  ),
                );
        } else if (state is CheckLoginSuccess) {
          return Container(
            child: event.price == 0
                ? BlocConsumer<CartPageCubit, CartPageState>(
                    listenWhen: (previous, current) =>
                        current is CartItemAdded ||
                        current is CartItemNotAdded ||
                        current is CartItemDeleted ||
                        current is CartItemNotDeleted,
                    listener: (context, state) {
                      if (state is CartItemAdded) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                        BlocProvider.of<CartPageCubit>(context).loadCart();
                      } else if (state is CartItemNotAdded) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                        // BlocProvider.of<CartPageCubit>(context).loadCart();
                      } else if (state is CartItemDeleted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                        BlocProvider.of<CartPageCubit>(context).loadCart();
                      } else if (state is CartItemNotDeleted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                        // BlocProvider.of<CartPageCubit>(context).loadCart();
                      } else {
                        BlocProvider.of<CartPageCubit>(context).loadCart();
                      }
                    },
                    builder: (context, state) {
                      return SizedBox(
                        height: 200,
                        child: TechButton(
                          buttonText: 'Register',
                          scale: 1,
                          // icon: Icons.edit_rounded,
                          onTap: () async {
                            BlocProvider.of<CartPageCubit>(context)
                                .registerFreeEvent(event.id!, context);
                          },
                        ),
                      );
                    },
                  )
                : BlocConsumer<CartPageCubit, CartPageState>(
                    listenWhen: (previous, current) =>
                        current is CartItemAdded ||
                        current is CartItemNotAdded ||
                        current is CartItemDeleted ||
                        current is CartItemNotDeleted,
                    listener: (context, state) {
                      if (state is CartItemAdded) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                        BlocProvider.of<CartPageCubit>(context).loadCart();
                      } else if (state is CartItemNotAdded) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                        // BlocProvider.of<CartPageCubit>(context).loadCart();
                      } else if (state is CartItemDeleted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                        BlocProvider.of<CartPageCubit>(context).loadCart();
                      } else if (state is CartItemNotDeleted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                        // BlocProvider.of<CartPageCubit>(context).loadCart();
                      } else {
                        BlocProvider.of<CartPageCubit>(context).loadCart();
                      }
                    },
                    builder: (context, cartPageState) {
                      //log(cartPageState.toString());
                      if (cartPageState is CartPageLoaded) {
                        if (cartPageState.cartList
                            .getIds()
                            .contains(event.id)) {
                          return TechButton(
                            scale: 1,
                            buttonText: 'Remove',
                            // icon: Icons.close_rounded,
                            onTap: () {
                              if (event.id != null) {
                                BlocProvider.of<CartPageCubit>(
                                  context,
                                ).deleteItem(event.id!);
                              }
                            },
                          );
                        } else {
                          SizedBox(
                            height: 200,
                            child: TechButton(
                              scale: 1,
                              buttonText: 'Add to Cart',
                              // icon: Icons.shopping_cart,
                              onTap: () {
                                if (event.id != null) {
                                  BlocProvider.of<CartPageCubit>(
                                    context,
                                  ).addCartItem(event.id!);
                                }
                              },
                            ),
                          );
                        }
                      } else if (cartPageState is CartPageLoading) {
                        return TechButton(
                          scale: 1,
                          buttonText: 'Loading...',
                          // icon: Icons.shopping_cart,
                          onTap: () {},
                        );
                      } else if (cartPageState is CartItemAdded) {
                        return TechButton(
                          buttonText: 'Remove',
                          scale: 1,
                          // icon: Icons.close_rounded,
                          onTap: () {
                            if (event.id != null) {
                              BlocProvider.of<CartPageCubit>(
                                context,
                              ).deleteItem(event.id!);
                            }
                          },
                        );
                      } else if (cartPageState is CartItemNotAdded) {
                        return TechButton(
                          buttonText: 'Add to Cart',
                          scale: 1,
                          // icon: Icons.close_rounded,
                          onTap: () {
                            if (event.id != null) {
                              BlocProvider.of<CartPageCubit>(
                                context,
                              ).deleteItem(event.id!);
                            }
                          },
                        );
                      }

                      return TechButton(
                        buttonText: 'Add to Cart',
                        scale: 1,
                        // icon: Icons.shopping_cart,
                        onTap: () {
                          if (event.id != null) {
                            BlocProvider.of<CartPageCubit>(
                              context,
                            ).addCartItem(event.id!);
                          }
                        },
                      );
                    },
                  ),
          );
        }
        return Container();
      },
    );
  }
}
