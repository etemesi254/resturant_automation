import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:resturant_automation/constants.dart';
import 'package:resturant_automation/navigators/screens.dart';

import '../functions/misc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Box<dynamic> box = Hive.box("account");
  bool isLoggedIn = false;

  @override
  void dispose() {
    // close our box instance
    // box.close();
    // do the other cleanup
    super.dispose();
  }

  @override
  void initState() {
    isLoggedIn = box.get("logged_in") ?? false;
    initAsync();
  }

  void initAsync() async {
    box = await Hive.openBox("account");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: mainColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            "Personal Information",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          shadowColor: Colors.white,
          elevation: 1,
          automaticallyImplyLeading: true,
          toolbarHeight: 60,
        ),
        bottomNavigationBar: Container(
            padding: const EdgeInsets.all(10),
            child: isLoggedIn
                ? TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(mainColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side: BorderSide(
                              color: mainColor,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(9.0))),
                    ),
                    onPressed: () {
                      // Pop this
                      setState(() {
                        isLoggedIn = false;
                        box.clear();
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text("Log Out"),
                    ))
                : TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(mainColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          side: BorderSide(
                              color: mainColor,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(9.0))),
                    ),
                    onPressed: () {
                      // Pop this
                      //Navigator.of(context).pop();
                      // Pop this
                      showLoginPage(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text("Log In"),
                    ))),
        body: createBody());
  }

  Widget createBody() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListView(physics: const BouncingScrollPhysics(), children: [
        Padding(padding: EdgeInsets.all(8), child: createImageProfile()),
        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: createMainText("Personal Details"),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: Colors.black.withOpacity(0.1), width: 0.9),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createSingeInfoPane("Full Name", "fullname",false),
              createSmallerPaddedDivider(),
              createSingeInfoPane("User Name", "username",false),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        showNotification(
                            "Contains unique username and full name of logged in user");
                      },
                      icon: Icon(
                        Icons.info,
                        color: mainColor,
                      )),
                ],
              ),
            ],
          ),
        ),

        
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: createMainText("Payment Details"),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: Colors.black.withOpacity(0.1), width: 0.9),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              createSingeInfoPane("Email Address", "email",true),
              createSmallerPaddedDivider(),
              createSingeInfoPane("Mobile Number", "mobile",true),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        showNotification(
                            "You can put details here to be autofilled during payment.\nData is saved in device and not shared with tokea.com\nunless you choose to pay using those details");
                      },
                      icon: Icon(
                        Icons.info,
                        color: mainColor,
                      )),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget createLogInDetails() {
    return Row(children: [
      const Text("Hello user, log in to get a personalized experince")
    ]);
  }

  Widget createPaddedDivider() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Divider(),
    );
  }

  Widget createSmallerPaddedDivider() {
    return const Padding(
      padding: EdgeInsets.all(5.0),
      child: Divider(),
    );
  }

  Widget createMainText(String text) {
    return Text(text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17));
  }

  Widget createFomarttedBoutton(String event) {
    Color backgroundColor = Colors.white;
    Color foregroundColor = mainColor;
    Color textColor = mainColor;

    MaterialStateProperty<OutlinedBorder> border = MaterialStateProperty.all(
        RoundedRectangleBorder(
            side: BorderSide(
                color: mainColor, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(9.0)));

    return Container(
      width: 110,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(mainColor),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: border,
          ),
          onPressed: () {
            // Pop this
          },
          child: Text(
            event,
          )),
    );
  }

  Widget createSingeInfoPane(String title, String hiveKey,bool editable ) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          TextField(
            onChanged: (newValue) {
              box.put(hiveKey, newValue);
            },
            enabled: editable,
            controller: TextEditingController(text: box.get(hiveKey)),
            decoration: InputDecoration(
              isDense: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              label: Text(title,
                  style: TextStyle(
                      fontSize: 12, color: Colors.black.withOpacity(0.7))),
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Widget createCreditCardLayout(String creditCard, String expiry) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(creditCard),
        SizedBox(width: 10),
        Text(expiry),
        InkWell(
          onTap: () {},
          child: Icon(
            Icons.delete,
            color: mainColor,
          ),
        )
      ],
    );
  }

  Widget createImageProfile() {
    String text = box.get("fullname", defaultValue: "X")[0];

    return Center(
        child: CircleAvatar(
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
      minRadius: 35,
      backgroundColor: mainColor,
    ));
  }
}
