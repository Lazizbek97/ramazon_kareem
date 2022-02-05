import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:ramazo_taqvim/core/models/nomoz_times_model/model_praying_times.dart';
import 'package:ramazo_taqvim/core/utils/constants.dart';
import 'package:ramazo_taqvim/core/utils/size_config.dart';
import 'package:ramazo_taqvim/core/widgets/container_decoration.dart';
import 'package:ramazo_taqvim/core/widgets/praying_time_and_temprature.dart';
import 'package:circular_countdown/circular_countdown.dart';

class CountdownPage extends StatefulWidget {
  CountdownPage({Key? key, required this.today}) : super(key: key);
  ModelPrayingTimes today;
  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  bool switchValue = false;
  DateTime currentTime = DateTime.now();
  int? remainedMinutes;
  int? intervalMinutes;

  List<String>? times;
  List<String> names = ['Quyosh', 'Bomdod', 'Peshin', 'Asr', 'Shom', 'Xufton'];
  DateFormat formatTime = DateFormat("Hm");

  @override
  void initState() {
    var nowString = "${currentTime.hour}:${currentTime.minute}";

    DateTime now = stringToDateTime(nowString);

    times = widget.today.times!.toJson().values.cast<String>().toList();
    late int t1;

    for (var time in times!) {
      DateTime t = stringToDateTime(time);
      now.isAfter(t) ? t1 = times!.indexOf(time) : null;
    }

    timeDifference(times![t1], times![t1 + 1]);
    print(names[t1]);
  }

  stringToDateTime(String text) {
    DateFormat format = DateFormat("HH:mm");
    return format.parse(text);
  }

  timeDifference(String from, String to) {
    DateFormat format = DateFormat("HH:mm");

    var start = format.parse(from);
    var end = format.parse(to);
    var nowString = "${currentTime.hour}:${currentTime.minute}";
    var now = format.parse(nowString);

    Duration diff = end.difference(start);

    Duration difToPray = end.difference(now);

    remainedMinutes = difToPray.inMinutes;
    intervalMinutes = diff.inMinutes;

    if (!(intervalMinutes! >= remainedMinutes!)) {
      intervalMinutes = intervalMinutes! + 1;
    }
    print(intervalMinutes);
    print(remainedMinutes);

    return diff.inHours;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Countdown",
          style: TextStyle(fontSize: ConstantSizes.app_bar_size),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 0,
            collapsedHeight: getHeight(400),
            flexibleSpace: SizedBox(
              child: Stack(
                children: [
                  Center(
                    child: CircularCountdown(
                      countdownTotal: intervalMinutes!,
                      countdownRemaining: remainedMinutes,

                      countdownCurrentColor: Colors.black,
                      countdownRemainingColor: Colors.grey,
                      countdownTotalColor: Colors.grey.shade300,
                      diameter: getWidth(280),
                      // repeat: true,
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
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ContainerDecoration(
                  child: PrayTime_Tempr(
                    iconLink: ConstantLinks.azon_notifier_icon_image,
                    text: names[index],
                    time: times![index],
                  ),
                  height: 150,
                  width: 150,
                ),
              ),
              childCount: 6,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: getHeight(100),
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
              Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
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
