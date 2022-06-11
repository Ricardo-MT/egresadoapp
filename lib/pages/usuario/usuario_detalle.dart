import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/emptylist/emptylist.dart';
import 'package:egresadoapp/widgets/input/muiinput.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/muicard/muicard.dart';
import 'package:egresadoapp/widgets/muiicon/muiicon.dart';
import 'package:egresadoapp/widgets/skills/skill_tag.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:egresadoapp/widgets/tupla/tupla.dart';
import 'package:flutter/material.dart';

class UsuarioDetalle extends StatelessWidget {
  final User usuario;
  const UsuarioDetalle({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> splitted = usuario.nombre.split(" ");
    return MuiScreen(
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.pageInsetGap),
          child: Center(
              child: MuiCard(
            width: 700,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.account_circle_rounded,
                          size: 200,
                          color: MuiPalette.BROWN,
                        ),
                      ),
                      Center(
                        child: SelectableText.rich(TextSpan(
                            text: splitted[0] + " ",
                            style: firstCellStyles,
                            children: [
                              TextSpan(
                                  text: splitted.length > 1 ? splitted[1] : "",
                                  style: firstCellStyles.copyWith(
                                      fontWeight: FontWeight.normal))
                            ])),
                      ),
                      spacerS,
                      Center(child: RolTag(rol: usuario.rol)),
                      spacerS,
                      Center(child: EstadoTag(estado: usuario.estado)),
                      spacerS,
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Visibility(
                              visible: usuario.socialLinks != null &&
                                  usuario.socialLinks!["discord"] != null,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const MuiIcon(
                                      icon: MuiIconVariant.discord)),
                            ),
                            Visibility(
                              visible: usuario.socialLinks != null &&
                                  usuario.socialLinks!["linkedin"] != null,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const MuiIcon(
                                      icon: MuiIconVariant.linkedin)),
                            ),
                            Visibility(
                              visible: usuario.socialLinks != null &&
                                  usuario.socialLinks!["telegram"] != null,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const MuiIcon(
                                      icon: MuiIconVariant.telegram)),
                            ),
                            Visibility(
                              visible: usuario.socialLinks != null &&
                                  usuario.socialLinks!["twitter"] != null,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const MuiIcon(
                                      icon: MuiIconVariant.twitter)),
                            ),
                            Visibility(
                              visible: usuario.socialLinks != null &&
                                  usuario.socialLinks!["whatsapp"] != null,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const MuiIcon(
                                      icon: MuiIconVariant.whatsapp)),
                            ),
                            Visibility(
                              visible: usuario.socialLinks != null &&
                                  usuario.socialLinks!["github"] != null,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const MuiIcon(
                                      icon: MuiIconVariant.github)),
                            ),
                          ],
                        ),
                      ),
                      spacerXL,
                      Tupla(
                        icon: Icons.email,
                        text: usuario.email,
                        size: MuiTuplaSize.m,
                      ),
                      spacerS,
                      Tupla(
                        icon: Icons.phone,
                        text: usuario.telefono ?? "-",
                        size: MuiTuplaSize.m,
                      ),
                      spacerXL,
                      MuiLabeledText(
                          label: "Descripción",
                          text: usuario.descripcion ?? "-"),
                      spacerS,
                      const Divider(),
                      MuiLabeledText(
                        label: "Skills",
                        text: "",
                        child: usuario.skills.isEmpty
                            ? const EmptyList()
                            : Wrap(spacing: 20, children: [
                                for (var i = 0; i < usuario.skills.length; i++)
                                  SkillTag(skill: usuario.skills[i])
                              ]),
                      ),
                      spacerS,
                      const Divider(),
                      MuiLabeledText(
                        label: "Idiomas",
                        text: "",
                        child: usuario.idiomas.isEmpty
                            ? const EmptyList()
                            : Wrap(spacing: 20, children: [
                                for (var i = 0; i < usuario.idiomas.length; i++)
                                  SkillTag(skill: usuario.skills[i])
                              ]),
                      ),
                      spacerXL
                    ],
                  ),
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}

final firstCellStyles = TextStyle(
    fontSize: Dimensions.cardTitleFontSize + 4,
    color: MuiPalette.BLACK,
    fontWeight: FontWeight.bold);
