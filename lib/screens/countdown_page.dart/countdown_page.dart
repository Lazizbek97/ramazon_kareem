import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ramazo_taqvim/core/utils/constants.dart';
import 'package:ramazo_taqvim/core/utils/size_config.dart';
import 'package:ramazo_taqvim/core/widgets/container_decoration.dart';
import 'package:ramazo_taqvim/core/widgets/praying_time_and_temprature.dart';
import 'package:circular_countdown/circular_countdown.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Countdown",
          style: TextStyle(fontSize: 25),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: TimeCircularCountdown(
                    unit: CountdownUnit.second,
                    countdownTotal: 100,
                    countdownCurrentColor: Colors.black,
                    countdownRemainingColor: Colors.grey,
                    countdownTotalColor: Colors.grey.shade300,
                    diameter: getWidth(300),
                    repeat: true,
                    strokeWidth: 30,
                    gapFactor: 1.7,
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: getHeight(150),
                    width: getWidth(170),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.light_mode_outlined,
                          size: 35,
                          color: Colors.black,
                        ),
                        Text(
                          "12:44",
                          style: TextStyle(
                              fontSize: ConstantSizes.header_second_size,
                              fontWeight: FontWeight.w600),
                          maxLines: 1,
                        ),
                        Text(
                          "Mins Remaining for Iftar",
                          style: TextStyle(
                            fontSize: ConstantSizes.header_third_size,
                            color: ConstantColors.bottom_text_color,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ContainerDecoration(
                        child: PrayTime_Tempr(
                          iconLink: ConstantLinks.azon_notifier_icon_image,
                          text: "Isha",
                          time: "3:56",
                        ),
                        height: 150,
                        width: 150),
                    ContainerDecoration(
                        child: PrayTime_Tempr(
                          iconLink: ConstantLinks.temprature_icon_image,
                          text: "25 C",
                          time: "Today",
                        ),
                        height: 150,
                        width: 150),
                  ],
                ),
                SizedBox(
                  height: getHeight(20),
                ),
                ContainerDecoration(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AutoSizeText(
                        "Haftalik Nomoz Vaqtlari",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
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
                  height: 100,
                  width: 345,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: SizedBox(
          height: getHeight(60),
          width: getWidth(210),
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left_outlined),
            label: const Center(
              child: Text("Orqaga"),
            ),
          ),
        ),
      ),
    );
  }
}
