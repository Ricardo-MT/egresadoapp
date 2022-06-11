import 'package:egresadoapp/api/models/oferta.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/converters.dart';
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/widgets/button/touchable.dart';
import 'package:egresadoapp/widgets/emptylist/emptylist.dart';
import 'package:egresadoapp/widgets/input/muiinput.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/muicard/muicard.dart';
import 'package:egresadoapp/widgets/skills/skill_tag.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:egresadoapp/widgets/tupla/tupla.dart';
import 'package:flutter/material.dart';

class OfertaDetalle extends StatelessWidget {
  Oferta oferta;
  OfertaDetalle({Key? key, required this.oferta}) : super(key: key);

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
                                oferta.titulo,
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
                                    MuiTouchable(
                                      onPress: () {
                                        Navigator.of(context).pushNamed(
                                            NavigatorRoutes.userProfile(
                                                oferta.autor.id));
                                      },
                                      child: Tupla(
                                          icon: Icons.person,
                                          selectable: false,
                                          text: oferta.autor.nombre),
                                    ),
                                    Tupla(
                                        icon: Icons.location_on,
                                        text: oferta.localizacion),
                                  ],
                                ),
                                Tupla(
                                    icon: Icons.calendar_today_rounded,
                                    text: formatUnixDateToString(
                                        oferta.fechaPublicacion)),
                              ],
                            ),
                            spacerS,
                            MuiLabeledText(
                                label: "Empleador", text: oferta.empleador),
                            spacerS,
                            MuiLabeledText(
                                label: "Salario", text: oferta.salario),
                            spacerS,
                            MuiLabeledText(
                                label: "Experiencia mínima",
                                text: oferta.experienciaMinima),
                            spacerS,
                            MuiLabeledText(
                                label: "Tipo de jornada",
                                text:
                                    getLabelByTipoJornada(oferta.tipoJornada)),
                            spacerS,
                            MuiLabeledText(
                                label: "Presencialidad",
                                text: getLabelByPresencialidad(
                                    oferta.presencialidad)),
                            spacerS,
                            const Divider(),
                            spacerS,
                            MuiLabeledText(
                                label: "Descripción", text: oferta.descripcion),
                            spacerS,
                            MuiLabeledText(
                              label: "Skills",
                              text: "",
                              child: oferta.skillsRequeridos.isEmpty
                                  ? const EmptyList()
                                  : Wrap(spacing: 20, children: [
                                      for (var i = 0;
                                          i < oferta.skillsRequeridos.length;
                                          i++)
                                        SkillTag(
                                            skill: oferta.skillsRequeridos[i])
                                    ]),
                            ),
                            spacerS,
                            const Divider(),
                            spacerS,
                            MuiLabeledText(
                                label: "Contacto", text: oferta.contacto),
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
