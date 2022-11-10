import 'package:flutter/material.dart';

Widget createAction(IconData icon, Color color, BuildContext context,
    ) {
  return InkWell(
    onTap: () {
      //func(context);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
        size: 25,
        color: color,
      ),
    ),
  );
}

AppBar homePageAppBar(BuildContext context) {

  return AppBar(
  
    //backgroundColor: appBarColor,
    // title: createAppBarImage(""),
    elevation: 1,
    toolbarHeight: 60,
    actions: [
      createAction(Icons.search_rounded, Colors.red, context),
      const SizedBox(width: 10),
      createAction(
          Icons.notifications_none_rounded, Colors.red, context),
      const SizedBox(width: 15)
    ],
  );
}