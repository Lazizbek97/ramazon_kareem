import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ramazo_taqvim/core/utils/constants.dart';

class PrayTime_Tempr extends StatelessWidget {
  PrayTime_Tempr({
    Key? key,
    required this.text,
    required this.time,
    required this.iconLink,
  }) : super(key: key);

  String iconLink;
  String text;
  String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: SvgPicture.asset(
            iconLink,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "in $time hrs",
          style: TextStyle(
              fontSize: ConstantSizes.header_third_size,
              color: ConstantColors.bottom_text_color),
        ),
      ],
    );
  }
}
