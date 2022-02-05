import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ramazo_taqvim/core/data/hive_boxes.dart';
import 'package:ramazo_taqvim/core/data/hive_initialize.dart';
import 'package:ramazo_taqvim/core/models/nomoz_times_model/model_praying_times.dart';
import 'package:ramazo_taqvim/core/models/quran_model/quran_in_arabian.dart';
import 'package:ramazo_taqvim/core/models/quran_model/quran_model.dart';
import 'package:http/http.dart' as http;

class ServiceQuran {
  static var url = Uri.parse("http://api.alquran.cloud/v1/quran/uz.sodik");
  static var urlInArabian =
      Uri.parse("http://api.alquran.cloud/v1/quran/quran-uthmani");

  static Future<List<QuranArabianModel>> getQuran() async {
    var response = await http.get(url);

    var res = jsonDecode(response.body);

    return (res['data']['surahs'] as List)
        .map((e) => QuranArabianModel.fromJson(e))
        .toList();
  }

  static Future<List<QuranInArabianModel>> getQuranInArabian() async {
    var response = await http.get(urlInArabian);

    var res = jsonDecode(response.body);

    return (res['data']['surahs'] as List)
        .map((e) => QuranInArabianModel.fromJson(e))
        .toList();
  }
}
