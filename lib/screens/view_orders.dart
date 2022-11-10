import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:resturant_automation/api/get_menus.dart';
import 'package:resturant_automation/components/appbar.dart';
import 'package:resturant_automation/components/carousel_image.dart';
import 'package:resturant_automation/components/menu_item.dart';
import 'package:resturant_automation/models/menu.dart';
import 'package:resturant_automation/models/orders.dart';

import '../api/login.dart';

class ViewOrdersPage extends StatefulWidget {
  const ViewOrdersPage({super.key});

  @override
  State<ViewOrdersPage> createState() => _ViewOrdersPageState();
}

class _ViewOrdersPageState extends State<ViewOrdersPage> {
  
  Widget createBody(List<Orders> orders) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
         
        
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 5),
              child: Text(
                "A look back into the amazing decisions you made",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              )),
          GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.55,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            shrinkWrap: true,
            primary: false,
            children: [
                for (var order in orders)
                  createSingleOrder(order, 200, 200, context)
            ],
          ),
        ],
      ),
    );
  }

  Future<Widget> loadMenus() async {
    var box = Hive.box("account");
    var account_token = box.get("account_token",defaultValue: "NULL");

    var result = await getOrders(account_token);

    return createBody(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
                "Orders",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),),
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
