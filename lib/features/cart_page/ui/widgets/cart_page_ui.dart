import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:pulzion_25_app/config/event_logo_urls.dart';
import 'package:pulzion_25_app/config/size_config.dart';
import 'package:pulzion_25_app/constants/audio.dart';
import 'package:pulzion_25_app/constants/images.dart';
import 'package:pulzion_25_app/constants/urls.dart';
import 'package:pulzion_25_app/constants/widgets/custom_buttons.dart';
import 'package:pulzion_25_app/features/cart_page/ui/widgets/combo_card_new.dart';
import 'package:pulzion_25_app/features/home_page/ui/wigets/custom_button.dart';

import '/features/cart_page/cubit/cart_page_cubit.dart';
import '/features/cart_page/ui/widgets/animated_prompt.dart';
import '../../../../constants/models/cart_model.dart';
import '../../../../constants/styles.dart';
import '../../../../constants/widgets/empty_page.dart';

class CartPageUi extends StatefulWidget {
  final CartItemList? eventList;

  const CartPageUi(this.eventList, {super.key});

  @override
  State<CartPageUi> createState() => _CartPageContentState();
}

class _CartPageContentState extends State<CartPageUi>
    with TickerProviderStateMixin {
  String _transactionId = '';
  String _referral = '';
  List<String> referralCodes = [];

  final cacheManager = CacheManager(
    Config(
      'my_custom_cache_key',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ),
  );

  late final TabController tabBarController =
      TabController(length: 2, vsync: this);

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final instructions =
      'Steps for Payment:\n\n1.) You have to scan the QR Code in any UPI App to make the payment.\n2.) After making the payment, put the Transaction ID carefully and submit it.\n3.) Make sure you do not put UPI ID in the box.\n4.) In case you mistype UPI ID instead of Transaction ID, mail us the same\n5.) Once submitted you will see the status as pending in the orders tab\n6.) We will change your status to confirmed in 48 hrs and you will be able to see your registered events in the Registered Events tab.\n7.) You won\'t be able to re-add the events to cart and perform the registration process once you make the submission.\n8.) For any issues, mail to us at: queries.pulzion@gmail.com';

  Widget _showQR(
      VoidCallback onPressed, double screenHeight, BuildContext ctx) {
    return Stack(
      children: [
        Positioned(
          right: screenHeight * 0.003,
          top: screenHeight * 0.015,
          child: IconButton(
            onPressed: () {
              showDialog(
                context: ctx,
                builder: (ctx) {
                  Singleton().player.playClick();
                  return AlertDialog(
                    backgroundColor: Colors.teal.shade900.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(17),
                    ),
                    title: Text(
                      'How to pay?',
                      textAlign: TextAlign.center,
                      style: AppStyles.NormalText().copyWith(
                        color: Colors.amber,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      instructions,
                      style: AppStyles.NormalText().copyWith(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                'SCAN ME',
                textAlign: TextAlign.center,
                style: AppStyles.NormalText().copyWith(
                  color: Colors.amber,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.025,
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.teal.shade200,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(5),
                child: CachedNetworkImage(
                  imageUrl: EndPoints.QRImg!,
                  placeholder: (context, url) => Image.asset(
                    color: Colors.amber.shade100,
                    AppImages.qrCode,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) =>
                      Image.asset(AppImages.qrCode),
                  fadeInDuration: const Duration(milliseconds: 200),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.025,
              ),
              TextButton(
                onPressed: () {
                  Singleton().player.playClick();
                  onPressed();
                },
                child: Text(
                  'NEXT',
                  style: AppStyles.NormalText().copyWith(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _showBottomSheet(
      double screenHeight, double screenWidth, Function onPressed) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Enter UPI Transaction ID:',
            style: AppStyles.NormalText().copyWith(
              color: Colors.amber,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Text(
            '(PhonePe Users enter UTR number)',
            style: AppStyles.NormalText().copyWith(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlassmorphicContainer(
                width: screenWidth * 0.8,
                height: screenHeight * 0.08,
                borderRadius: 16,
                blur: 10,
                alignment: Alignment.center,
                border: 1,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.2),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a transaction ID';
                          }
                          if (value.length != 12) {
                            return 'Please enter 12 digit UTR ID';
                          }

                          return null;
                        },
                        onSaved: (newValue) {
                          _transactionId = newValue!;
                        },
                        decoration: InputDecoration(
                          hintText: 'Transaction ID',
                          hintStyle: AppStyles.NormalText().copyWith(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                          icon: const Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Icon(Icons.credit_card, color: Colors.white),
                          ),
                        ),
                        style: AppStyles.NormalText().copyWith(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              GlassmorphicContainer(
                width: screenWidth * 0.8,
                height: screenHeight * 0.08,
                borderRadius: 16,
                blur: 10,
                alignment: Alignment.center,
                border: 1,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.2),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return null;
                          }
                          if (value.length != 6) {
                            return 'Please enter 6 digit Referral Code';
                          }

                          return null;
                        },
                        onSaved: (newValue) {
                          _referral = newValue!;
                        },
                        decoration: InputDecoration(
                          hintText: 'Referral Code (Optional)',
                          hintStyle: AppStyles.NormalText().copyWith(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                          icon: const Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Icon(Icons.credit_card, color: Colors.white),
                          ),
                        ),
                        style: AppStyles.NormalText().copyWith(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Singleton().player.playClick();
              onPressed();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(),
              textStyle: AppStyles.NormalText().copyWith(
                color: Colors.amber,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.transparent,
            ),
            child: Text(
              'Submit',
              style: AppStyles.NormalText().copyWith(
                color: Colors.amber,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    final sendTransactionFunction =
        BlocProvider.of<CartPageCubit>(context, listen: false)
            .sendTransactionID;

    return BlocConsumer<CartPageCubit, CartPageState>(
      listener: (context, state) {
        if (state is TransactionError) {
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
        } else if (state is SentTransaction) {
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
        }
      },
      builder: (context, state) {
        if (state is SentTransaction) {
          return Center(
            child: EmptyPage(
              errorMessage: 'Add some events to your Cart',
              refreshFunction: () {},
              title: 'Your Cart is Empty',
            ),
          );
        } else {
          double price = 0;
          for (var item in widget.eventList!.cartItems!) {
            price += item.price!;
          }
          for (var combo in widget.eventList!.cartCombos!) {
            price += double.parse(combo.comboDiscountedPrice.toString());
          }

          final countCartItems =
              widget.eventList == null || widget.eventList!.cartItems == null
                  ? 0
                  : widget.eventList!.cartItems!.length +
                      (widget.eventList == null ||
                              widget.eventList!.cartCombos == null
                          ? 0
                          : widget.eventList!.cartCombos!.length);

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: w * 0.05),
                margin: EdgeInsets.symmetric(
                  horizontal: w * 0.08,
                ),
                height: h * 0.06, //overflow issue solved here
                child: Text(
                  "Your Cart",
                  style: AppStyles.TitleText().copyWith(
                    fontSize: SizeConfig.getProportionateScreenFontSize(30),
                    color: const Color.fromRGBO(255, 193, 7, 1),
                    fontFamily: 'Wallpoet',
                  ),
                ),
              ),
              Expanded(
                child: (widget.eventList == null ||
                        widget.eventList!.cartItems == null ||
                        widget.eventList!.cartCombos == null)
                    ? Center(
                        child: EmptyPage(
                          errorMessage: 'Add some events to your Cart',
                          refreshFunction: () {
                            BlocProvider.of<CartPageCubit>(context).loadCart();
                          },
                          title: 'Your Cart is Empty',
                        ),
                      )
                    : Column(
                        children: [
                          // SizedBox(
                          //   height: h / 80,
                          // ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(bottom: h * 0.041),
                            child: DefaultTabController(
                              length: 2,
                              child: TabBar(
                                dividerColor: Colors.transparent,
                                indicatorColor: Colors.transparent,
                                labelPadding: const EdgeInsets.all(12),
                                indicator: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.teal,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                unselectedLabelColor: Colors.transparent,
                                labelColor: Colors.transparent,
                                controller: tabBarController,
                                tabs: const [
                                  CustomButton(text: 'Events'),
                                  CustomButton(text: 'Combos'),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: w,
                            height: h / 2.3,
                            child: TabBarView(
                              physics: const BouncingScrollPhysics(),
                              controller: tabBarController,
                              children: [
                                SizedBox(
                                  child: widget.eventList!.cartItems == null ||
                                          widget.eventList!.cartItems!.isEmpty
                                      ? const Center(
                                          child: EmptyPage(
                                            title: 'No Events in Cart',
                                            errorMessage:
                                                'Add some events to your Cart',
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01,
                                          ),
                                          child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              return AnimatedPrompt(
                                                id: widget.eventList!
                                                    .cartItems![index].id!,
                                                title: widget.eventList!
                                                    .cartItems![index].name!,
                                                subtitle: widget.eventList!
                                                    .cartItems![index].price
                                                    .toString(),
                                                comboEvents: null,
                                                image: CachedNetworkImage(
                                                  imageUrl: widget.eventList!
                                                      .cartItems![index].logo!,
                                                  color: Colors.white,
                                                  placeholder: (context, url) =>
                                                      Container(),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Image.network(
                                                    eventLogoImageUrlMap[widget
                                                        .eventList!
                                                        .cartItems![index]
                                                        .id!]!,
                                                  ),
                                                  cacheManager: cacheManager,
                                                  fadeInDuration:
                                                      const Duration(
                                                    milliseconds: 100,
                                                  ),
                                                  fit: BoxFit.fitWidth,
                                                  key: UniqueKey(),
                                                ),
                                              );
                                            },
                                            itemCount: widget.eventList
                                                    ?.cartItems?.length ??
                                                0,
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  child: widget.eventList!.cartCombos == null ||
                                          widget.eventList!.cartCombos!.isEmpty
                                      ? const Center(
                                          child: EmptyPage(
                                            title: 'No Combos in Cart',
                                            errorMessage:
                                                'Add some combos to your Cart',
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: widget
                                              .eventList!.cartCombos!.length,
                                          itemBuilder: (context, index) {
                                            final combo = widget
                                                .eventList!.cartCombos![index];

                                            return ComboCardNew(
                                              id: combo.comboID!,
                                              title: combo.comboName!,
                                              subtitle:
                                                  combo.comboDiscountedPrice!,
                                              comboEvents: combo
                                                  .comboDetailsList!
                                                  .map((e) => e.name)
                                                  .toList(),
                                              // image: Image.network(
                                              //   combo.comboDetailsList![0].logo,
                                              // ),
                                            );
                                          },
                                        ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Container(
                            color: Colors.teal.withOpacity(0.2),
                            padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.04,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.01,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  // padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.teal),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  // height: h / 12,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "TOTAL : ₹${widget.eventList == null || widget.eventList!.cartItems == null ? 0 : price.toString()}",
                                        style: AppStyles.NormalText().copyWith(
                                          color: Colors.amber,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "($countCartItems ${countCartItems == 1 ? 'item' : 'items'})",
                                        style: AppStyles.NormalText().copyWith(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                ),
                                TechButton(
                                  buttonText: 'Checkout',
                                  scale: 0.95,
                                  onTap: () {
                                    //log('Tapped');
                                    Singleton().player.playClick();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        int tappedIdx = 0;

                                        return StatefulBuilder(
                                          builder: (ctx, setPopUpState) {
                                            return AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0),
                                                ),
                                              ),
                                              insetPadding:
                                                  EdgeInsets.all(h * 0.001),
                                              backgroundColor:
                                                  Colors.transparent,
                                              content: Container(
                                                padding:
                                                    EdgeInsets.all(h * 0.02),
                                                // width: h * 0.5,
                                                height: h * 0.6,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black
                                                            .withOpacity(0.7),
                                                        Colors.teal.shade900
                                                            .withOpacity(0.7),
                                                        Colors.teal.shade700
                                                            .withOpacity(0.7),
                                                        Colors.teal.shade500
                                                            .withOpacity(0.7),
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment
                                                          .bottomRight),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color: Colors.teal,
                                                      width: 0.5),
                                                ),
                                                child: tappedIdx == 0
                                                    ? _showQR(
                                                        () {
                                                          setPopUpState(() {
                                                            tappedIdx = 1;
                                                          });
                                                        },
                                                        h,
                                                        ctx,
                                                      )
                                                    : _showBottomSheet(
                                                        h,
                                                        w,
                                                        () {
                                                          if (!_formKey1
                                                              .currentState!
                                                              .validate()) {
                                                            return;
                                                          }
                                                          _formKey1
                                                              .currentState!
                                                              .save();
                                                          if (!_formKey2
                                                              .currentState!
                                                              .validate()) {
                                                            return;
                                                          }
                                                          _formKey2
                                                              .currentState!
                                                              .save();

                                                          try {
                                                            sendTransactionFunction(
                                                                _transactionId,
                                                                _referral);
                                                            Navigator.of(ctx)
                                                                .pop();
                                                          } catch (e) {
                                                            //log(e.toString());
                                                          }
                                                        },
                                                      ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
              ),
            ],
          );
        }
      },
    );
  }
}
