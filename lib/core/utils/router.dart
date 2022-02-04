import 'package:flutter/material.dart';
import 'package:ramazo_taqvim/core/utils/exporting_packages.dart';
import 'package:ramazo_taqvim/screens/countdown_page.dart/countdown_page.dart';
import 'package:ramazo_taqvim/screens/quran/quran_page.dart';
import 'package:ramazo_taqvim/screens/quran/sura_page.dart';

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
          builder: (context) => const CountdownPage(),
        );
      case "/quran":
        return MaterialPageRoute(
          builder: (context) => const QuranPage(),
        );
      case "/sura":
        return MaterialPageRoute(
          builder: (context) => const SuraPage(),
        );
    }
  }
}
