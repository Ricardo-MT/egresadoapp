import 'package:egresadoapp/api/endpoints/api_colaboracion.dart';
import 'package:egresadoapp/api/models/colaboracion.dart';
import 'package:egresadoapp/pages/colaboraciones/colaboraciones_filter.dart';
import 'package:egresadoapp/providers/colaboraciones_provider.dart';
import 'package:egresadoapp/utils/converters.dart';
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/utils/palette.dart';
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
        controller: ScrollController(),
        slivers: [
          SliverLayoutHeader(
            children: [
              Padding(
                padding:
                    EdgeInsets.zero.copyWith(left: Dimensions.pageInsetGap),
                child: IconButton(
                    onPressed: () {
                      filter.scaffoldKey.currentState?.openEndDrawer();
                    },
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: MuiPalette.BROWN,
                    )),
              ),
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
              spacerExpanded,
            ],
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
                        gridGenerator: (items) =>
                            List.generate(items.length, (index) {
                              Colaboracion evento = items[index];
                              return MuiDefaultCard(
                                  entidad: DefaultCardModel(
                                      autor: evento.autor.nombre,
                                      descripcion: evento.descripcion,
                                      titulo: evento.titulo,
                                      fecha: formatUnixDateToString(
                                          evento.fechaPublicacion)));
                            }),
                        future: ApiColaboracion.fetchColaboraciones(
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
