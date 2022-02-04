import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ramazo_taqvim/core/utils/constants.dart';
import 'package:ramazo_taqvim/core/widgets/nomoz_time_notifier.dart';

class AzonTimes extends StatefulWidget {
  AzonTimes({Key? key}) : super(key: key);

  @override
  State<AzonTimes> createState() => _AzonTimesState();
}

class _AzonTimesState extends State<AzonTimes> {
  bool switchValue = false;
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
              value: switchValue,
              onChanged: (v) {
                setState(() {
                  switchValue = v;
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
          isNotified: false,
        ),
        Nomoz_Time_Notifier(
          text: "Quyosh",
          isNotified: false,
        ),
        Nomoz_Time_Notifier(
          text: "Peshin",
          isNotified: false,
        ),
        Nomoz_Time_Notifier(
          text: "Asr",
          isNotified: false,
        ),
        Nomoz_Time_Notifier(
          text: "Shom",
          isNotified: false,
        ),
        Nomoz_Time_Notifier(
          text: "Isha",
          isNotified: false,
        ),
        const SizedBox(height: 10),
        Text(
          "Nomoz vaqtlari",
          style: TextStyle(
            color: ConstantColors.bottom_text_color,
            fontSize: ConstantSizes.header_third_size,
          ),
        ),
      ],
    );
  }
}
