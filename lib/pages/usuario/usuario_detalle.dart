import 'package:egresadoapp/api/endpoints/api_auth.dart';
import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/deeplinking.dart';
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/utils/permissions.dart';
import 'package:egresadoapp/widgets/ask_for_permission_widgets/conditional_widget.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/emptylist/emptylist.dart';
import 'package:egresadoapp/widgets/images/avatar_image.dart';
import 'package:egresadoapp/widgets/input/muiinput.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/modals/confirmationmodal.dart';
import 'package:egresadoapp/widgets/muicard/muicard.dart';
import 'package:egresadoapp/widgets/muiicon/muiicon.dart';
import 'package:egresadoapp/widgets/skills/skill_tag.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:egresadoapp/widgets/tupla/tupla.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          padding: const EdgeInsets.all(Dimensions.pageInsetGap),
          child: Center(
              child: Column(
            children: [
              Consumer<UsuarioProvider>(
                builder: (context, provider, child) {
                  User? myUsuario = provider.user;
                  bool visible =
                      myUsuario != null && myUsuario.id == usuario.id;
                  return ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: visible
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MuiButton(
                                  variant: MuiButtonVariant.LINK,
                                  onPressed: () async {
                                    bool? res = await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const ConfirmationModal(
                                            title: "Cerrando sesión",
                                            text:
                                                "Estás a punto de cerrar sesión. ¿Continuar?",
                                          );
                                        });
                                    if (res == true) {
                                      try {
                                        await ApiAuth.logout();
                                      } catch (e) {}
                                      Navigator.of(context)
                                          .pushReplacementNamed(Routes.home);
                                      Provider.of<UsuarioProvider>(context,
                                              listen: false)
                                          .set(null);
                                    }
                                  },
                                  text: "Cerrar sesión"),
                              IconButton(
                                tooltip: "Editar perfil",
                                icon: Icon(
                                  Icons.border_color,
                                  color: MuiPalette.BROWN,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      NavigatorRoutes.userProfileEdit(
                                          myUsuario.id));
                                },
                              ),
                            ],
                          )
                        : const MuiPageTitle(label: "Usuario"),
                  );
                },
              ),
              MuiCard(
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
                            child: AvatarImage(
                              customSize: 200,
                              url: usuario.avatar,
                            ),
                          ),
                          Center(
                            child: SelectableText.rich(TextSpan(
                                text: splitted[0] + " ",
                                style: firstCellStyles,
                                children: [
                                  TextSpan(
                                      text: splitted.length > 1
                                          ? splitted[1]
                                          : "",
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
                                      usuario.socialLinks!["linkedin"] != null,
                                  child: IconButton(
                                      onPressed: () {
                                        openExternally(
                                            usuario.socialLinks!["linkedin"]!);
                                      },
                                      icon: const MuiIcon(
                                          icon: MuiIconVariant.linkedin)),
                                ),
                                Visibility(
                                  visible: usuario.socialLinks != null &&
                                      usuario.socialLinks!["telegram"] != null,
                                  child: IconButton(
                                      onPressed: () {
                                        openExternally(
                                            usuario.socialLinks!["telegram"]!);
                                      },
                                      icon: const MuiIcon(
                                          icon: MuiIconVariant.telegram)),
                                ),
                                Visibility(
                                  visible: usuario.socialLinks != null &&
                                      usuario.socialLinks!["twitter"] != null,
                                  child: IconButton(
                                      onPressed: () {
                                        openExternally(
                                            usuario.socialLinks!["twitter"]!);
                                      },
                                      icon: const MuiIcon(
                                          icon: MuiIconVariant.twitter)),
                                ),
                                Visibility(
                                  visible: usuario.socialLinks != null &&
                                      usuario.socialLinks!["whatsapp"] != null,
                                  child: IconButton(
                                      onPressed: () {
                                        openExternally(
                                            usuario.socialLinks!["whatsapp"]!);
                                      },
                                      icon: const MuiIcon(
                                          icon: MuiIconVariant.whatsapp)),
                                ),
                                Visibility(
                                  visible: usuario.socialLinks != null &&
                                      usuario.socialLinks!["github"] != null,
                                  child: IconButton(
                                      onPressed: () {
                                        openExternally(
                                            usuario.socialLinks!["github"]!);
                                      },
                                      icon: const MuiIcon(
                                          icon: MuiIconVariant.github)),
                                ),
                              ],
                            ),
                          ),
                          spacerXL,
                          Tupla(
                            icon: Icons.email,
                            textOverflow: TextOverflow.visible,
                            text: usuario.email,
                            size: MuiTuplaSize.m,
                          ),
                          spacerS,
                          Tupla(
                            icon: Icons.phone,
                            textOverflow: TextOverflow.visible,
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
                                : Wrap(spacing: 20, runSpacing: 10, children: [
                                    for (var i = 0;
                                        i < usuario.skills.length;
                                        i++)
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
                                : Wrap(spacing: 20, runSpacing: 10, children: [
                                    for (var i = 0;
                                        i < usuario.idiomas.length;
                                        i++)
                                      SkillTag(skill: usuario.idiomas[i])
                                  ]),
                          ),
                          spacerXL
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              spacerS,
              MuiConditionalWidget(
                  permision: puedeEditarRol(context),
                  child: Center(
                    child: MuiButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(NavigatorRoutes.userRolEdit(usuario.id));
                      },
                      text: 'Editar rol',
                    ),
                  ))
            ],
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
