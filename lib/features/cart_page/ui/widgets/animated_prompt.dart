import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion_25_app/constants/images.dart';

import '/constants/styles.dart';
import '/features/cart_page/cubit/cart_page_cubit.dart';

// ignore: must_be_immutable
class AnimatedPrompt extends StatefulWidget {
  final int id;
  final String title;
  final String subtitle;
  final CachedNetworkImage image;
  List<String>? comboEvents;

  AnimatedPrompt({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.comboEvents,
  });

  @override
  State<AnimatedPrompt> createState() => _AnimatedPromptState();
}

class _AnimatedPromptState extends State<AnimatedPrompt>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _imageScalingAnimation;
  late Animation<double> _containerScalingAnimation;
  // late Animation<Offset> _yAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 1,
      ),
    );

    _containerScalingAnimation = Tween(begin: 1.5, end: 0.75).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.decelerate,
      ),
    );

    _imageScalingAnimation = Tween(begin: 1.5, end: 0.75).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    _animationController
      ..reset()
      ..forward();

    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.013),
      height: widget.comboEvents == null
          ? screenHeight * 0.22
          : widget.comboEvents!.length * 50 + screenHeight * 0.22,
      decoration: BoxDecoration(
        // color: Colors.teal.withOpacity(0.1),
        image: const DecorationImage(
          image: AssetImage(AppImages.cartFrame),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(
            height: screenWidth / 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              ScaleTransition(
                scale: _containerScalingAnimation,
                child: Container(
                  height: screenWidth * 0.25,
                  width: screenWidth * 0.25,
                  padding: EdgeInsets.all(screenHeight * 0.01),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.teal.shade900.withOpacity(0.8),
                  ),
                  child: ScaleTransition(
                    scale: _imageScalingAnimation,
                    child: widget.image,
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: screenWidth * 0.48,
                // height: screenWidth * 0.09,
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: AppStyles.NormalText().copyWith(
                    color: Colors.amber,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'VT323',
                    fontSize: 23,
                  ),
                ),
              ),
              const Spacer(
                flex: 3,
              ),
              SizedBox(
                child: Text(
                  "₹${widget.subtitle}",
                  textAlign: TextAlign.center,
                  style: AppStyles.NormalText().copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                  ),
                ),
              ),
              const Spacer(
                flex: 3,
              )
            ],
          ),
          if (widget.comboEvents != null)
            Padding(
              padding: EdgeInsets.only(left: screenWidth / 4),
              child: ListView(
                shrinkWrap: true,
                children: widget.comboEvents!
                    .map((e) => Text(
                          '-$e',
                          style: AppStyles.NormalText().copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ))
                    .toList(),
              ),
            ),
          if (widget.comboEvents != null)
            SizedBox(
              height: screenWidth / 4,
            ),
          Row(
            children: [
              SizedBox(
                width: screenWidth / 4,
              ),
              SizedBox(
                width: screenWidth / 7,
              ),
              SizedBox(
                height: screenWidth / 9,
                width: screenWidth / 4,
                child: InkWell(
                  onTap: () async {
                    if (widget.comboEvents == null) {
                      await BlocProvider.of<CartPageCubit>(context)
                          .deleteItem(widget.id);
                    } else {
                      await BlocProvider.of<CartPageCubit>(context)
                          .deleteCombo(widget.id);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.015),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.7)),
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 65, 177, 166)
                              .withOpacity(0.25),
                          const Color.fromARGB(255, 60, 155, 209)
                              .withOpacity(0.24),
                          const Color.fromARGB(255, 20, 99, 145)
                              .withOpacity(0.26),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Remove",
                        style: AppStyles.NormalText().copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
