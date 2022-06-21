import 'package:egresadoapp/api/endpoints/api_eventos.dart';
import 'package:egresadoapp/api/models/evento.dart';
import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/converters.dart';
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/utils/permissions.dart';
import 'package:egresadoapp/widgets/ask_for_permission_widgets/conditional_widget.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/button/touchable.dart';
import 'package:egresadoapp/widgets/emptylist/emptylist.dart';
import 'package:egresadoapp/widgets/input/muiinput.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/modals/confirmationmodal.dart';
import 'package:egresadoapp/widgets/muicard/muicard.dart';
import 'package:egresadoapp/widgets/skills/skill_tag.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:egresadoapp/widgets/tupla/tupla.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventoDetalle extends StatelessWidget {
  Evento evento;
  EventoDetalle({Key? key, required this.evento}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MuiScreen(
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.pageInsetGap),
          child: Center(
              child: Column(
            children: [
              Consumer<UsuarioProvider>(
                builder: (context, provider, child) {
                  return ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: Row(
                      children: [
                        MuiConditionalWidget(
                            child: IconButton(
                              tooltip: "Eliminar evento",
                              icon: Icon(
                                Icons.delete,
                                color: MuiPalette.BROWN,
                              ),
                              onPressed: () async {
                                bool? res = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const ConfirmationModal(
                                        title: "Eliminando evento",
                                        text:
                                            "Estás a punto de eliminar este evento. ¿Continuar?",
                                      );
                                    });
                                if (res == true) {
                                  try {
                                    await ApiEventos.delete(evento);
                                  } catch (e) {}
                                  Navigator.of(context)
                                      .pushReplacementNamed(Routes.events);
                                }
                              },
                            ),
                            permision: puedeEliminarEvento(context)),
                        spacerExpanded,
                        const MuiPageTitle(label: "Evento"),
                        spacerExpanded,
                        MuiConditionalWidget(
                            child: IconButton(
                              tooltip: "Editar evento",
                              icon: Icon(
                                Icons.border_color,
                                color: MuiPalette.BROWN,
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    NavigatorRoutes.eventEdit(evento.id));
                              },
                            ),
                            permision: puedeEditarEvento(context))
                      ],
                    ),
                  );
                },
              ),
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
                            MuiTouchable(
                              onPress: () {
                                Navigator.of(context).pushNamed(
                                    NavigatorRoutes.userProfile(
                                        evento.autor.id));
                              },
                              child: TuplaImage(
                                  url: evento.autor.avatar,
                                  expandable: true,
                                  selectable: false,
                                  withHero: true,
                                  textOverflow: TextOverflow.visible,
                                  text: evento.autor.nombre),
                            ),
                            spacerS,
                            Tupla(
                                icon: Icons.calendar_today_rounded,
                                textOverflow: TextOverflow.visible,
                                text: formatUnixDateTimeToString(evento.fecha)),
                            spacerS,
                            Tupla(
                                icon: Icons.location_on,
                                textOverflow: TextOverflow.visible,
                                text: evento.localizacion),
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
                                  : Wrap(
                                      spacing: 20,
                                      runSpacing: 10,
                                      children: [
                                          for (var i = 0;
                                              i < evento.skills.length;
                                              i++)
                                            SkillTag(skill: evento.skills[i])
                                        ]),
                            ),
                            spacerS,
                            const Divider(),
                            spacerXL,
                            Consumer<UsuarioProvider>(
                              builder: (context, provider, child) {
                                User? user = provider.user;
                                return Center(
                                  child: user == null
                                      ? MuiButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                NavigatorRoutes.login);
                                          },
                                          text: "Autentifícate para contactar")
                                      : MuiButton(
                                          onPressed: () async {
                                            bool? res = await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return const ConfirmationModal(
                                                    title:
                                                        "Notificar a responsable",
                                                    text:
                                                        "Le enviaremos un email al responsable de este evento comentándole tu interés.",
                                                  );
                                                });
                                            if (res == true) {
                                              try {
                                                await ApiEventos.showInterest(
                                                    evento);
                                              } catch (e) {}
                                            }
                                          },
                                          text: "Contactar"),
                                );
                              },
                            ),
                            spacerXL,
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
