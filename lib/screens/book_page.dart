import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:resturant_automation/api/login.dart';
import 'package:resturant_automation/components/appbar.dart';
import 'package:resturant_automation/constants.dart';
import 'package:resturant_automation/navigators/screens.dart';

import '../functions/misc.dart';
import '../models/menu.dart';

class BookPage extends StatefulWidget {
  final Menu menu;

  BookPage({required this.menu});

  @override
  State<BookPage> createState() => _BookPageState(menu: menu);
}

class _BookPageState extends State<BookPage> {
  final Menu menu;

  _BookPageState({required this.menu});

  TextEditingController controllers = TextEditingController(text: "1");
  TextEditingController description = TextEditingController();

  num totalAmount = 0;
  //bool showLoading = true;

  @override
  void initState() {
    totalAmount = menu.unit_price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homePageAppBar(context),
      body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.07)),
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          child: ListView(children: [
            Text(
              "Make order for ${menu.name}",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            createSingleTicket(menu),
            const Divider(),
            TextField(
              controller: description,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 13,
                  overflow: TextOverflow.clip,
                  fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                //isDense: true,
                hintText: "Describe how your order should be made",

                border: const OutlineInputBorder(gapPadding: 0),
                focusedBorder: OutlineInputBorder(
                    gapPadding: 0, borderSide: BorderSide(color: mainColor)),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Amount",
                    ),
                    Text(totalAmount.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.9,
                            fontSize: 18))
                  ]),
            ),
          ])),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
          onPressed: () async {
            var box = Hive.box("account");
            bool isLoggedIn =
                box.get("logged_in", defaultValue: false) ?? false;
            if (!isLoggedIn) {
              showNotification("You need to be logged in to make an order");
              showLoginPage(context);
              return;
            }
            String token = box.get("account_token", defaultValue: "NULL");
            // get quantity
            int quantity = int.parse(controllers.text);

            // get menu
            int menuID = menu.id;

            await makeOrder(menuID, quantity, description.text, token)
                .then((value) => {showNotification("Successfuly made order")});
          },
          child: const Text("Make your order"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(mainColor),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
      ),
    );
  }

  Widget createSingleTicket(Menu menu) {
    TextStyle style1 =
        TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 12);
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Price",
                style: style1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Qty",
                  style: style1,
                ),
              ),
              Text(
                "Amount",
                style: style1,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Text(
                menu.unit_price.toString() + " KES",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5.0, top: 3),
              child: createQuantityLayout(),
            ),
            SizedBox(
              width: 50,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(totalAmount.toString(),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ],
        ),
        const SizedBox()
      ]),
    );
  }

  Widget createQuantityLayout() {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                String text = controllers.text;

                try {
                  int num = int.parse(text);
                  if (num > 0) {
                    num -= 1;
                    setState(() {
                      totalAmount = num * menu.unit_price;

                      controllers.text = num.toString();
                    });
                  }
                } catch (e) {}
              },
              child: Icon(
                Icons.do_disturb_on /* Interesting...size: ,*/,
                color: mainColor,
                size: 24,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SizedBox(
                width: 50,
                height: 30,
                child: TextField(
                  controller: controllers,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: false, signed: false),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 13,
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    //isDense: true,

                    border: const OutlineInputBorder(gapPadding: 0),
                    focusedBorder: OutlineInputBorder(
                        gapPadding: 0,
                        borderSide: BorderSide(color: mainColor)),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                String text = controllers.text;
                try {
                  int num = int.parse(text);
                  num += 1;
                  setState(() {
                    totalAmount = num * menu.unit_price;

                    controllers.text = num.toString();
                  });
                } catch (e) {
                  showNotification(
                      "Error parsing one of the fields\nPlease ensure all fields are correctly set");
                }
              },
              child: Icon(Icons.add_circle, color: mainColor, size: 24),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          thickness: 0.6,
        ),
      ],
    );
  }
}
