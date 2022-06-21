import 'package:egresadoapp/api/endpoints/api_colaboracion.dart';
import 'package:egresadoapp/api/models/colaboracion.dart';
import 'package:egresadoapp/pages/colaboraciones/colaboraciones_filter.dart';
import 'package:egresadoapp/providers/colaboraciones_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/converters.dart';
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/utils/permissions.dart';
import 'package:egresadoapp/widgets/ask_for_permission_widgets/conditional_widget.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/errorwidget/error_widget.dart';
import 'package:egresadoapp/widgets/filters/filter_model.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/layout/sliverlayoutbody.dart';
import 'package:egresadoapp/widgets/layout/sliverlayoutheader.dart';
import 'package:egresadoapp/widgets/loading/loading.dart';
import 'package:egresadoapp/widgets/muicard/muicard.dart';
import 'package:egresadoapp/widgets/searchbar/searchbar.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColaboracionesPage extends StatefulWidget {
  const ColaboracionesPage({Key? key}) : super(key: key);

  @override
  State<ColaboracionesPage> createState() => _ColaboracionesPageState();
}

class _ColaboracionesPageState extends State<ColaboracionesPage> {
  late MuiFilterModel filter;
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    filter = MuiFilterModel(
        child: const ColaboracionesFilter(),
        scaffoldKey: GlobalKey<ScaffoldState>());
  }

  @override
  Widget build(BuildContext context) {
    return MuiScreen(
      filter: filter,
      child: CustomScrollView(
        controller: _controller,
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
                  initialValue: Provider.of<ColaboracionesProvider>(context,
                          listen: false)
                      .getSearch(),
                  onSubmit: Provider.of<ColaboracionesProvider>(context,
                          listen: false)
                      .setSearch,
                  onType: Provider.of<ColaboracionesProvider>(context,
                          listen: false)
                      .setSearch),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.pageInsetGap),
              child: Row(
                children: [
                  const MuiPageTitle(label: "Colaboraciones"),
                  spacerExpanded,
                  MuiConditionalWidget(
                      child: MuiButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(NavigatorRoutes.collaborationCreate);
                          },
                          text: "Nueva"),
                      permision: puedeCrearColaboracion(context))
                ],
              ),
            ),
          ),
          FutureBuilder(
              future:
                  Provider.of<ColaboracionesProvider>(context, listen: false)
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
                return Consumer<ColaboracionesProvider>(
                  builder: (context, provider, child) {
                    return SliverLayoutBody(
                        key: provider.key,
                        controller: _controller,
                        gridGenerator: (items) =>
                            List.generate(items.length, (index) {
                              Colaboracion colaboracion = items[index];
                              return MuiDefaultCard(
                                  entidad: DefaultCardModel(
                                      onPress: () {
                                        Navigator.of(context).pushNamed(
                                            NavigatorRoutes.collaborationDetail(
                                                colaboracion.id));
                                      },
                                      autor: colaboracion.autor,
                                      descripcion: colaboracion.descripcion,
                                      titulo: colaboracion.titulo,
                                      fecha: formatUnixDateToString(
                                          colaboracion.fechaPublicacion)));
                            }),
                        future: (page) => ApiColaboracion.fetchColaboraciones(
                            page: page,
                            searchText: provider.getSearch(),
                            filtros: provider.getFilters()),
                        cardWidth: defaultCardWidth,
                        cardAspectRatio: defaultCardAspectRatio);
                  },
                );
              }))
        ],
      ),
    );
  }
}
