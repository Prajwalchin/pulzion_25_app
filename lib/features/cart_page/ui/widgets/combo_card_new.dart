import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion_25_app/constants/widgets/custom_buttons.dart';

import '/constants/styles.dart';
import '/features/cart_page/cubit/cart_page_cubit.dart';

class ComboCardNew extends StatefulWidget {
  final int id;
  final String title;
  final String subtitle;
  List<String>? comboEvents;

  ComboCardNew({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.comboEvents,
  });

  @override
  State<ComboCardNew> createState() => _AnimatedPromptState();
}

class _AnimatedPromptState extends State<ComboCardNew>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
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
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    _animationController
      ..reset()
      ..forward();

    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0),
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
      // height: widget.comboEvents == null ? screenHeight * 0.22 : widget.comboEvents!.length * screenHeight * 0.04 + screenHeight * 0.2,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 39, 77).withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 106, 198, 238),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 98, 154, 182).withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: screenHeight * 0.01,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SizedBox(
                child: Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: AppStyles.NormalText().copyWith(
                    color: Colors.amber,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'VT323',
                    fontSize: 25,
                  ),
                ),
              ),
              const Spacer(
                flex: 4,
              ),
              SizedBox(
                child: Text(
                  "₹${double.parse(widget.subtitle).toInt()}",
                  textAlign: TextAlign.center,
                  style: AppStyles.NormalText().copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          if (widget.comboEvents != null) ...[
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.1),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: widget.comboEvents!
                    .map((e) => Text(
                          '-$e',
                          style: AppStyles.NormalText().copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.022,
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
          ],
          TechButton(
            buttonText: 'Remove',
            scale: 0.8,
            onTap: () async {
              if (widget.comboEvents == null) {
                await BlocProvider.of<CartPageCubit>(context)
                    .deleteItem(widget.id);
              } else {
                await BlocProvider.of<CartPageCubit>(context)
                    .deleteCombo(widget.id);
              }
            },
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
        ],
      ),
    );
  }
}
