import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:resturant_automation/api/constants.dart';
import 'package:resturant_automation/globals.dart';

import '../models/menu.dart';

Future<http.Response> fetch(String url) async {
  return http.get(Uri.parse(url));
}

Future<List<Menu>> getMenus() async {
  var response = await fetch(BASE_URL + MENUS);
  List<Menu> menuList = [];

  //TODO, return this.
  var jsonDecoded = jsonDecode(response.body);

  for (var menu in jsonDecoded["data"]) {
    menuList.add(Menu.fromJson(menu));
  }
  globalMenus = menuList;

  return menuList;
}


