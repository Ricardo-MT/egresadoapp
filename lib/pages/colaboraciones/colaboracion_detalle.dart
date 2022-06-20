import 'package:egresadoapp/api/endpoints/api_colaboracion.dart';
import 'package:egresadoapp/api/models/colaboracion.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/converters.dart';
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/utils/permissions.dart';
import 'package:egresadoapp/widgets/ask_for_permission_widgets/conditional_widget.dart';
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
                              tooltip: "Eliminar colaboración",
                              icon: Icon(
                                Icons.delete,
                                color: MuiPalette.BROWN,
                              ),
                              onPressed: () async {
                                bool? res = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const ConfirmationModal(
                                        title: "Eliminando colaboración",
                                        text:
                                            "Estás a punto de eliminar esta colaboración. ¿Continuar?",
                                      );
                                    });
                                if (res == true) {
                                  try {
                                    Navigator.of(context).pushReplacementNamed(
                                        Routes.collaboration);
                                    await ApiColaboracion.delete(colaboracion);
                                  } catch (e) {}
                                }
                              },
                            ),
                            permision: puedeEliminarColaboracion(context)),
                        spacerExpanded,
                        const MuiPageTitle(label: "Colaboración"),
                        spacerExpanded,
                        MuiConditionalWidget(
                            child: IconButton(
                              tooltip: "Editar colaboración",
                              icon: Icon(
                                Icons.border_color,
                                color: MuiPalette.BROWN,
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    NavigatorRoutes.collaborationEdit(
                                        colaboracion.id));
                              },
                            ),
                            permision: puedeEditarColaboracion(context))
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
                                colaboracion.titulo,
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
                                        colaboracion.autor.id));
                              },
                              child: TuplaImage(
                                  url: colaboracion.autor.avatar,
                                  selectable: false,
                                  expandable: true,
                                  textOverflow: TextOverflow.visible,
                                  withHero: true,
                                  text: colaboracion.autor.nombre),
                            ),
                            spacerS,
                            Tupla(
                                icon: Icons.calendar_today_rounded,
                                textOverflow: TextOverflow.ellipsis,
                                text: formatUnixDateToString(
                                    colaboracion.fechaPublicacion)),
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
                                  : Wrap(
                                      spacing: 20,
                                      runSpacing: 10,
                                      children: [
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
                  ))
            ],
          )),
        ),
      ),
    );
  }
}
