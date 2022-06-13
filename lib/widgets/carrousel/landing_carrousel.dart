import 'package:egresadoapp/utils/palette.dart';
import 'package:flutter/material.dart';

class CarrouselLanding extends StatelessWidget {
  final String img;
  final String text;
  const CarrouselLanding({Key? key, required this.img, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Container(
              color: MuiPalette.BROWN,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: MuiPalette.WHITE),
              ),
            ),
          )
        ],
      ),
    );
  }
}
