import 'dart:io';

import 'package:hive/hive.dart';
import 'package:ramazo_taqvim/core/data/hive_boxes.dart';
import 'package:ramazo_taqvim/core/models/alarms/alarms.dart';
import 'package:ramazo_taqvim/core/models/ismlar_model/ismlar_model.dart';
import 'package:ramazo_taqvim/core/models/nomoz_times_model/model_praying_times.dart';
import 'package:ramazo_taqvim/core/models/quran_model/quran_in_arabian.dart';
import 'package:ramazo_taqvim/core/models/quran_model/quran_model.dart';

class InitializeHive {
  // static Box box;
  static hive_init(Directory file_path) async {
    Hive.init(file_path.path);
    Hive.registerAdapter(ModelPrayingTimesAdapter());
    Hive.registerAdapter(TimesAdapter());
    Hive.registerAdapter(QuranArabianModelAdapter());
    Hive.registerAdapter(AyahAdapter());
    Hive.registerAdapter(QuranInArabianModelAdapter());
    Hive.registerAdapter(OyatAdapter());
    Hive.registerAdapter(OllohIsmlariModelAdapter());
    Hive.registerAdapter(AlarmModelAdapter());

    await Hive.openBox<ModelPrayingTimes>("nomoz_vaqtlari");
    await Hive.openBox<QuranArabianModel>("quran");
    await Hive.openBox<QuranInArabianModel>("quran_in_arabian");
    await Hive.openBox<OllohIsmlariModel>("ismlar");
    await Hive.openBox<AlarmModel>("alarms");
  }
}
