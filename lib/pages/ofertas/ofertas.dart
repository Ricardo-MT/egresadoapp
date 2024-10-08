import 'package:egresadoapp/api/endpoints/api_ofertas.dart';
import 'package:egresadoapp/api/models/oferta.dart';
import 'package:egresadoapp/pages/ofertas/ofertas_filter.dart';
import 'package:egresadoapp/providers/ofertas_provider.dart';
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

class OfertasPage extends StatefulWidget {
  const OfertasPage({Key? key}) : super(key: key);

  @override
  State<OfertasPage> createState() => _OfertasPageState();
}

class _OfertasPageState extends State<OfertasPage> {
  late MuiFilterModel filter;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    filter = MuiFilterModel(
        child: const OfertasFilter(), scaffoldKey: GlobalKey<ScaffoldState>());
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
              MuiSearchBar(
                  initialValue:
                      Provider.of<OfertasProvider>(context, listen: false)
                          .getSearch(),
                  onSubmit: Provider.of<OfertasProvider>(context, listen: false)
                      .setSearch,
                  onType: Provider.of<OfertasProvider>(context, listen: false)
                      .setSearch),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.pageInsetGap),
              child: Row(
                children: [
                  const MuiPageTitle(label: "Ofertas laborales"),
                  spacerExpanded,
                  MuiConditionalWidget(
                      child: MuiButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(NavigatorRoutes.offerCreate);
                          },
                          text: "Nueva"),
                      permision: puedeCrearOferta(context))
                ],
              ),
            ),
          ),
          FutureBuilder(
              future: Provider.of<OfertasProvider>(context, listen: false)
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
                return Consumer<OfertasProvider>(
                  builder: (context, provider, child) {
                    return SliverLayoutBody(
                        key: provider.key,
                        controller: _controller,
                        gridGenerator: (items) =>
                            List.generate(items.length, (index) {
                              Oferta oferta = items[index];
                              return MuiDefaultCard(
                                  entidad: DefaultCardModel(
                                      onPress: () {
                                        Navigator.of(context).pushNamed(
                                            NavigatorRoutes.offerDetail(
                                                oferta.id));
                                      },
                                      autor: oferta.autor,
                                      descripcion: oferta.descripcion,
                                      titulo: oferta.titulo,
                                      fecha: formatUnixDateToString(
                                          oferta.fechaPublicacion)));
                            }),
                        future: (page) => ApiOfertas.fetchOfertas(
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
