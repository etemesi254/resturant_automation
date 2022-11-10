import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:resturant_automation/api/get_menus.dart';
import 'package:resturant_automation/components/appbar.dart';
import 'package:resturant_automation/components/carousel_image.dart';
import 'package:resturant_automation/components/menu_item.dart';
import 'package:resturant_automation/models/menu.dart';

class WhatsNew extends StatefulWidget {
  const WhatsNew({super.key});

  @override
  State<WhatsNew> createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  TextEditingController searchBox = TextEditingController();

  Widget createBody(List<Menu> menus) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          TextField(
            onChanged: ((value) {
              setState(() {});
            }),
            controller: searchBox,
            decoration: InputDecoration(
              isDense: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              label: Text("Enter Search terms",
                  style: TextStyle(
                      fontSize: 12, color: Colors.black.withOpacity(0.7))),
            ),
            textAlign: TextAlign.start,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Text(
                "Menus",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              )),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Text(
                "69 ways to kill hunger",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              )),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            shrinkWrap: true,
            primary: false,
            children: [
              for (var menu in menus)
                if (searchBox.text.isEmpty ||
                    searchBox.text.isNotEmpty &&
                        menu.name
                            .toLowerCase()
                            .contains(searchBox.text.toLowerCase()))
                  createSingleMenu(menu, 200, 200, context)
            ],
          ),
        ],
      ),
    );
  }

  Future<Widget> loadMenus() async {
    var result = await getMenus();

    return createBody(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      body: FutureBuilder(
          future: loadMenus(),
          builder: (context, snapshot) {
            Widget child;
            if (snapshot.hasData) {
              child = snapshot.data!;
            } else if (snapshot.hasError) {
              child = Center(child: Text(snapshot.error!.toString()));
            } else {
              child = const Center(child: CircularProgressIndicator.adaptive());
            }
            return child;
          }),
    );
  }
}
