import 'package:egresadoapp/api/models/evento.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/converters.dart';
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/button/touchable.dart';
import 'package:egresadoapp/widgets/emptylist/emptylist.dart';
import 'package:egresadoapp/widgets/input/muiinput.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/muicard/muicard.dart';
import 'package:egresadoapp/widgets/skills/skill_tag.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:egresadoapp/widgets/tupla/tupla.dart';
import 'package:flutter/material.dart';

class EventoDetalle extends StatelessWidget {
  Evento evento;
  EventoDetalle({Key? key, required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MuiScreen(
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.pageInsetGap),
          child: Center(
              child: Column(
            children: [
              Text("Evento",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MuiPalette.BLACK,
                      fontSize: 26)),
              spacerS,
              MuiCard(
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
                                evento.titulo,
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
                                                evento.autor.id));
                                      },
                                      child: Tupla(
                                          icon: Icons.person,
                                          selectable: false,
                                          text: evento.autor.nombre),
                                    ),
                                    Tupla(
                                        icon: Icons.location_on,
                                        text: evento.localizacion),
                                  ],
                                ),
                                Tupla(
                                    icon: Icons.calendar_today_rounded,
                                    text: formatUnixDateTimeToString(
                                        evento.fecha)),
                              ],
                            ),
                            spacerS,
                            MuiLabeledText(
                                label: "Organizadores",
                                text: evento.hosts ?? "-"),
                            spacerS,
                            const Divider(),
                            spacerS,
                            MuiLabeledText(
                                label: "Descripción", text: evento.descripcion),
                            spacerS,
                            MuiLabeledText(
                              label: "Skills",
                              text: "",
                              child: evento.skills.isEmpty
                                  ? const EmptyList()
                                  : Wrap(spacing: 20, children: [
                                      for (var i = 0;
                                          i < evento.skills.length;
                                          i++)
                                        SkillTag(skill: evento.skills[i])
                                    ]),
                            ),
                            spacerS,
                            const Divider(),
                            spacerS,
                            MuiLabeledText(
                                label: "Contacto",
                                text: evento.contacto ?? "-"),
                            spacerXL
                          ],
                        ),
                      ),
                    ),
                  ))
            ],
          )),
        ),
      ),
    );
  }
}
