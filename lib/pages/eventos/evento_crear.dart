import 'package:egresadoapp/api/endpoints/api_skills.dart';
import 'package:egresadoapp/providers/user_provider.dart';
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

class EventoCrear extends StatelessWidget {
  const EventoCrear({Key? key}) : super(key: key);

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
                return FadeInWrapper(
                    index: 2,
                    child: _EventoCrear(
                      skills: skills,
                    ));
              }));
        },
      ),
    );
  }
}

class _EventoCrear extends StatefulWidget {
  final List<String> skills;
  const _EventoCrear({Key? key, required this.skills}) : super(key: key);

  @override
  State<_EventoCrear> createState() => _EventoCrearInnerState();
}

class _EventoCrearInnerState extends State<_EventoCrear> {
  late final _formKey;
  late TextEditingController tituloController;
  late TextEditingController descripcionController;
  late TextEditingController presencialidadController;
  late TextEditingController localizacionController;
  late TextEditingController empleadorController;
  late TextEditingController expController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    tituloController = TextEditingController();
    descripcionController = TextEditingController();
    presencialidadController = TextEditingController();
    localizacionController = TextEditingController();
    empleadorController = TextEditingController();
    expController = TextEditingController();
  }

  void nextState() {
    setState(() {});
  }

  Future<void> handleSave() async {
    if (_formKey.currentState!.validate()) {
      LoadingHandler.showLoading(context);
      String? target;
      try {
        // API CALL, ACTUALIZAR TARGET
        target = "";
      } catch (e) {}
      LoadingHandler.hideLoading(context);

      // NAVEGAR AL TARGET
    }
  }

  @override
  Widget build(BuildContext context) {
    return MuiDataScreen(
      pageTitle: "Creando evento",
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
                  selected: const [],
                  onConfirm: (newList) {
                    // ACTUALIZAR LISTA
                    nextState();
                  },
                )),
            spacerS,
            const Divider(),
            spacerS,
            MuiInput(
              validator: Validators.validateIsEmpty,
              color: MuiInputColor.DARK,
              controller: tituloController,
              label: "Localización",
            ),
            spacerS,
            MuiInput(
              color: MuiInputColor.DARK,
              validator: Validators.validateIsEmpty,
              controller: descripcionController,
              label: "Empleador",
            ),
            spacerS,
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
            spacerXL,
            MuiButton(onPressed: handleSave, text: "Crear evento"),
            spacerXL,
          ],
        ),
      ),
    );
  }
}
