import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:resturant_automation/components/appbar.dart';
import 'package:resturant_automation/components/menu_item.dart';
import 'package:resturant_automation/models/menu.dart';


class FavouritesPage extends StatefulWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();

}

class _FavouritesPageState extends State<FavouritesPage> {
  var box = Hive.box("favourites");
  List<Menu> menus = [];

@override
  void initState(){
    super.initState();
    for (var event in box.values){
      menus.add(Menu.fromMap(event));
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar:homePageAppBar(context),
    
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                createEventsView(menus),
              ],
            ),
          ),
    );
  }
  
  Widget createEventsView(List<Menu> menu) {
    const double cardWidth = 150;
    const double imageHeight = 160;
    const double containerHeight = 240;

    return Flexible(
      child: GridView.count(
        physics: const BouncingScrollPhysics(),
        primary: false,
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        childAspectRatio: 0.6,
        // crossAxisSpacing: 10,
        // mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: [
          for (var menu in menus)
          createSingleMenu(menu, 200, 200, context)
         
        ],
      ),
    );
  }
}