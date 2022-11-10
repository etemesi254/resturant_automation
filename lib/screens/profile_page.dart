import 'package:flutter/material.dart';
import 'package:resturant_automation/constants.dart';

import '../navigators/screens.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Widget buildBody() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color:const Color.fromRGBO(0, 0, 0, 0.07)),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            createRow(Icons.account_circle_outlined, mainColor, "Account",
                showAccountPage),
            const Divider(),

            createRow(Icons.event_available, mainColor, "Orders",
                showOrdersPage),
            const Divider(),

            // createRow(Icons.local_activity_outlined, mainColor, "My Tickets",
            //     showHomePage),
            // const Divider(),

            createRow(
                Icons.favorite, mainColor, "Favourites",showFavouritesPage),
            const Divider(),

            //  createRow(Icons.help_outline, redColor, "Support/Help",showMyEventsPage),
          ],
        ));
  }

  Widget createRow(IconData icon, Color color, String text,
      Function(BuildContext context) v) {
    return InkWell(
      onTap: () {
        v(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 10),
            Text(text),
            const Spacer(),
            Icon(Icons.arrow_forward, color: color),
          ],
        ),
      ),
    );
  }
}
