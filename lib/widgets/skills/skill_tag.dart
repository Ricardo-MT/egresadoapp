import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/button/styles/muibuttonstyles.dart';
import 'package:flutter/material.dart';

class SkillTag extends StatelessWidget {
  final String skill;
  const SkillTag({Key? key, required this.skill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: semiRoundedShape.borderRadius, color: MuiPalette.BROWN),
      child: Text(
        skill.toUpperCase(),
        style: TextStyle(color: MuiPalette.WHITE, fontWeight: FontWeight.bold),
      ),
    );
  }
}
