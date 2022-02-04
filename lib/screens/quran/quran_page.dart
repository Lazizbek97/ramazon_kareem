import 'package:flutter/material.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quran Kareem"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.home_outlined),
          iconSize: 30,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              child: SearchField(),
            ),
            Expanded(
              // width: double.infinity,
              child: ListView.separated(
                  itemCount: 30,
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.grey,
                      ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.pushNamed(context, "/sura"),
                      child: const ListTile(
                        // tileColor: Colors.teal,
                        shape: RoundedRectangleBorder(),
                        leading: Icon(Icons.circle_outlined),
                        title: Text("Al-Fatihah"),
                        subtitle: Text("Meccan -7 Verses"),
                        trailing: Text("Arabian Name"),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: "Search",
        suffixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.all(10),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 0.0),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 0.0),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
