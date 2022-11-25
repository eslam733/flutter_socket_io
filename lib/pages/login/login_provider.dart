import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_socket_io/common/common.dart';
import 'package:flutter_socket_io/pages/chat/chat_screen.dart';
import 'package:toast/toast.dart';

class LoginProvider extends ChangeNotifier {
  final name = TextEditingController();


  submitClick(context) {
    if(name.text.trim() == '' ) {
      SnackBarHelper.showMySnakebar(context, 'Please enter your name');
      return;
    }

    customPushNavigator(context, ChatScreen(name: name.text));
  }
}