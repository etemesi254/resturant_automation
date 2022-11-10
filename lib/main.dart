import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:resturant_automation/components/menu_item.dart';
import 'package:resturant_automation/models/menu.dart';
import 'package:resturant_automation/screens/home_page.dart';
import 'package:resturant_automation/screens/landing_page.dart';
import 'package:resturant_automation/themes/app_theme.dart';

void main() async{
   // Initialize hive from here
  await Hive.initFlutter();

  /// create boxes here
  await Hive.openBox('account');
  await Hive.openBox("favourites");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(child:  MaterialApp(
      title: "Heaven's Taste",
      theme: AppTheme.themeData(false, context),
      debugShowCheckedModeBanner: false,

      home: LandingPage(),
    ));
  }
}

