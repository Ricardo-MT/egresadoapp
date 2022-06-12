import 'package:egresadoapp/api/endpoints/api_ofertas.dart';
import 'package:egresadoapp/api/endpoints/api_skills.dart';
import 'package:egresadoapp/api/models/oferta.dart';
import 'package:egresadoapp/pages/ofertas/oferta_crear.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/loading.dart';
import 'package:egresadoapp/widgets/bring_in_widgets/fade_in_wrapper.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfertaEditarPage extends StatefulWidget {
  final Oferta original;
  const OfertaEditarPage({Key? key, required this.original}) : super(key: key);

  @override
  State<OfertaEditarPage> createState() => _OfertaEditarPageState();
}

class _OfertaEditarPageState extends State<OfertaEditarPage> {
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
                OfertaEditing oferta =
                    OfertaEditing.fromJson(widget.original.toJson());
                return FadeInWrapper(
                    index: 2,
                    child: OfertaCrear(
                      pageTitle: "Editando oferta laboral",
                      skills: skills,
                      ofertaOriginal: OfertaCreating.fromJson(oferta.toJson()),
                      handleSave: (OfertaCreating nuevaOferta) async {
                        LoadingHandler.showLoading(context);
                        String? target;
                        try {
                          Oferta ofertaCreated = await ApiOfertas.edit(
                              OfertaEditing.fromJson({
                            ...oferta.toJson(),
                            ...nuevaOferta.toJson()
                          }));
                          target =
                              NavigatorRoutes.offerDetail(ofertaCreated.id);
                        } catch (e) {}
                        LoadingHandler.hideLoading(context);
                        if (target != null) {
                          Navigator.of(context).pushReplacementNamed(target);
                        }
                        // NAVEGAR AL TARGET
                      },
                    ));
              }));
        },
      ),
    );
  }
}
