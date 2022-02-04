import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ramazo_taqvim/core/data/hive_boxes.dart';
import 'package:ramazo_taqvim/core/data/hive_initialize.dart';
import 'package:ramazo_taqvim/core/models/model_praying_times.dart';

class ServicePrayingTimes {
  static String url =
      "https://namozvaqti.herokuapp.com/api/monthly?region=toshkent&month=2";
  static Future<List<ModelPrayingTimes>> getTimes() async {
    Response<dynamic> response = await Dio().request(url);

    return (response.data as List)
        .map((e) => ModelPrayingTimes.fromJson(e))
        .toList();
  }
}