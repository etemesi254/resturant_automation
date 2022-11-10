
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:resturant_automation/constants.dart';

void showNotification(String string){
  showSimpleNotification(
          Text(string,
              style: const TextStyle(color: Colors.white,fontSize: 15)),
              contentPadding: const EdgeInsets.symmetric(vertical: 6,horizontal:4),
          background: mainColor,
          slideDismissDirection: DismissDirection.horizontal);

}