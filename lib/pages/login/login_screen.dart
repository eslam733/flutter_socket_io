import 'package:flutter/material.dart';
import 'package:flutter_socket_io/pages/login/login_provider.dart';
import 'package:provider/provider.dart';

import '../../common/common.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final double w = screensize.width;
    final double h = screensize.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child: SizedBox(
        width: w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'What\'s your name?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            SizedBox(
              width: w * 0.7,
              child: TextField(
                controller: loginProvider.name,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your name',
                ),
              ),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(12)),
              child: TextButton(
                onPressed: () => loginProvider.submitClick(context),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
