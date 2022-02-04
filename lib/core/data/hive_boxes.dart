import 'package:hive/hive.dart';
import 'package:ramazo_taqvim/core/models/model_praying_times.dart';

class Boxes {
  static Box<ModelPrayingTimes> getTime() =>
      Hive.box<ModelPrayingTimes>("nomoz_vaqtlari");
}
