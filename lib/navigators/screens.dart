import 'package:flutter/material.dart';
import 'package:resturant_automation/models/menu.dart';
import 'package:resturant_automation/screens/account_page.dart';
import 'package:resturant_automation/screens/book_page.dart';
import 'package:resturant_automation/screens/favourites_page.dart';
import 'package:resturant_automation/screens/home_page.dart';
import 'package:resturant_automation/screens/login_page.dart';
import 'package:resturant_automation/screens/single_menu.dart';
import 'package:resturant_automation/screens/view_orders.dart';

void showHomePage(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => HomePage()),
  );
}


void showAccountPage(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => AccountPage()),
  );
}

void showLoginPage(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => LoginScreen()),
  );
}


void showFavouritesPage(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => FavouritesPage()),
  );
}
void showBookingPage(BuildContext context,Menu menu) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => BookPage(menu: menu,)),
  );
}

void showOrdersPage(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => ViewOrdersPage()),
  );
}

void showMenuPage(BuildContext context, Menu menu) {
  Navigator.of(context).push(
    MaterialPageRoute(
        builder: (context) => MenuPage(
              menu: menu,
            )),
  );
}
