import 'package:flutter/material.dart';
import 'package:ramazo_taqvim/core/models/nomoz_times_model/model_praying_times.dart';
import 'package:ramazo_taqvim/core/models/quran_model/quran_in_arabian.dart';
import 'package:ramazo_taqvim/core/models/quran_model/quran_model.dart';
import 'package:ramazo_taqvim/core/utils/exporting_packages.dart';
import 'package:ramazo_taqvim/screens/countdown_page.dart/countdown_page.dart';
import 'package:ramazo_taqvim/screens/ismlar_page/ismlar_page.dart';
import 'package:ramazo_taqvim/screens/muborak_days/muborak_kunlar.dart';
import 'package:ramazo_taqvim/screens/qibla_page/qibla_page.dart';
import 'package:ramazo_taqvim/screens/quran/quran_page.dart';
import 'package:ramazo_taqvim/screens/quran/sura_page.dart';
import 'package:ramazo_taqvim/screens/tasbeh/tasbeh.dart';

class RouterGenerator {
  static generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (context) => const MyHomePage(),
        );
      case "/countdown":
        return MaterialPageRoute(
          builder: (context) => CountdownPage(
            today: args as ModelPrayingTimes,
          ),
        );
      case "/quran":
        return MaterialPageRoute(
          builder: (context) => const QuranPage(),
        );
      case "/tasbeh":
        return MaterialPageRoute(
          builder: (context) => Tasbeh(),
        );
      case "/muborak_kunlar":
        return MaterialPageRoute(
          builder: (context) => const MuborakKunlarPage(),
        );
      case "/ismlar":
        return MaterialPageRoute(
          builder: (context) => IsmlarPage(),
        );
      case "/qibla":
        return MaterialPageRoute(
          builder: (context) => QiblaPage(),
        );
      case "/sura":
        List arguments = args as List;
        return MaterialPageRoute(
          builder: (context) => SuraPage(
            sura: arguments[0] as QuranArabianModel,
            suraInArabian: arguments[1] as QuranInArabianModel,
          ),
        );
    }
  }
}
