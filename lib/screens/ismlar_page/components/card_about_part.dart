import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ramazo_taqvim/core/utils/constants.dart';

class CardAboutPart extends StatelessWidget {
  CardAboutPart({
    Key? key,
    required this.text,
    required this.aboutPart,
    required this.textSize,
  }) : super(key: key);

  String aboutPart;
  String text;
  double textSize;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Center(
            child: AutoSizeText(
              text,
              minFontSize: textSize,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            child: Text(
              aboutPart,
              style: TextStyle(
                color: ConstantColors.divider_color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
