import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:ramazo_taqvim/core/data/hive_boxes.dart';
import 'package:ramazo_taqvim/core/models/alarms/alarms.dart';
import 'package:ramazo_taqvim/core/models/nomoz_times_model/model_praying_times.dart';
import 'package:ramazo_taqvim/core/notifications/set_notifications.dart';
import 'package:ramazo_taqvim/core/utils/constants.dart';
import 'package:ramazo_taqvim/core/widgets/nomoz_time_notifier.dart';

class AzonTimes extends StatefulWidget {
  AzonTimes({
    Key? key,
    required this.nomoz_vaqti,
  }) : super(key: key);
  ModelPrayingTimes nomoz_vaqti;
  static bool switchValue = false;

  @override
  State<AzonTimes> createState() => _AzonTimesState();
}

class _AzonTimesState extends State<AzonTimes> {
  Box<AlarmModel> alarmBox = Boxes.getAlarm();
  List alarms = [];
  String today = DateTime.now().toString().split(" ")[0];

  @override
  void initState() {
    super.initState();

    alarms = widget.nomoz_vaqti.times!.toJson().values.toList();
    alarms = alarms.map((e) => DateTime.parse("$today $e")).toList();
    switcherInitialValue();
  }

  _update() {
    setState(() {});
  }

  List<String> names = ['Bomdod', 'Quyosh', 'Peshin', 'Asr', 'Shom', 'Xufton'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                ConstantLinks.azon_notifier_icon_image,
              ),
            ),
            CupertinoSwitch(
              value: AzonTimes.switchValue,
              onChanged: (v) async {
                // ? DataBasedagi Holatini yangilab qo'yadi
                await turnOnOffAllAlarmsState(v);
                // ? Notification yo qo'shadi yo o'chiradi HAMMASINI
                await set_off_notifiy(v);

                setState(() {
                  AzonTimes.switchValue = v;
                });
              },
              activeColor: ConstantColors.active_color,
            ),
          ],
        ),
        Text(
          "Azan",
          style: TextStyle(
            fontSize: ConstantSizes.header_second_size,
            fontWeight: FontWeight.bold,
          ),
        ),
        Nomoz_Time_Notifier(
          text: "Bomdod",
          vaqt: 1,
          nomoz_vaqti: alarms[0],
          update: _update,
        ),
        Nomoz_Time_Notifier(
          text: "Quyosh",
          vaqt: 2,
          nomoz_vaqti: alarms[1],
          update: _update,
        ),
        Nomoz_Time_Notifier(
          text: "Peshin",
          vaqt: 3,
          nomoz_vaqti: alarms[2],
          update: _update,
        ),
        Nomoz_Time_Notifier(
          text: "Asr",
          vaqt: 4,
          nomoz_vaqti: alarms[3],
          update: _update,
        ),
        Nomoz_Time_Notifier(
          text: "Shom",
          vaqt: 5,
          nomoz_vaqti: alarms[4],
          update: _update,
        ),
        Nomoz_Time_Notifier(
          text: "Xufton",
          vaqt: 6,
          nomoz_vaqti: alarms[5],
          update: _update,
        ),
        const SizedBox(height: 10),
        SizedBox(
            height: 25,
            width: double.infinity,
            child: Row(
              children: [
                AutoSizeText(
                  "${widget.nomoz_vaqti.region} ",
                  style: TextStyle(
                    color: ConstantColors.bottom_text_color,
                    fontSize: ConstantSizes.header_third_size,
                  ),
                ),
                const Icon(Icons.location_on_outlined)
              ],
            )),
      ],
    );
  }

  switcherInitialValue() async {
    if (alarmBox.values.first.bomdod &&
        alarmBox.values.first.quyosh &&
        alarmBox.values.first.peshin &&
        alarmBox.values.first.asr &&
        alarmBox.values.first.shom &&
        alarmBox.values.first.xufton) {
      AzonTimes.switchValue = true;
    } else {
      AzonTimes.switchValue = false;
    }

    setState(() {});
  }

  set_off_notifiy(bool v) async {
    List a = List.generate(6, (index) => index);

    v
        ? a.forEach((i) async {
            await SetNotifications.setNotifications(
                id: i,
                title: names[i],
                body:
                    "${names[i]} vaqti kirdi! Nomoz o'z vaqtida o'qilishi farz qilingan.E'tiborli bo'ling!",
                payload: "",
                joriy_nomoz_vaqti: alarms[i]);
          })
        : a.forEach((i) async {
            await SetNotifications.deleteNotification(i);
          });
  }

  turnOnOffAllAlarmsState(bool on_off) async {
    alarmBox.values.forEach(
      (element) {
        element.bomdod = on_off;
        element.quyosh = on_off;
        element.peshin = on_off;
        element.asr = on_off;
        element.shom = on_off;
        element.xufton = on_off;
      },
    );
    AzonTimes.switchValue = on_off;
    await alarmBox.values.first.save();
  }
}
