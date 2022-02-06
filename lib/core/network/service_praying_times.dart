import 'package:dio/dio.dart';

import 'package:ramazo_taqvim/core/models/nomoz_times_model/model_praying_times.dart';

class ServicePrayingTimes {
  static Future<List<ModelPrayingTimes>> getTimes(String viloyat) async {
    String url =
        "https://namozvaqti.herokuapp.com/api/monthly?region=$viloyat&month=2";
    Response<dynamic> response = await Dio().request(url);

    return (response.data as List)
        .map((e) => ModelPrayingTimes.fromJson(e))
        .toList();
  }
}
