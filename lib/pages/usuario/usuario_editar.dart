import 'dart:typed_data';

import 'package:egresadoapp/api/endpoints/api_idioma.dart';
import 'package:egresadoapp/api/endpoints/api_skills.dart';
import 'package:egresadoapp/api/endpoints/api_usuario.dart';
import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/pages/ofertas/oferta_crear.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/loading.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/utils/validators.dart';
import 'package:egresadoapp/widgets/bring_in_widgets/fade_in_wrapper.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/images/avatar_image.dart';
import 'package:egresadoapp/widgets/input/muiinput.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/loading/loading.dart';
import 'package:egresadoapp/widgets/muiicon/muiicon.dart';
import 'package:egresadoapp/widgets/muiselect/muiselect.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:egresadoapp/widgets/tupla/tupla.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UsuarioEditar extends StatefulWidget {
  const UsuarioEditar({Key? key}) : super(key: key);

  @override
  State<UsuarioEditar> createState() => _UsuarioEditarState();
}

class _UsuarioEditarState extends State<UsuarioEditar> {
  @override
  Widget build(BuildContext context) {
    return MuiScreen(
      child: Consumer<UsuarioProvider>(
        builder: (context, provider, child) {
          User? usuario = provider.user;
          if (usuario == null) {
            return const Text("No hay usuario");
          }
          List<String> skills = [];
          List<String> idiomas = [];

          return FutureBuilder(
              future: Future.wait([
                ApiSkills.fetchSkills().then((lista) {
                  skills = lista;
                }),
                ApiIdioma.fetchIdiomas().then((lista) {
                  idiomas = lista;
                })
              ]),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingPage();
                }
                return FadeInWrapper(
                    index: 2,
                    child: _UsuarioEditar(
                      skills: skills,
                      idiomas: idiomas,
                    ));
              }));
        },
      ),
    );
  }
}

class _UsuarioEditar extends StatefulWidget {
  final List<String> skills;
  final List<String> idiomas;
  const _UsuarioEditar({Key? key, required this.idiomas, required this.skills})
      : super(key: key);

  @override
  State<_UsuarioEditar> createState() => __UsuarioEditar();
}

class __UsuarioEditar extends State<_UsuarioEditar> {
  XFile? photo;
  late final GlobalKey<FormState> _formKey;
  late User edited;
  late TextEditingController nameController;
  late TextEditingController descripcionController;
  late TextEditingController emailController;
  late TextEditingController telefonoController;
  late TextEditingController estadoController;

  late TextEditingController twitterController;
  late TextEditingController whatsappController;
  late TextEditingController telegramController;
  late TextEditingController linkedinController;
  late TextEditingController githubController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    edited = User.fromCopy(
        Provider.of<UsuarioProvider>(context, listen: false).user!);
    nameController = TextEditingController(text: edited.nombre);
    descripcionController = TextEditingController(text: edited.descripcion);
    telefonoController = TextEditingController(text: edited.telefono);
    emailController = TextEditingController(text: edited.email);
    estadoController = TextEditingController(text: edited.estado);

    twitterController =
        TextEditingController(text: edited.socialLinks?["twitter"]);
    whatsappController =
        TextEditingController(text: edited.socialLinks?["whatsapp"]);
    telegramController =
        TextEditingController(text: edited.socialLinks?["telegram"]);
    linkedinController =
        TextEditingController(text: edited.socialLinks?["linkedin"]);
    githubController =
        TextEditingController(text: edited.socialLinks?["github"]);
  }

  void nextState() {
    setState(() {});
  }

  Future<void> handleSave() async {
    if (_formKey.currentState!.validate()) {
      edited.nombre = nameController.value.text;
      edited.descripcion = descripcionController.value.text;
      edited.telefono = telefonoController.value.text;
      edited.email = emailController.value.text;
      edited.estado = estadoController.value.text;

      Map<String, String> socialLinks = {};
      if (twitterController.value.text.isNotEmpty) {
        socialLinks["twitter"] = twitterController.value.text;
      }
      if (whatsappController.value.text.isNotEmpty) {
        socialLinks["whatsapp"] = whatsappController.value.text;
      }
      if (telegramController.value.text.isNotEmpty) {
        socialLinks["telegram"] = telegramController.value.text;
      }
      if (linkedinController.value.text.isNotEmpty) {
        socialLinks["linkedin"] = linkedinController.value.text;
      }
      if (githubController.value.text.isNotEmpty) {
        socialLinks["github"] = githubController.value.text;
      }

      edited.socialLinks = socialLinks;

      LoadingHandler.showLoading(context);
      String? target;
      try {
        User newUser = await ApiUsuario.edit(edited, photo);
        Provider.of<UsuarioProvider>(context, listen: false).set(newUser);
        target = newUser.id;
      } catch (e) {}
      LoadingHandler.hideLoading(context);

      if (target != null) {
        Navigator.of(context).pushNamed(NavigatorRoutes.userProfile(target));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(edited.avatar);

    return MuiDataScreen(
        pageTitle: "Editando perfil",
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_imgSize / 2),
                  clipBehavior: Clip.hardEdge,
                  child: SizedBox(
                    height: _imgSize,
                    width: _imgSize,
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      fit: StackFit.expand,
                      children: [
                        photo == null
                            ? AvatarImage(
                                url: edited.avatar,
                                customSize: _imgSize,
                              )
                            : FutureBuilder(
                                future: photo!.readAsBytes(),
                                builder: ((context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Loading();
                                  }
                                  return Image.memory(
                                    snapshot.data as Uint8List,
                                    fit: BoxFit.cover,
                                  );
                                })),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3)),
                            child: MuiButton(
                              customInset:
                                  const EdgeInsets.symmetric(vertical: 6),
                              onPressed: () async {
                                // var picked =
                                //     await FilePicker.platform.pickFiles(
                                //   type: FileType.image,
                                //   withData: true,
                                // );
                                XFile? pickedFile = await ImagePicker()
                                    .pickImage(
                                        source: ImageSource.gallery,
                                        maxHeight: 300,
                                        maxWidth: 300);
                                if (pickedFile != null) {
                                  // nextFoto(picked);
                                  setState(() {
                                    photo = pickedFile;
                                  });
                                }
                              },
                              text: "editar",
                              variant: MuiButtonVariant.LIGHT_LINK,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Center(child: RolTag(rol: edited.rol)),
              spacerS,
              MuiInput(
                required: true,
                validator: Validators.validateIsEmpty,
                color: MuiInputColor.DARK,
                controller: nameController,
                label: "Nombre",
              ),
              spacerS,
              MuiInput(
                color: MuiInputColor.DARK,
                controller: descripcionController,
                label: "Descripción",
              ),
              formDivider,
              Row(
                children: [
                  Expanded(
                      child: Text("Perfil público",
                          style:
                              labelStyles.copyWith(color: MuiPalette.BLACK))),
                  Switch(
                      inactiveThumbColor: MuiPalette.GREY,
                      value: edited.publico,
                      onChanged: (v) {
                        edited.publico = v;
                        nextState();
                      })
                ],
              ),
              const Text(
                  "Si tu perfil no es público, los únicos que podrán contactarte a través de la plataforma serán los colaboradores."),
              formDivider,
              MuiSelect(
                label: "Estado",
                required: true,
                transformer: getLabelByEstado,
                validator: Validators.validateIsEmpty,
                hint: "Desactivado, Abierto a colaborar ...",
                values: listaEstados,
                value: edited.estado,
                onChanged: (v) {
                  if (v != null) {
                    estadoController.text = v;
                  }
                },
              ),
              spacerS,
              MuiInput(
                required: true,
                validator: Validators.validateEmail,
                controller: emailController,
                color: MuiInputColor.DARK,
                label: "Email",
              ),
              spacerS,
              MuiInput(
                controller: telefonoController,
                color: MuiInputColor.DARK,
                label: "Teléfono",
              ),
              spacerS,
              const Divider(),
              spacerS,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MuiIcon(
                    icon: MuiIconVariant.linkedin,
                    size: MuiIconSize.m,
                  ),
                  spacerS,
                  Expanded(
                    child: MuiInput(
                      controller: linkedinController,
                      color: MuiInputColor.DARK,
                      label: "Tu perfil en LinkedIn",
                    ),
                  ),
                ],
              ),
              spacerS,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MuiIcon(
                    icon: MuiIconVariant.telegram,
                    size: MuiIconSize.m,
                  ),
                  spacerS,
                  Expanded(
                    child: MuiInput(
                      controller: telegramController,
                      color: MuiInputColor.DARK,
                      label: "Tu número de Telegram",
                    ),
                  ),
                ],
              ),
              spacerS,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MuiIcon(
                    icon: MuiIconVariant.twitter,
                    size: MuiIconSize.m,
                  ),
                  spacerS,
                  Expanded(
                    child: MuiInput(
                      controller: twitterController,
                      color: MuiInputColor.DARK,
                      label: "Tu perfil en Twitter",
                    ),
                  ),
                ],
              ),
              spacerS,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MuiIcon(
                    icon: MuiIconVariant.whatsapp,
                    size: MuiIconSize.m,
                  ),
                  spacerS,
                  Expanded(
                    child: MuiInput(
                      controller: whatsappController,
                      color: MuiInputColor.DARK,
                      label: "Tu número en Whatsapp",
                    ),
                  ),
                ],
              ),
              spacerS,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MuiIcon(
                    icon: MuiIconVariant.github,
                    size: MuiIconSize.m,
                  ),
                  spacerS,
                  Expanded(
                    child: MuiInput(
                      controller: githubController,
                      color: MuiInputColor.DARK,
                      label: "Tu perfil en Github",
                    ),
                  ),
                ],
              ),
              formDivider,
              Align(
                  alignment: Alignment.centerLeft,
                  child: MuiSelectTags(
                    label: "Skills",
                    list: widget.skills,
                    selected: edited.skills,
                    onConfirm: (newList) {
                      edited.skills = newList;
                      nextState();
                    },
                  )),
              spacerS,
              Align(
                  alignment: Alignment.centerLeft,
                  child: MuiSelectTags(
                    label: "Idiomas",
                    list: widget.idiomas,
                    selected: edited.idiomas,
                    onConfirm: (newList) {
                      edited.idiomas = newList;
                      nextState();
                    },
                  )),
              spacerXL,
              MuiButton(onPressed: handleSave, text: "Guardar los cambios"),
              spacerXL,
            ],
          ),
        ));
  }
}

const _imgSize = 200.0;
