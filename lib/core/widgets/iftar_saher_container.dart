import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ramazo_taqvim/core/data/hive_boxes.dart';
import 'package:ramazo_taqvim/core/models/alarms/alarms.dart';
import 'package:ramazo_taqvim/core/models/nomoz_times_model/model_praying_times.dart';
import 'package:ramazo_taqvim/core/notifications/set_notifications.dart';
import 'package:ramazo_taqvim/core/utils/constants.dart';

class IftarSaharAlert extends StatefulWidget {
  IftarSaharAlert({
    Key? key,
    required this.sub_text,
    required this.icon,
    required this.rozaVaqti,
  }) : super(key: key);

  Icon icon;
  String sub_text;

  ModelPrayingTimes rozaVaqti;

  @override
  State<IftarSaharAlert> createState() => _IftarAlertState();
}

class _IftarAlertState extends State<IftarSaharAlert> {
  Box<AlarmModel> alarmBox = Boxes.getAlarm();
  String today = DateTime.now().toString().split(" ")[0];
  final String tomorrow =
      DateTime.now().add(const Duration(days: 1)).toString().split(" ")[0];
  DateTime? saharlik;
  DateTime? iftorlik;

  @override
  void initState() {
    saharlik =
        DateTime.parse("$tomorrow ${widget.rozaVaqti.times!.tongSaharlik}:00");
    iftorlik = DateTime.parse("$today ${widget.rozaVaqti.times!.shomIftor}:00");
  }

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
              value: widget.sub_text == "Saharlik Vaqti"
                  ? alarmBox.values.first.saharlik
                  : alarmBox.values.first.iftorlik,
              onChanged: (v) async {
                await cupertinoSwitched(v);
                setState(() {});
              },
              activeColor: ConstantColors.active_color,
            ),
          ],
        ),
        Text(
          widget.sub_text == "Saharlik Vaqti"
              ? "0${saharlik!.hour}:0${saharlik!.minute}"
              : "${iftorlik!.hour}:${iftorlik!.minute}",
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

  cupertinoSwitched(bool v) async {
    if (widget.sub_text == "Saharlik Vaqti") {
      alarmBox.values.first.saharlik = v;
      await alarmBox.values.first.save();
      v
          ? SetNotifications.setNotifications(
              id: 7,
              title: "Saharlik vaqti tugadi",
              body: "Saharlik vaqti tugadi! Duo qilishga ulgurdingizmi?",
              payload: "payload",
              joriy_nomoz_vaqti: saharlik!)
          : SetNotifications.deleteNotification(7);
    } else if (widget.sub_text == "Iftorlik Vaqti") {
      alarmBox.values.first.iftorlik = v;
      await alarmBox.values.first.save();
      setState(() {});
      v
          ? SetNotifications.setNotifications(
              id: 8,
              title: "iftorlik vaqti keldi",
              body: "Olloh ro'zangizni qabul qilsin! MashaAlloh",
              payload: "payload",
              joriy_nomoz_vaqti: iftorlik!)
          : SetNotifications.deleteNotification(8);
    }
  }
}
