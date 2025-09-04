import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion_25_app/constants/widgets/empty_page.dart';
import 'package:pulzion_25_app/constants/widgets/loader.dart';
import 'package:pulzion_25_app/features/cart_page/ui/widgets/cart_page_ui.dart';

import '/constants/styles.dart';
import '../../../constants/widgets/error_dialog.dart';
import '../../login_page/cubit/check_login_cubit.dart';
import '../cubit/cart_page_cubit.dart';
import 'widgets/needs_login_page.dart';

class CartPageFinal extends StatelessWidget {
  const CartPageFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckLoginCubit, CheckLoginState>(
      builder: (context, loginState) {
        return loginState is CheckLoginSuccess
            ? BlocConsumer<CartPageCubit, CartPageState>(
                listener: (context, state) {
                  if (state is CartItemDeleted) {
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
                        duration: const Duration(seconds: 2),
                      ),
                    );
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
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                buildWhen: (previous, current) =>
                    current is! CartItemDeleted ||
                    current is! CartItemNotDeleted,
                builder: (context, state) {
                  //log("CART PAGE STATE = $state");
                  if (state is CartPageLoading) {
                    return const Center(
                      child: Loader(),
                    );
                  } else if (state is CartEmpty) {
                    return Center(
                      child: EmptyPage(
                        errorMessage: 'Add some events to your Cart',
                        refreshFunction: () {
                          BlocProvider.of<CartPageCubit>(context).loadCart();
                        },
                        title: 'Your Cart is Empty',
                      ),
                    );
                  } else if (state is CartPageLoaded) {
                    return CartPageUi(state.cartList);
                  } else if (state is CartPageError) {
                    return Center(
                      child: ErrorDialog(
                        state.message,
                        refreshFunction: () =>
                            BlocProvider.of<CartPageCubit>(context).loadCart(),
                      ),
                    );
                  }

                  return const Loader();
                },
              )
            : const NeedsLoginPage();
      },
    );
  }
}
