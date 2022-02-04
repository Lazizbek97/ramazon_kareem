import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ramazo_taqvim/core/utils/constants.dart';

class IftarSaharAlert extends StatefulWidget {
  IftarSaharAlert({
    Key? key,
    required this.sub_text,
    required this.icon,
    required this.time,
    required this.switchValue,
  }) : super(key: key);

  Icon icon;
  String sub_text;
  String time;
  bool switchValue;

  @override
  State<IftarSaharAlert> createState() => _IftarAlertState();
}

class _IftarAlertState extends State<IftarSaharAlert> {
  bool _switcherValue = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.icon,
            CupertinoSwitch(
              value: widget.switchValue,
              onChanged: (v) {
                setState(() {
                  widget.switchValue = v;
                });
              },
              activeColor: ConstantColors.active_color,
            ),
          ],
        ),
        Text(
          widget.time,
          style: TextStyle(
            fontSize: ConstantSizes.header_second_size,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.sub_text,
          style: TextStyle(
            color: ConstantColors.bottom_text_color,
            fontSize: ConstantSizes.header_third_size,
          ),
        ),
      ],
    );
  }
}
