import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnderConstruction extends StatelessWidget {
  const UnderConstruction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "EGRESAD@ - WEB EN CONSTRUCCIÓN",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF72757A)),
            ),
          ),
          Expanded(
              child: Center(
                  child: Lottie.asset('assets/79632-under-maintanance.json'))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset("assets/egresado.png", height: 60),
                Image.asset("assets/powered.png", height: 60),
              ],
            ),
          )
        ],
      ),
    );
  }
}
