//import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ramazo_taqvim/core/data/hive_boxes.dart';
import 'package:ramazo_taqvim/core/data/locations.dart';
import 'package:ramazo_taqvim/core/models/nomoz_times_model/model_praying_times.dart';
import 'package:ramazo_taqvim/core/network/service_praying_times.dart';

class LocationSearchPage extends SearchDelegate {
  Box<ModelPrayingTimes> pray_times = Boxes.getTime();

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              query = '';
            },
            icon: Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    // task_index = my_tasks.indexOf(new_result!);

    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestions = Locations.viloyatlar.where((element) {
      final result = element.toLowerCase().toString();
      final input = query.toLowerCase().toString();
      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () async {
              query = suggestions[index];
              // TODO home pagega qaytish, nomoz vaqtlarini o'zgartirib
              List<ModelPrayingTimes> datas = [];

              await pray_times.clear();
              await ServicePrayingTimes.getTimes(query)
                  .then((value) => datas = value);
              // * sanalarni ketma ketlik bo'yicha sortlaymiz
              datas.sort((a, b) {
                var aDate = a.date;
                var bDate = b.date;
                return aDate!.compareTo(bDate!);
              });
              for (ModelPrayingTimes model in datas) {
                await pray_times.add(model);
              }

              Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
            },
            title: Text("${suggestions[index]} nomoz vaqtlariga o'tish"),
          );
        });
  }
}
