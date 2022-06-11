import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/button/styles/muibuttonstyles.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';

class SkillTag extends StatelessWidget {
  final String skill;
  bool showIcon;
  Function()? onPress;
  SkillTag({Key? key, required this.skill, this.showIcon = false, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPress,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: semiRoundedShape.borderRadius,
              color: MuiPalette.GREEN),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              spacerS,
              Text(
                skill.toUpperCase(),
                style: TextStyle(
                    color: MuiPalette.WHITE, fontWeight: FontWeight.bold),
              ),
              spacerS,
              Visibility(
                visible: showIcon,
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              Visibility(visible: showIcon, child: spacerS)
            ],
          ),
        ),
      ),
    );
  }
}
