import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resturant_automation/api/login.dart';
import 'package:resturant_automation/components/appbar.dart';
import 'package:resturant_automation/constants.dart';
import 'package:resturant_automation/navigators/screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();

  TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool passwordObscure = true;

  @override
  void initState() {
    super.initState();

    // setState(() {
    //   isLoggedIn = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homePageAppBar(context),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(40),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 0.1),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(30))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "Enter your email and password to continue",
                        style:
                            TextStyle(color: Color.fromRGBO(187, 187, 187, 1)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(
                      height: 4,
                    ),
                    TextField(
                      //style: (color: Colors.white),
                      controller: phone,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "07xxxxxxxxx",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text("Email",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.7))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      //style: (color: Colors.white),
                      controller: password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                  
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "XXXXX",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text("Password",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.7))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(mainColor)),
                                onPressed: () async {
                                  login(phone.text.toString(),
                                          password.text.toString())
                                      .then((value) =>
                                          {showAccountPage(context)})
                                    ;
                                },
                                child: const Text("Continue",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        //color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17)))),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          //Visibility(child: serverRequest(), visible: isLoading)
        ],
      ),
    );
  }
}
