import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hive/hive.dart';
import 'package:resturant_automation/components/appbar.dart';
import 'package:resturant_automation/components/expandable_fab.dart';
import 'package:resturant_automation/components/menu_item.dart';
import 'package:resturant_automation/constants.dart';
import 'package:resturant_automation/globals.dart';
import 'package:resturant_automation/navigators/screens.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/constants.dart';
import '../functions/misc.dart';
import '../models/menu.dart';

class MenuPage extends StatefulWidget {
  final Menu menu;

  MenuPage({required this.menu});

  @override
  State<MenuPage> createState() => _MenuPageState(menu: menu);
}

class _MenuPageState extends State<MenuPage> {
  final Menu menu;
  _MenuPageState({required this.menu});

  @override
  Widget build(BuildContext context) {
    const EdgeInsets textInset = EdgeInsets.symmetric(horizontal: 10);

    return Scaffold(
      appBar: homePageAppBar(context),
      floatingActionButton: ExpandableFab(
        distance: 150.0,
        children: [
          ActionButton(
            onPressed: () => showContactsDialog(),
            //_showAction(context, 0),
            icon: const Icon(Icons.chat_bubble),
          ),
          ActionButton(
            onPressed: () => addToFavourites(), //_showAction(context, 1),
            icon: const Icon(Icons.favorite),
          ),
          ActionButton(
            onPressed: () {
              FlutterShare.share(
                  title: menu.name,
                  text: "${menu.name}\n\n${menu.description}",
                  linkUrl: "http://example.org");
            }, //_showAction(context, 2),
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              //height: imgHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: mainColor.withOpacity(0.5),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    "$BASE_URL/${menu.image.replaceAll("public", "storage")}",
                // imageUrl: menu.image,
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: textInset,
              child: Text(menu.name,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: textInset,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.add_location_outlined),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(menu.category_name,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 13,
                            )),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(menu.subcategory_name,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 13,
                            )),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: textInset,
              child: Text(
                menu.description,
                style: const TextStyle(letterSpacing: 0.9),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            createYouMayAlsoLike(),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(mainColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side:  BorderSide(
                            color: mainColor,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(9.0))),
                  ),
                  onPressed: () {
                    showBookingPage(context, menu);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Text("Make an order"),
                  ))),
    
    );
  }
  void addToFavourites() {
      var box = Hive.box("favourites");

    box.put(menu.id, menu.toMap());
    showNotification("Added ${menu.name} to favourites");
  }
  

  Widget createYouMayAlsoLike() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "You May Also Like",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 270,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                for (var singleMenu in globalMenus)
                  if (singleMenu.name != menu.name)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: createSingleMenu(singleMenu, 150, 160, context),
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void showContactsDialog() {
    showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 50, vertical: 250),
              title: const Text("Get in Touch with us"),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                      "Get in touch With Heavens taste Resturant using the following channels"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Email "),
                      const Text(" info@heavenstaste.com"),
                      IconButton(
                          onPressed: () async {
                            await launchUrl(
                                Uri.parse("mailto:info@heavens_taste.com"));
                            // await Clipboard.setData(
                            //     const ClipboardData(text: "info@tokea.com"));
                          },
                          icon: Icon(
                            Icons.email,
                            color: mainColor,
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Phone"),
                      const Text(" +254 115 555000"),
                      IconButton(
                          onPressed: () async {
                            await launchUrl(Uri.parse("tel:+254 115 555000"));

                            // await Clipboard.setData(
                            //     const ClipboardData(text: "+254 115 555000"));
                            //     showNotification("Successfully copied phone number to clipboard");
                          },
                          icon: Icon(
                            Icons.phone,
                            color: mainColor,
                          ))
                    ],
                  )
                ],
              ));
        });
  }
}
