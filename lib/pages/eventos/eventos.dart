import 'package:egresadoapp/api/endpoints/api_eventos.dart';
import 'package:egresadoapp/api/models/evento.dart';
import 'package:egresadoapp/pages/eventos/eventos_filter.dart';
import 'package:egresadoapp/providers/eventos_provider.dart';
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

class EventosPage extends StatefulWidget {
  const EventosPage({Key? key}) : super(key: key);

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {
  late MuiFilterModel filter;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    filter = MuiFilterModel(
        child: const EventosFilter(), scaffoldKey: GlobalKey<ScaffoldState>());
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
                      Provider.of<EventosProvider>(context, listen: false)
                          .getSearch(),
                  onSubmit: Provider.of<EventosProvider>(context, listen: false)
                      .setSearch,
                  onType: Provider.of<EventosProvider>(context, listen: false)
                      .setSearch),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.pageInsetGap),
              child: Row(
                children: [
                  const MuiPageTitle(label: "Eventos"),
                  spacerExpanded,
                  MuiConditionalWidget(
                      child: MuiButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(NavigatorRoutes.eventCreate);
                          },
                          text: "Nuevo"),
                      permision: puedeCrearEvento(context))
                ],
              ),
            ),
          ),
          FutureBuilder(
              future: Provider.of<EventosProvider>(context, listen: false)
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
                return Consumer<EventosProvider>(
                  builder: (context, provider, child) {
                    return SliverLayoutBody(
                        key: provider.key,
                        controller: _controller,
                        gridGenerator: (items) =>
                            List.generate(items.length, (index) {
                              Evento evento = items[index];
                              return MuiDefaultCard(
                                  entidad: DefaultCardModel(
                                      onPress: () {
                                        Navigator.of(context).pushNamed(
                                            NavigatorRoutes.eventDetail(
                                                evento.id));
                                      },
                                      autor: evento.autor,
                                      descripcion: evento.descripcion,
                                      titulo: evento.titulo,
                                      fecha: formatUnixDateToString(
                                          evento.fecha)));
                            }),
                        future: (page) => ApiEventos.fetchEventos(
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
