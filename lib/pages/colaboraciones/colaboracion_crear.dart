import 'package:egresadoapp/api/endpoints/api_colaboracion.dart';
import 'package:egresadoapp/api/endpoints/api_skills.dart';
import 'package:egresadoapp/api/models/colaboracion.dart';
import 'package:egresadoapp/pages/ofertas/oferta_crear.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/loading.dart';
import 'package:egresadoapp/utils/validators.dart';
import 'package:egresadoapp/widgets/bring_in_widgets/fade_in_wrapper.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/input/muiinput.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/loading/loading.dart';
import 'package:egresadoapp/widgets/muiselect/muiselect.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColaboracionCrearPage extends StatefulWidget {
  const ColaboracionCrearPage({Key? key}) : super(key: key);

  @override
  State<ColaboracionCrearPage> createState() => _ColaboracionCrearPageState();
}

class _ColaboracionCrearPageState extends State<ColaboracionCrearPage> {
  @override
  Widget build(BuildContext context) {
    return MuiScreen(
      child: Consumer<UsuarioProvider>(
        builder: (context, provider, child) {
          List<String> skills = [];
          return FutureBuilder(
              future: Future.wait([
                ApiSkills.fetchSkills().then((lista) {
                  skills = lista;
                }),
              ]),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingPage();
                }
                ColaboracionCreating colaboracion = ColaboracionCreating(
                    titulo: "",
                    descripcion: "",
                    skillsRequeridos: [],
                    contacto: "");
                return FadeInWrapper(
                    index: 2,
                    child: ColaboracionCrear(
                      pageTitle: "Creando colaboración",
                      skills: skills,
                      colaboracionOriginal: colaboracion,
                      handleSave:
                          (ColaboracionCreating nuevaColaboracion) async {
                        LoadingHandler.showLoading(context);
                        String? target;
                        try {
                          Colaboracion colaboracionCreated =
                              await ApiColaboracion.create(nuevaColaboracion);
                          target = NavigatorRoutes.collaborationDetail(
                              colaboracionCreated.id);
                        } catch (e) {}
                        LoadingHandler.hideLoading(context);
                        if (target != null) {
                          Navigator.of(context).pushReplacementNamed(target);
                        }
                      },
                    ));
              }));
        },
      ),
    );
  }
}

class ColaboracionCrear extends StatefulWidget {
  final String pageTitle;
  final List<String> skills;
  final Function(ColaboracionCreating nuevaColaboracion) handleSave;
  final ColaboracionCreating colaboracionOriginal;
  const ColaboracionCrear(
      {Key? key,
      required this.skills,
      required this.handleSave,
      required this.colaboracionOriginal,
      required this.pageTitle})
      : super(key: key);

  @override
  State<ColaboracionCrear> createState() => ColaboracionCrearInnerState();
}

class ColaboracionCrearInnerState extends State<ColaboracionCrear> {
  late final _formKey;
  late ColaboracionCreating colaboracion;
  late TextEditingController tituloController;
  late TextEditingController descripcionController;

  late TextEditingController contactoController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    colaboracion = ColaboracionCreating.fromCopy(widget.colaboracionOriginal);
    tituloController = TextEditingController(text: colaboracion.titulo);
    descripcionController =
        TextEditingController(text: colaboracion.descripcion);

    contactoController = TextEditingController(text: colaboracion.contacto);
  }

  void nextState() {
    setState(() {});
  }

  Future<void> handleSave() async {
    if (_formKey.currentState!.validate()) {
      colaboracion.titulo = tituloController.value.text;
      colaboracion.descripcion = descripcionController.value.text;
      colaboracion.contacto = contactoController.value.text;

      widget.handleSave(colaboracion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MuiDataScreen(
      pageTitle: widget.pageTitle,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            MuiInput(
              validator: Validators.validateIsEmpty,
              color: MuiInputColor.DARK,
              controller: tituloController,
              label: "Título",
            ),
            spacerS,
            MuiInput(
              color: MuiInputColor.DARK,
              validator: Validators.validateIsEmpty,
              controller: descripcionController,
              label: "Descripción",
            ),
            spacerS,
            const Divider(),
            spacerS,
            Align(
                alignment: Alignment.centerLeft,
                child: MuiSelectTags(
                  label: "Skills",
                  list: widget.skills,
                  selected: colaboracion.skillsRequeridos,
                  onConfirm: (newList) {
                    colaboracion.skillsRequeridos = newList;
                    nextState();
                  },
                )),
            formDivider,
            MuiInput(
              color: MuiInputColor.DARK,
              validator: Validators.validateIsEmpty,
              controller: contactoController,
              label: "Contacto",
            ),
            spacerXL,
            MuiButton(onPressed: handleSave, text: "Guardar cambios"),
            spacerXL,
          ],
        ),
      ),
    );
  }
}
