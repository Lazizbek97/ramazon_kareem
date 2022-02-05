import 'package:flutter/material.dart';
import 'package:ramazo_taqvim/core/utils/constants.dart';

class Tasbeh extends StatefulWidget {
  @override
  State<Tasbeh> createState() => _Tasbeh();
}

class _Tasbeh extends State<Tasbeh> {
  int _count = 0;
  List<String> zikrlar = [
    "Subhanalloh",
    "Alhamdulillah",
    "La ilaha illalloh",
    "Allohu akbar",
  ];
  int zikr_no = 0;
  int max_zikr = 33;
  bool is_audo_on = false;
  bool is_dark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          is_dark ? ConstantColors.scaffold_background : Colors.black,
      appBar: AppBar(
        title: Text(
          "Tasbeh",
          style: TextStyle(fontSize: ConstantSizes.app_bar_size),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () =>
              Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 35,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu_sharp,
                size: 35,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: is_dark
                ? Image.asset(
                    ConstantLinks.tasbeh_gif,
                  )
                : null,
          ),
          Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 30),
              width: MediaQuery.of(context).size.width * 0.7,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  zikrlar[zikr_no],
                  style: const TextStyle(fontSize: 40),
                ),
              )),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.13,
                width: MediaQuery.of(context).size.width * 0.13,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.settings_suggest,
                    size: 50,
                  ),
                  padding: const EdgeInsets.fromLTRB(0, 0, 2, 2),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.13,
                width: MediaQuery.of(context).size.width * 0.13,
                child: IconButton(
                  onPressed: () {
                    _count = 0;
                    zikr_no = 0;
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.change_circle_outlined,
                    size: 50,
                  ),
                  padding: const EdgeInsets.fromLTRB(0, 0, 2, 2),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.13,
                width: MediaQuery.of(context).size.width * 0.13,
                child: IconButton(
                  padding: const EdgeInsets.fromLTRB(0, 0, 2, 2),
                  onPressed: () {
                    is_audo_on ? is_audo_on = false : is_audo_on = true;
                    setState(() {});
                  },
                  icon: sount_regulate(),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.13,
                width: MediaQuery.of(context).size.width * 0.13,
                child: IconButton(
                  padding: const EdgeInsets.fromLTRB(0, 0, 2, 2),
                  onPressed: () {
                    is_dark ? is_dark = false : is_dark = true;
                    setState(() {});
                  },
                  icon: change_mode(),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.only(right: 25),
            child: CircleAvatar(
              backgroundColor: const Color(0xff32abc7),
              radius: 25,
              child: IconButton(
                onPressed: () {
                  if (max_zikr == 33) {
                    max_zikr = 99;
                    setState(() {});
                  } else {
                    max_zikr = 33;
                    setState(() {});
                  }
                },
                icon: Text(
                  "$max_zikr",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: MediaQuery.of(context).size.width * 0.6,
        width: MediaQuery.of(context).size.width * 0.6,
        margin: const EdgeInsets.only(bottom: 40),
        child: FloatingActionButton(
          backgroundColor: Color(0xff32abc7),
          onPressed: () {
            if (_count < max_zikr) {
              increase();
            } else {
              _count = 0;
              if (zikr_no < 3) {
                zikr_no += 1;
              } else {
                zikr_no = 0;
                zikr_no += 1;
              }
              ;
              increase();
            }
          },
          child: Text(
            "$_count",
            style: const TextStyle(fontSize: 50),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  increase() {
    _count += 1;
    setState(() {});
  }

  sount_regulate() {
    if (is_audo_on) {
      return const Icon(
        Icons.volume_up,
        size: 50,
      );
    } else {
      return const Icon(
        Icons.volume_off,
        size: 50,
      );
    }
  }

  change_color() => is_dark ? Colors.black : Colors.white;

  change_mode() {
    if (is_dark) {
      return const Icon(
        Icons.light_mode_outlined,
        size: 50,
      );
    } else {
      return const Icon(
        Icons.dark_mode_outlined,
        color: Colors.white,
        size: 50,
      );
    }
  }
}
