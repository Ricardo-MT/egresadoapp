import 'package:egresadoapp/api/endpoints/api_eventos.dart';
import 'package:egresadoapp/api/endpoints/api_skills.dart';
import 'package:egresadoapp/api/models/evento.dart';
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

class EventoCrearPage extends StatelessWidget {
  const EventoCrearPage({Key? key}) : super(key: key);

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
                EventoCreating evento = EventoCreating(
                    titulo: "",
                    descripcion: "",
                    skills: [],
                    fecha: DateTime.now().millisecondsSinceEpoch,
                    localizacion: "");

                return FadeInWrapper(
                    index: 2,
                    child: EventoCrear(
                      pageTitle: "Creando evento",
                      eventoOriginal: evento,
                      skills: skills,
                      handleSave: (EventoCreating nuevoEvento) async {
                        LoadingHandler.showLoading(context);
                        String? target;
                        try {
                          Evento eventoCreated =
                              await ApiEventos.create(nuevoEvento);
                          target =
                              NavigatorRoutes.eventDetail(eventoCreated.id);
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

class EventoCrear extends StatefulWidget {
  final String pageTitle;
  final List<String> skills;
  final Function(EventoCreating nuevoEvento) handleSave;
  final EventoCreating eventoOriginal;
  const EventoCrear(
      {Key? key,
      required this.skills,
      required this.eventoOriginal,
      required this.handleSave,
      required this.pageTitle})
      : super(key: key);

  @override
  State<EventoCrear> createState() => EventoCrearInnerState();
}

class EventoCrearInnerState extends State<EventoCrear> {
  late final GlobalKey<FormState> _formKey;
  late EventoCreating evento;
  late TextEditingController tituloController;
  late TextEditingController descripcionController;

  late TextEditingController localizacionController;
  late TextEditingController hostsController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();

    evento = EventoCreating.fromCopy(widget.eventoOriginal);

    tituloController = TextEditingController(text: evento.titulo);
    descripcionController = TextEditingController(text: evento.descripcion);

    localizacionController = TextEditingController(text: evento.localizacion);
    hostsController = TextEditingController(text: evento.hosts);
  }

  void nextState() {
    setState(() {});
  }

  handleSave() {
    if (_formKey.currentState!.validate()) {
      evento.titulo = tituloController.value.text;
      evento.descripcion = descripcionController.value.text;

      evento.localizacion = localizacionController.value.text;
      evento.hosts = hostsController.value.text;
      widget.handleSave(evento);
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
              color: MuiInputColor.DARK,
              required: true,
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
                  selected: evento.skills,
                  onConfirm: (newList) {
                    evento.skills = newList;
                    nextState();
                  },
                )),
            formDivider,
            MuiInput(
              required: true,
              validator: Validators.validateIsEmpty,
              color: MuiInputColor.DARK,
              controller: localizacionController,
              label: "Localización",
            ),
            spacerS,
            MuiInput(
              required: true,
              color: MuiInputColor.DARK,
              validator: Validators.validateIsEmpty,
              controller: hostsController,
              label: "Organizadores",
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
