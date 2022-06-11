import 'package:egresadoapp/api/models/colaboracion.dart';
import 'package:egresadoapp/utils/converters.dart';
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/widgets/emptylist/emptylist.dart';
import 'package:egresadoapp/widgets/input/muiinput.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/muicard/muicard.dart';
import 'package:egresadoapp/widgets/skills/skill_tag.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:egresadoapp/widgets/tupla/tupla.dart';
import 'package:flutter/material.dart';

class ColaboracionDetalle extends StatelessWidget {
  Colaboracion colaboracion;
  ColaboracionDetalle({Key? key, required this.colaboracion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      padding: const EdgeInsets.all(8),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SelectableText(
                                colaboracion.titulo,
                                style: defaultCardTitleStyle,
                              ),
                            ),
                            spacerS,
                            const Divider(),
                            spacerS,
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Tupla(
                                        icon: Icons.person,
                                        text: colaboracion.autor.nombre),
                                  ],
                                ),
                                Tupla(
                                    icon: Icons.calendar_today_rounded,
                                    text: formatUnixDateToString(
                                        colaboracion.fechaPublicacion)),
                              ],
                            ),
                            spacerS,
                            const Divider(),
                            spacerS,
                            MuiLabeledText(
                                label: "Descripción",
                                text: colaboracion.descripcion),
                            spacerS,
                            MuiLabeledText(
                              label: "Skills",
                              text: "",
                              child: colaboracion.skillsRequeridos.isEmpty
                                  ? const EmptyList()
                                  : Wrap(spacing: 20, children: [
                                      for (var i = 0;
                                          i <
                                              colaboracion
                                                  .skillsRequeridos.length;
                                          i++)
                                        SkillTag(
                                            skill: colaboracion
                                                .skillsRequeridos[i])
                                    ]),
                            ),
                            spacerS,
                            const Divider(),
                            spacerS,
                            MuiLabeledText(
                                label: "Contacto", text: colaboracion.contacto),
                            spacerXL
                          ],
                        ),
                      ),
                    ),
                  ))),
        ),
      ),
    );
  }
}
