import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion_25_app/constants/styles.dart';
import 'package:pulzion_25_app/constants/widgets/custom_buttons.dart';
import 'package:pulzion_25_app/features/combo_cubit/models/combo_model.dart';

import '../../../cart_page/cubit/cart_page_cubit.dart';
import '../../../login_page/cubit/check_login_cubit.dart';
import '../../../login_page/ui/login_signup_intro.dart';

class DynamicButtonCombo extends StatelessWidget {
  final Combo combo;
  const DynamicButtonCombo({super.key, required this.combo});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckLoginCubit, CheckLoginState>(
      builder: (context, state) {
        //log(state.toString());
        if (state is CheckLoginFailure || state is CheckLoginLoading) {
          return SizedBox(
            height: MediaQuery.of(context).size.width * 0.13,
            child: TechButton(
              buttonText: 'Add to Cart',
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
          return BlocConsumer<CartPageCubit, CartPageState>(
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
                    .getComboIds()
                    .contains(combo.comboID)) {
                  return TechButton(
                    scale: 1,
                    buttonText: 'Remove',
                    onTap: () {
                      if (combo.comboID != null) {
                        BlocProvider.of<CartPageCubit>(
                          context,
                        ).deleteCombo(combo.comboID!);
                      }
                    },
                  );
                } else {
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.13,
                    child: TechButton(
                      scale: 1,
                      buttonText: 'Add to Cart',
                      // icon: Icons.shopping_cart,
                      onTap: () {
                        if (combo.comboID != null) {
                          BlocProvider.of<CartPageCubit>(
                            context,
                          ).addCombo(combo.comboID!);
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
                    if (combo.comboID != null) {
                      BlocProvider.of<CartPageCubit>(
                        context,
                      ).deleteCombo(combo.comboID!);
                    }
                  },
                );
              } else if (cartPageState is CartItemNotAdded) {
                return TechButton(
                  buttonText: 'Add to Cart',
                  scale: 1,
                  onTap: () {
                    if (combo.comboID != null) {
                      BlocProvider.of<CartPageCubit>(
                        context,
                      ).addCombo(combo.comboID!);
                    }
                  },
                );
              }

              return TechButton(
                buttonText: 'Add to Cart',
                scale: 1,
                // icon: Icons.shopping_cart,
                onTap: () {
                  if (combo.comboID != null) {
                    BlocProvider.of<CartPageCubit>(
                      context,
                    ).addCombo(combo.comboID!);
                  }
                },
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
