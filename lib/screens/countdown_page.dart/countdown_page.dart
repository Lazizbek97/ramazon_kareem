import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
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
  List<String>? times;
  List<String> names = ['Quyosh', 'Bomdod', 'Peshin', 'Asr', 'Shom', 'Xufton'];

  @override
  void initState() {
    times = widget.today.times!.toJson().values.cast<String>().toList();
    print(times);
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
                    child: TimeCircularCountdown(
                      unit: CountdownUnit.second,
                      countdownTotal: 100,
                      countdownCurrentColor: Colors.black,
                      countdownRemainingColor: Colors.grey,
                      countdownTotalColor: Colors.grey.shade300,
                      diameter: getWidth(280),
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
