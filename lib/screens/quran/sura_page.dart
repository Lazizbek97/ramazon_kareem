import 'package:flutter/material.dart';
import 'package:ramazo_taqvim/core/utils/constants.dart';
import 'package:ramazo_taqvim/core/utils/size_config.dart';
import 'package:ramazo_taqvim/core/widgets/container_decoration.dart';

class SuraPage extends StatelessWidget {
  const SuraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ar-Rahman"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            sliver: SliverToBoxAdapter(
              child: ContainerDecoration(
                child: Column(
                  children: [
                    Text("Sura raqami"),
                    Text(
                      "Ar-Rahman",
                      style:
                          TextStyle(fontSize: ConstantSizes.header_second_size),
                    ),
                    Text("The Merciful"),
                  ],
                ),
                height: 200,
                width: 400,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Container(
                height: getHeight(500),
                width: double.infinity,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 10,
                      color: Colors.green,
                    );
                  },
                ),
              );
            }, childCount: 1),
          ),
        ],
      ),
    );
  }
}
