import 'package:flutter/material.dart';

class CookiesPage extends StatelessWidget {
  const CookiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/cookies.png"),
                fit: BoxFit.cover)),
        child: Container(),
      ),
    );
  }
}
