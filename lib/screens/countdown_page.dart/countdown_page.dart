import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:ramazo_taqvim/core/data/hive_boxes.dart';
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
  DateTime? now;
  String remainedTime = '';
  int? remainedMinutes;
  int? intervalMinutes;
  Box<ModelPrayingTimes> box = Boxes.getTime();

  List<String>? times;
  List<String> names = ['Bomdod', 'Quyosh', 'Peshin', 'Asr', 'Shom', 'Xufton'];
  DateFormat formatTime = DateFormat("Hm");
  int? vaqtim1;

  @override
  void initState() {
    rebuildDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Joriy Nomoz Vaqti",
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
                            remainedTime,
                            style: TextStyle(
                                fontSize: ConstantSizes.header_second_size,
                                fontWeight: FontWeight.w600),
                            maxLines: 1,
                          ),
                          Text(
                            names[vaqtim1!],
                            style: TextStyle(
                              fontSize: 26,
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

  String time1 = "";
  String time2 = "";

  ertangiXuftonvaBomdodVaqti() {
    for (var i = 0; i < box.values.toList().length; i++) {
      if (box.values.toList()[i] == widget.today) {
        time2 = box.values.toList()[i + 1].times!.tongSaharlik.toString();
      }
      time1 = widget.today.times!.tongSaharlik.toString();
    }
  }

  Future<int> getDifference(String time1, String time2) async {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    String _today = dateFormat.format(currentTime).split(" ")[0];
    String _tomorrow =
        currentTime.add(const Duration(days: 1)).toString().split(" ")[0];

    DateTime a = DateTime.parse('$_today $time1:00');
    DateTime b = DateTime.parse('$_tomorrow $time2:00');

    Duration diff = b.difference(a);
    Duration difToPray = b.difference(currentTime);
    // * ularni stringga o'tkazamiz
    String hours = difToPray.inHours.toString();
    String minutes = (difToPray.inMinutes % 60).toString();
    //?-> Jami min dagi vaqtni 60 ga bo'lsak soatlardan ortib qolgani chiqadi

    // *Ekranga ko'rsatiluvchi vaqt
    remainedTime =
        "${hours.length == 1 ? '0' + hours : hours}:${minutes.length == 1 ? '0' + minutes : minutes}";
    // *Circular progress ni jami hajmi va tugagan qismlari
    remainedMinutes = difToPray.inMinutes;
    intervalMinutes = diff.inMinutes;

    return b.difference(a).inHours;
  }

// 'Quyosh',
// * Keyingi nomozga qancha vaqt qolganligini aniqlab beradi
  rebuildDates() {
    // * bugungi nomoz vaqtlari -> Listga
    times = widget.today.times!.toJson().values.cast<String>().toList();
    print(times);
    // * Ayni vaqtda qaysi nomoz vaqtlari orasida turganimizni aniqlaydi
    String _date = currentTime.toString().split(" ")[0];
    String nomoz_sanasi = widget.today.date.toString().split(" ")[0];

    for (var time in times!) {
      DateTime t = DateTime.parse('$_date $time:00');
      print(currentTime.difference(t).inSeconds);
      if (currentTime.difference(t).inSeconds < 0) {
        vaqtim1 = times!.indexOf(time);
        print(vaqtim1);
        print("safaiofjaeofehru ");

        break;
      }
    }
    if (vaqtim1 == null) {
      vaqtim1 = names.indexOf(names.last);
    }
    // *  Necha soat va necha minut vaqt qolganiligini hisoblab beruvchi funksiyaga qiymatlarni jo'natamiz

    if (vaqtim1 == names.indexOf(names.last)) {
      ertangiXuftonvaBomdodVaqti();
      getDifference(time1, time2);
      print("1 part");
    } else {
      if (vaqtim1 == 0) {
        timeDifference(
            stringToDateTime("00:00"), stringToDateTime(times![vaqtim1!]));
        print("2 part");
      } else {
        timeDifference(stringToDateTime(times![vaqtim1! - 1]),
            stringToDateTime(times![vaqtim1!]));
        print("3 part");
        print("${times![vaqtim1! - 1]}");
        print(times![vaqtim1!]);
      }
    }
  }

// * String -> DateTime
  stringToDateTime(String text) {
    DateFormat format = DateFormat("HH:mm");
    return format.parse(text);
  }

  // * DatetimeFormat
  String dateTimeFormat(DateTime date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    return dateFormat.format(date);
  }

  timeDifference(DateTime from, DateTime to) {
    // * joriy vaqt -> DateTime
    var nowString = "${currentTime.hour}:${currentTime.minute}";
    DateTime hozir = stringToDateTime(nowString);
    // * Ikki vaqt oralig'idagi farqni aniqlaymiz

    Duration diff = to.difference(from);
    Duration difToPray = to.difference(hozir);
    // * ularni stringga o'tkazamiz
    String hours = difToPray.inHours.toString();
    String minutes = (difToPray.inMinutes % 60).toString();
    //?-> Jami min dagi vaqtni 60 ga bo'lsak soatlardan ortib qolgani chiqadi

    // *Ekranga ko'rsatiluvchi vaqt
    remainedTime = "$hours:${minutes.length == 1 ? '0' + minutes : minutes}";
    // *Circular progress ni jami hajmi va tugagan qismlari
    remainedMinutes = difToPray.inMinutes;
    intervalMinutes = diff.inMinutes;
  }
}
