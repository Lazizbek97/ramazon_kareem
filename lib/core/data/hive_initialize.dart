import 'dart:io';

import 'package:hive/hive.dart';
import 'package:ramazo_taqvim/core/data/hive_boxes.dart';
import 'package:ramazo_taqvim/core/models/model_praying_times.dart';
// import 'package:ramazo_taqvim/core/models/model_time.dart';

class InitializeHive {
  // static Box box;
  static hive_init(Directory file_path) async {
    Hive.init(file_path.path);
    Hive.registerAdapter(ModelPrayingTimesAdapter());
    Hive.registerAdapter(TimesAdapter());

    await Hive.openBox<ModelPrayingTimes>("nomoz_vaqtlari");
  }

  static addToHive(List<ModelPrayingTimes> datas) async {
    Box box = Boxes.getTime();
    box.clear();
    for (var item in datas) {
      await box.add(item);
    }
  }
}
