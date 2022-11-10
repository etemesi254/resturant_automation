import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:resturant_automation/components/appbar.dart';
import 'package:resturant_automation/constants.dart';
import 'package:resturant_automation/main.dart';
import 'package:resturant_automation/screens/home_page.dart';
import 'package:resturant_automation/screens/profile_page.dart';
import 'package:resturant_automation/screens/whatsnew_page.dart';

class LandingPage extends StatefulWidget {
  LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<LandingPage> {
  late TabController controller;
  int tabIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this, initialIndex: 0)
      ..addListener(() {
        if (!controller.indexIsChanging) {
          setState(() {
            tabIndex = controller.index;
          });
        }
      });
    // initialize hive from here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: homePageAppBar(context),
      body: TabBarView(
        controller: controller,
        children: [HomePage(), WhatsNew(), ProfilePage()],
      ),
      bottomNavigationBar: SizedBox(
          height: 60,
          child: TabBar(
              // padding: const EdgeInsets.symmetric(horizontal: 10),
              controller: controller,
              isScrollable: false,
              labelColor: mainColor,
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.black.withOpacity(0.6),
              indicatorWeight: 0.1,
              tabs: const [
                Tab(
                  text: "Home",
                  icon: Icon(Icons.home),
                ),
                Tab(
                  text: "What's New",
                  icon: Icon(Icons.event),
                ),
                Tab(
                  text: "Profile",
                  icon: Icon(Icons.account_circle),
                ),
              ])),
    );
  }
}
