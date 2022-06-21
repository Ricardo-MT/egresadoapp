import 'package:egresadoapp/api/endpoints/api_ofertas.dart';
import 'package:egresadoapp/api/models/oferta.dart';
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

class OfertaDetalle extends StatelessWidget {
  Oferta oferta;
  OfertaDetalle({Key? key, required this.oferta}) : super(key: key);

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
                              tooltip: "Eliminar oferta laboral",
                              icon: Icon(
                                Icons.delete,
                                color: MuiPalette.BROWN,
                              ),
                              onPressed: () async {
                                bool? res = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const ConfirmationModal(
                                        title: "Eliminando oferta laboral",
                                        text:
                                            "Estás a punto de eliminar esta oferta laboral. ¿Continuar?",
                                      );
                                    });

                                if (res == true) {
                                  try {
                                    await ApiOfertas.delete(oferta);
                                  } catch (e) {}
                                  Navigator.of(context)
                                      .pushReplacementNamed(Routes.offers);
                                }
                              },
                            ),
                            permision: puedeEliminarOferta(context)),
                        spacerExpanded,
                        const MuiPageTitle(label: "Oferta laboral"),
                        spacerExpanded,
                        MuiConditionalWidget(
                            child: IconButton(
                              tooltip: "Editar oferta laboral",
                              icon: Icon(
                                Icons.border_color,
                                color: MuiPalette.BROWN,
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    NavigatorRoutes.offerEdit(oferta.id));
                              },
                            ),
                            permision: puedeEditarOferta(context))
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
                                oferta.titulo,
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
                                        oferta.autor.id));
                              },
                              child: TuplaImage(
                                  url: oferta.autor.avatar,
                                  expandable: true,
                                  textOverflow: TextOverflow.visible,
                                  selectable: false,
                                  withHero: true,
                                  text: oferta.autor.nombre),
                            ),
                            spacerS,
                            Tupla(
                                icon: Icons.calendar_today_rounded,
                                textOverflow: TextOverflow.visible,
                                text: formatUnixDateToString(
                                    oferta.fechaPublicacion)),
                            spacerS,
                            Tupla(
                                icon: Icons.location_on,
                                textOverflow: TextOverflow.visible,
                                text: oferta.localizacion),
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
                                  : Wrap(
                                      spacing: 20,
                                      runSpacing: 10,
                                      children: [
                                          for (var i = 0;
                                              i <
                                                  oferta
                                                      .skillsRequeridos.length;
                                              i++)
                                            SkillTag(
                                                skill:
                                                    oferta.skillsRequeridos[i])
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
                                                        "Le enviaremos un email al responsable de esta oferta laboral comentándole tu interés.",
                                                  );
                                                });
                                            if (res == true) {
                                              try {
                                                await ApiOfertas.showInterest(
                                                    oferta);
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
