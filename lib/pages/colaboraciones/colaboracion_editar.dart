import 'package:egresadoapp/api/endpoints/api_colaboracion.dart';
import 'package:egresadoapp/api/endpoints/api_skills.dart';
import 'package:egresadoapp/api/models/colaboracion.dart';
import 'package:egresadoapp/pages/colaboraciones/colaboracion_crear.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/loading.dart';
import 'package:egresadoapp/widgets/bring_in_widgets/fade_in_wrapper.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColaboracionEditarPage extends StatefulWidget {
  final Colaboracion original;
  const ColaboracionEditarPage({Key? key, required this.original})
      : super(key: key);

  @override
  State<ColaboracionEditarPage> createState() => _ColaboracionEditarPageState();
}

class _ColaboracionEditarPageState extends State<ColaboracionEditarPage> {
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
                ColaboracionEditing colaboracion =
                    ColaboracionEditing.fromJson(widget.original.toJson());
                return FadeInWrapper(
                    index: 2,
                    child: ColaboracionCrear(
                      pageTitle: "Editando colaboración",
                      skills: skills,
                      colaboracionOriginal:
                          ColaboracionCreating.fromJson(colaboracion.toJson()),
                      handleSave:
                          (ColaboracionCreating nuevaColaboracion) async {
                        LoadingHandler.showLoading(context);
                        String? target;
                        try {
                          Colaboracion ofertaCreated =
                              await ApiColaboracion.edit(
                                  ColaboracionEditing.fromJson({
                            ...colaboracion.toJson(),
                            ...nuevaColaboracion.toJson()
                          }));
                          target = NavigatorRoutes.collaborationDetail(
                              ofertaCreated.id);
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
