import 'package:flutter/material.dart';
import 'package:ramazo_taqvim/core/utils/constants.dart';
import 'package:ramazo_taqvim/core/utils/size_config.dart';

class Nomoz_Time_Notifier extends StatefulWidget {
  Nomoz_Time_Notifier({
    Key? key,
    required this.text,
    required this.isNotified,
  }) : super(key: key);

  bool isNotified;
  String text;

  @override
  State<Nomoz_Time_Notifier> createState() => _Nomoz_Time_NotifierState();
}

class _Nomoz_Time_NotifierState extends State<Nomoz_Time_Notifier> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        dense: true,
        onTap: () {
          setState(() {
            widget.isNotified = !widget.isNotified;
          });
        },
        tileColor: widget.isNotified
            ? ConstantColors.selected_namaz_time_color
            : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: getWidth(6)),
        trailing: CircleAvatar(
          radius: 13,
          backgroundColor: Colors.black,
          child: widget.isNotified ? checkedIcon() : uncheckedIcon(),
        ),
        title: Text(
          widget.text,
          style: const TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  checkedIcon() => const Icon(
        Icons.check,
        color: Colors.white,
        size: 18,
      );
  uncheckedIcon() => const Icon(
        Icons.circle,
        color: Colors.white,
      );
}
