import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final screensize = (ui.window.physicalSize / ui.window.devicePixelRatio);

Future<void> customPushNavigator(context, Widget page) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

class SnackBarHelper {
  static void showMySnakebar(BuildContext context, String message,
      {bool warning = false}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black87,
        width: MediaQuery.of(context).size.width * .7,
        content: Text(message, textAlign: TextAlign.center),
        duration: const Duration(seconds: 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }
}
