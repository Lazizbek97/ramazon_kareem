import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ramazo_taqvim/core/data/hive_boxes.dart';
import 'package:ramazo_taqvim/core/models/nomoz_times_model/model_praying_times.dart';
import 'package:ramazo_taqvim/core/models/quran_model/quran_model.dart';
import 'package:ramazo_taqvim/core/network/service_praying_times.dart';
import 'package:ramazo_taqvim/core/network/service_quran.dart';
import 'package:ramazo_taqvim/core/utils/constants.dart';
import 'package:ramazo_taqvim/core/utils/size_config.dart';
import 'package:ramazo_taqvim/core/widgets/azon_time_container.dart';
import 'package:ramazo_taqvim/core/widgets/container_decoration.dart';
import 'package:ramazo_taqvim/core/widgets/iftar_saher_container.dart';
import 'package:ramazo_taqvim/screens/drawer_page.dart/drawer_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bool _switchValueIftar = false;
  final bool _switchValueSaher = false;

  List<ModelPrayingTimes>? pray_times;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // Agar DataBase da ma'lumot bo'lsa ushandan malumot olib keladi, aks holda so'rov junatib databaseni to'ldiradi
    checkingDataBase();
    pray_times = Boxes.getTime().values.toList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerPage(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        getWidth(20), getHeight(0), getWidth(0), getHeight(10)),
                    child: SizedBox(
                        height: getHeight(170),
                        width: getWidth(220),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                              icon: const Icon(Icons.menu),
                              padding: const EdgeInsets.only(left: 0),
                              alignment: Alignment.centerLeft,
                              iconSize: 30,
                            ),
                            Text(
                              "Ramadan Kareem",
                              style: TextStyle(
                                fontSize: ConstantSizes.hearder_one_size,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    height: getHeight(130),
                    width: getWidth(110),
                    child: Image.asset(
                      ConstantLinks.lantern_image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    getWidth(20), getHeight(10), getWidth(20), getHeight(20)),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.57,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ContainerDecoration(
                            child: IftarSaharAlert(
                              sub_text: "Iftorlik Vaqti",
                              time:
                                  pray_times![3].times!.tongSaharlik.toString(),
                              icon: Icon(
                                Icons.light_mode_outlined,
                                size: ConstantSizes.icon_size,
                              ),
                              switchValue: _switchValueIftar,
                            ),
                            height: 210,
                            width: 155,
                          ),
                          ContainerDecoration(
                            child: IftarSaharAlert(
                              sub_text: "Saharlik Vaqti",
                              time: pray_times![3].times!.shomIftor.toString(),
                              icon: Icon(
                                Icons.nights_stay_outlined,
                                size: ConstantSizes.icon_size,
                              ),
                              switchValue: _switchValueSaher,
                            ),
                            height: 210,
                            width: 155,
                          ),
                        ],
                      ),
                      ContainerDecoration(
                        child: AzonTimes(),
                        height: 470,
                        width: 170,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: SizedBox(
          height: getHeight(60),
          width: getWidth(210),
          child: FloatingActionButton.extended(
            onPressed: () {
              Box newBox = Boxes.getTime();
              Box newQuran = Boxes.getQuran();

              print(newBox.values.length);
              print(newQuran.values.length);

              Navigator.pushNamed(context, "/countdown");
            },
            icon: const Icon(Icons.keyboard_arrow_right_outlined),
            label: const Center(
              child: Text("Batafsil"),
            ),
          ),
        ),
      ),
    );
  }

  checkingDataBase() async {
    List<ModelPrayingTimes> datas = [];

    Box boxtime = await Boxes.getTime();

    if (boxtime.isEmpty) {
      await ServicePrayingTimes.getTimes().then((value) => datas = value);

      for (ModelPrayingTimes model in datas) {
        await boxtime.add(model);
      }
    }
  }
}
