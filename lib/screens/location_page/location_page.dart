//import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:ramazo_taqvim/core/data/locations.dart';

class LocationSearchPage extends SearchDelegate {
  // List<TaskModel> my_tasks = Boxes.getTask().values.toList();
  // TaskModel? new_result;
  // int? task_index;

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

    return Scaffold();
    //  SearchResult(
    // task: new_result!,
    // index: task_index!,
    // );
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
            onTap: () {
              // new_result = suggestions[index];
              query = suggestions[index];
              // showResults(context);
            },
            title: Text(suggestions[index]),
          );
        });
  }
}
