import 'package:egresadoapp/api/endpoints/api_ofertas.dart';
import 'package:egresadoapp/api/endpoints/api_skills.dart';
import 'package:egresadoapp/api/models/oferta.dart';
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

class OfertaCrearPage extends StatefulWidget {
  const OfertaCrearPage({Key? key}) : super(key: key);

  @override
  State<OfertaCrearPage> createState() => _OfertaCrearPageState();
}

class _OfertaCrearPageState extends State<OfertaCrearPage> {
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
                OfertaCreating oferta = OfertaCreating(
                  titulo: "",
                  descripcion: "",
                  skillsRequeridos: [],
                  experienciaMinima: "",
                  empleador: "",
                  localizacion: "",
                  presencialidad: "",
                  tipoJornada: "",
                  salario: "",
                );
                return FadeInWrapper(
                    index: 2,
                    child: OfertaCrear(
                      pageTitle: "Creando oferta laboral",
                      skills: skills,
                      ofertaOriginal: oferta,
                      handleSave: (OfertaCreating nuevaOferta) async {
                        LoadingHandler.showLoading(context);
                        String? target;
                        try {
                          Oferta ofertaCreated =
                              await ApiOfertas.create(nuevaOferta);
                          target =
                              NavigatorRoutes.offerDetail(ofertaCreated.id);
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

class OfertaCrear extends StatefulWidget {
  final String pageTitle;
  final List<String> skills;
  final Function(OfertaCreating nuevaOferta) handleSave;
  final OfertaCreating ofertaOriginal;
  const OfertaCrear(
      {Key? key,
      required this.pageTitle,
      required this.skills,
      required this.ofertaOriginal,
      required this.handleSave})
      : super(key: key);

  @override
  State<OfertaCrear> createState() => OfertaCrearInnerState();
}

class OfertaCrearInnerState extends State<OfertaCrear> {
  late final GlobalKey<FormState> _formKey;
  late OfertaCreating oferta;
  late TextEditingController tituloController;
  late TextEditingController descripcionController;

  late TextEditingController localizacionController;
  late TextEditingController empleadorController;
  late TextEditingController salarioController;
  late TextEditingController jornadaController;
  late TextEditingController presencialidadController;
  late TextEditingController experienciaController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();

    oferta = OfertaCreating.fromCopy(widget.ofertaOriginal);

    tituloController = TextEditingController(text: oferta.titulo);
    descripcionController = TextEditingController(text: oferta.descripcion);

    localizacionController = TextEditingController(text: oferta.localizacion);
    empleadorController = TextEditingController(text: oferta.empleador);
    salarioController = TextEditingController(text: oferta.salario);
    jornadaController = TextEditingController(text: oferta.tipoJornada);
    presencialidadController =
        TextEditingController(text: oferta.presencialidad);
    experienciaController =
        TextEditingController(text: oferta.experienciaMinima);
  }

  void nextState() {
    setState(() {});
  }

  handleSave() {
    if (_formKey.currentState!.validate()) {
      oferta.titulo = tituloController.value.text;
      oferta.descripcion = descripcionController.value.text;

      oferta.localizacion = localizacionController.value.text;
      oferta.empleador = empleadorController.value.text;
      oferta.salario = salarioController.value.text;
      oferta.tipoJornada = jornadaController.value.text;
      oferta.presencialidad = presencialidadController.value.text;
      oferta.experienciaMinima = experienciaController.value.text;
      widget.handleSave(oferta);
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
              required: true,
              validator: Validators.validateIsEmpty,
              color: MuiInputColor.DARK,
              controller: tituloController,
              label: "Título",
            ),
            spacerS,
            MuiInput(
              required: true,
              color: MuiInputColor.DARK,
              validator: Validators.validateIsEmpty,
              controller: descripcionController,
              label: "Descripción",
            ),
            formDivider,
            Align(
                alignment: Alignment.centerLeft,
                child: MuiSelectTags(
                  label: "Skills",
                  list: widget.skills,
                  selected: oferta.skillsRequeridos,
                  onConfirm: (newList) {
                    oferta.skillsRequeridos = newList;
                    nextState();
                  },
                )),
            spacerS,
            MuiInput(
              required: true,
              validator: Validators.validateIsEmpty,
              color: MuiInputColor.DARK,
              controller: experienciaController,
              label: "Experiencia mínima",
            ),
            formDivider,
            MuiInput(
              required: true,
              color: MuiInputColor.DARK,
              validator: Validators.validateIsEmpty,
              controller: empleadorController,
              label: "Empleador",
            ),
            spacerS,
            MuiInput(
              required: true,
              validator: Validators.validateIsEmpty,
              color: MuiInputColor.DARK,
              controller: localizacionController,
              label: "Localización",
            ),
            spacerS,
            MuiSelect(
              label: "Presencialidad",
              required: true,
              transformer: getLabelByPresencialidad,
              validator: Validators.validateIsEmpty,
              hint: "Presencial, Teletrabajo ...",
              values: listaPresencialidad,
              value:
                  oferta.presencialidad.isEmpty ? null : oferta.presencialidad,
              onChanged: (v) {
                if (v != null) {
                  presencialidadController.text = v;
                }
              },
            ),
            spacerS,
            MuiSelect(
              label: "Tipo de jornada",
              required: true,
              transformer: getLabelByTipoJornada,
              validator: Validators.validateIsEmpty,
              hint: "Completa/Partida",
              values: listaJornadas,
              value: oferta.tipoJornada.isEmpty ? null : oferta.tipoJornada,
              onChanged: (v) {
                if (v != null) {
                  jornadaController.text = v;
                }
              },
            ),
            spacerS,
            MuiInput(
              required: true,
              validator: Validators.validateIsEmpty,
              color: MuiInputColor.DARK,
              controller: salarioController,
              label: "Salario",
            ),
            formDivider,
            MuiButton(onPressed: handleSave, text: "Guardar los cambios"),
            spacerXL,
          ],
        ),
      ),
    );
  }
}

const formDivider = Padding(
  padding: EdgeInsets.symmetric(vertical: 12),
  child: Divider(),
);
