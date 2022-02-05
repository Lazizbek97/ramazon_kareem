import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ramazo_taqvim/core/data/offline_data.dart';
import 'package:ramazo_taqvim/core/utils/constants.dart';
import 'package:ramazo_taqvim/core/utils/size_config.dart';

class MuborakKunlarPage extends StatefulWidget {
  const MuborakKunlarPage({Key? key}) : super(key: key);

  @override
  State<MuborakKunlarPage> createState() => _MuborakKunlarPageState();
}

class _MuborakKunlarPageState extends State<MuborakKunlarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: getHeight(70),
        centerTitle: true,
        title: SizedBox(
          width: double.infinity,
          child: Text(
            "${DateTime.now().year} yil uchun Xijriy muborak sanalar",
            style: TextStyle(fontSize: ConstantSizes.app_bar_size),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: ExpansionTile(
              title: AutoSizeText(
                diniyKunalar[index].nomi,
                style: TextStyle(
                  fontSize: ConstantSizes.header_third_size,
                  fontWeight: FontWeight.w700,
                ),
              ),
              children: [
                SizedBox(
                  child: SingleChildScrollView(
                    child: Text(
                      diniyKunalar[index].haqida,
                      style:
                          TextStyle(fontSize: ConstantSizes.header_third_size),
                    ),
                  ),
                )
              ],
              subtitle: Text(diniyKunalar[index].sanasi),
            ),
          ),
          itemCount: diniyKunalar.length,
        ),
      ),
    );
  }
}
