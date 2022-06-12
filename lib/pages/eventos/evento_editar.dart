import 'package:egresadoapp/api/endpoints/api_eventos.dart';
import 'package:egresadoapp/api/endpoints/api_skills.dart';
import 'package:egresadoapp/api/models/evento.dart';
import 'package:egresadoapp/pages/eventos/evento_crear.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/loading.dart';
import 'package:egresadoapp/widgets/bring_in_widgets/fade_in_wrapper.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventoEditarPage extends StatefulWidget {
  final Evento original;
  const EventoEditarPage({Key? key, required this.original}) : super(key: key);

  @override
  State<EventoEditarPage> createState() => _EventoEditarPageState();
}

class _EventoEditarPageState extends State<EventoEditarPage> {
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
                EventoEditing evento =
                    EventoEditing.fromJson(widget.original.toJson());
                return FadeInWrapper(
                    index: 2,
                    child: EventoCrear(
                      pageTitle: "Editando evento",
                      skills: skills,
                      eventoOriginal: EventoCreating.fromJson(evento.toJson()),
                      handleSave: (EventoCreating nuevaOferta) async {
                        LoadingHandler.showLoading(context);
                        String? target;
                        try {
                          Evento eventoCreated = await ApiEventos.edit(
                              EventoEditing.fromJson({
                            ...evento.toJson(),
                            ...nuevaOferta.toJson()
                          }));
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
