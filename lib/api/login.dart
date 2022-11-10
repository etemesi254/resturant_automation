import 'package:hive/hive.dart';
import 'package:resturant_automation/api/constants.dart';
import 'package:resturant_automation/api/get_menus.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:resturant_automation/functions/misc.dart';
import 'package:resturant_automation/models/orders.dart';
import 'package:resturant_automation/navigators/screens.dart';

Map<String, String> generateHeadersWithToken(String token) {
  return {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}

Future<void> login(String email, String password) async {
  var payload = {
    "email": email,
    "password": password,
  };

  var response =
      await http.post(Uri.parse(BASE_URL + LOGIN_ROUTE), body: payload);

  var jsonDecoded = jsonDecode(response.body);
  if (jsonDecoded["status"] != 200) {
    showNotification(jsonDecoded["description"]);
    return;
  }
  // store token
  var box = Hive.box("account");
  // WOOOW...
  box.put("account_token", jsonDecoded["token"]);
  // retrieve the other details

  var userDetails = await http.get(Uri.parse(BASE_URL + USER_ROUTE),
      headers: generateHeadersWithToken(jsonDecoded["token"]));

  var details = jsonDecode(userDetails.body);

  box.put("username", details["username"]);
  box.put("fullname", details["fullname"]);

  box.put("email", details["email"]);
  box.put("mobile", details["telephone"]);

  box.put("logged_in", true);

  showNotification("Successfully logged in");
}

Future<void> makeOrder(
    int productId, int quantity, String description, String token) async {
  Map<String, String> payload = {
    "product_id": productId.toString(),
    "quantity": quantity.toString(),
    "description": description,
  };

  var headers = generateHeadersWithToken(token);

  var resp = await http.post(Uri.parse(BASE_URL + ORDER_ROUTE),
      headers: headers, body: jsonEncode(payload));

  // decode response as json
  var respDecode = jsonDecode(resp.body);

  //
  if (respDecode["status"] != 200) {
    showNotification(respDecode["description"]);
    throw Exception(respDecode["description"]);
  }
  showNotification("Succesfully made your order");
}

Future<List<Orders>> getOrders(String token) async {
  var headers = generateHeadersWithToken(token);

  var resp =
      await http.get(Uri.parse(BASE_URL + GET_ORDERS), headers: headers);

  // decode response as json
  var respDecode = jsonDecode(resp.body);
  List<Orders> orders = [];

  for (var order in respDecode) {
    orders.add(Orders.fromJson(order));
  }
  return orders;
}
