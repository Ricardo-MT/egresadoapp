import 'package:egresadoapp/api/endpoints/api_usuario.dart';
import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/pages/usuario/usuario_card.dart';
import 'package:egresadoapp/pages/usuario/usuario_filter.dart';
import 'package:egresadoapp/providers/usuario_provider.dart';
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/errorwidget/error_widget.dart';
import 'package:egresadoapp/widgets/filters/filter_model.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/layout/sliverlayoutbody.dart';
import 'package:egresadoapp/widgets/layout/sliverlayoutheader.dart';
import 'package:egresadoapp/widgets/loading/loading.dart';
import 'package:egresadoapp/widgets/searchbar/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  late MuiFilterModel filter;

  @override
  void initState() {
    super.initState();
    filter = MuiFilterModel(
        child: const UsuarioFilter(), scaffoldKey: GlobalKey<ScaffoldState>());
  }

  @override
  Widget build(BuildContext context) {
    return MuiScreen(
      filter: filter,
      child: CustomScrollView(
        controller: ScrollController(),
        slivers: [
          SliverLayoutHeader(
            children: [
              IconButton(
                  onPressed: () {
                    filter.scaffoldKey.currentState?.openDrawer();
                  },
                  icon: Icon(
                    Icons.filter_alt_outlined,
                    color: MuiPalette.BROWN,
                  )),
              SearchBar(
                  initialValue:
                      Provider.of<UsuariosProvider>(context, listen: false)
                          .getSearch(),
                  onSubmit:
                      Provider.of<UsuariosProvider>(context, listen: false)
                          .setSearch,
                  onType: Provider.of<UsuariosProvider>(context, listen: false)
                      .setSearch),
            ],
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimensions.pageInsetGap),
              child: MuiPageTitle(label: "Usuarios"),
            ),
          ),
          FutureBuilder(
              future: Provider.of<UsuariosProvider>(context, listen: false)
                  .setFiltersAsyncronously(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverList(
                      delegate: SliverChildListDelegate.fixed([Loading()]));
                }
                if (snapshot.hasError) {
                  return const SliverList(
                      delegate:
                          SliverChildListDelegate.fixed([MuiErrorWidget()]));
                }
                return Consumer<UsuariosProvider>(
                  builder: (context, provider, child) {
                    return SliverLayoutBody(
                        gridGenerator: (items) => List.generate(
                            items.length,
                            (index) =>
                                UsuarioCard(usuario: items[index] as User)),
                        future: ApiUsuario.fetchUsers(
                            searchText: provider.getSearch(),
                            filtros: provider.getFilters()),
                        cardWidth: userCardWidth,
                        cardAspectRatio: userCardAspectRatio);
                  },
                );
              }))
        ],
      ),
    );
  }
}
