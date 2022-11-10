import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resturant_automation/api/constants.dart';
import 'package:resturant_automation/constants.dart';
import 'package:resturant_automation/models/menu.dart';
import 'package:resturant_automation/models/orders.dart';
import 'package:resturant_automation/navigators/screens.dart';

Widget createSingleMenu(
    Menu menu, double imgWidth, double imgHeight, BuildContext context) {
  return InkWell(
    onTap: () {
      showMenuPage(context, menu);
    },
    child: Container(
        height: 240,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(color: mainColor),
                child: CachedNetworkImage(
                  imageUrl:
                      "$BASE_URL/${menu.image.replaceAll("public", "storage")}",
                  //imageUrl: menu.image,
                  width: imgWidth,
                  height: imgHeight,
                  fit: BoxFit.fill,
                )),
            Text(
              menu.name,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 19),
            Text(
              menu.subcategory_name,
              style:
                  TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 15),
            )
          ],
        )),
  );
}

Widget createSingleOrder(
    Orders orders, double imgWidth, double imgHeight, BuildContext context) {
  return Container(
      height: 240,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(color: mainColor),
              child: CachedNetworkImage(
                imageUrl:
                    "$BASE_URL/${orders.image.replaceAll("public", "storage")}",
                //imageUrl: menu.image,
                width: imgWidth,
                height: imgHeight,
                fit: BoxFit.fill,
              )),
          Text(
            orders.name,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 9),
          Text(
            "Total: ${orders.unit_price}",
            style:
                TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 15),
          ),
          
          const SizedBox(height: 9),
          Text(
            "Status: ${orders.status}",
            style:
                TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 15),
          ),
          const SizedBox(height: 9),
          Text(
            "Quantity: ${orders.quantity}",
            style:
                TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 15),
          )
        ],
      ));
}
