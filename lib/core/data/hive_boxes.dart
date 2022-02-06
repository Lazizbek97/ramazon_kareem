import 'package:hive/hive.dart';
import 'package:ramazo_taqvim/core/models/alarms/alarms.dart';
import 'package:ramazo_taqvim/core/models/ismlar_model/ismlar_model.dart';
import 'package:ramazo_taqvim/core/models/nomoz_times_model/model_praying_times.dart';
import 'package:ramazo_taqvim/core/models/quran_model/quran_in_arabian.dart';
import 'package:ramazo_taqvim/core/models/quran_model/quran_model.dart';

class Boxes {
  static Box<ModelPrayingTimes> getTime() =>
      Hive.box<ModelPrayingTimes>("nomoz_vaqtlari");
  static Box<QuranArabianModel> getQuran() =>
      Hive.box<QuranArabianModel>("quran");
  static Box<QuranInArabianModel> getQuranInArabian() =>
      Hive.box<QuranInArabianModel>("quran_in_arabian");
  static Box<OllohIsmlariModel> getNames() =>
      Hive.box<OllohIsmlariModel>("ismlar");
  static Box<AlarmModel> getAlarm() => Hive.box<AlarmModel>("alarms");
}
