import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:resturant_automation/api/get_menus.dart';
import 'package:resturant_automation/components/appbar.dart';
import 'package:resturant_automation/components/carousel_image.dart';
import 'package:resturant_automation/components/menu_item.dart';
import 'package:resturant_automation/models/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget createBody(List<Menu> menus) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        showCarousel(),
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
          childAspectRatio: 0.63,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          shrinkWrap: true,
          primary: false,
          children: [
            for (var menu in menus) createSingleMenu(menu, double.infinity, 200, context)
          ],
        ),
      ],
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
