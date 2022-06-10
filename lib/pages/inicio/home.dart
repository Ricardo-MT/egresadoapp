import 'package:egresadoapp/api/endpoints/api_colaboracion.dart';
import 'package:egresadoapp/api/endpoints/api_eventos.dart';
import 'package:egresadoapp/api/endpoints/api_ofertas.dart';
import 'package:egresadoapp/api/models/colaboracion.dart';
import 'package:egresadoapp/api/models/evento.dart';
import 'package:egresadoapp/api/models/oferta.dart';
import 'package:egresadoapp/router/router.dart';
import 'package:egresadoapp/utils/converters.dart';
import 'package:egresadoapp/utils/debouncer.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/carrousel/landing_carrousel.dart';
import 'package:egresadoapp/widgets/errorwidget/error_widget.dart';
import 'package:egresadoapp/widgets/footer/privacyfooter.dart';
import 'package:egresadoapp/widgets/layout/screen.dart';
import 'package:egresadoapp/widgets/logo/logo.dart';
import 'package:egresadoapp/widgets/muicard/muicard.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(keepPage: true);
    automaticScrollerDebouncer.run(() {
      navigateTo(1);
    });
  }

  void navigateTo(int p) {
    if (!controller.hasClients) {
      return;
    }
    controller.animateToPage(p,
        duration: const Duration(milliseconds: 1200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return MuiScreen(
      child: PageView(
        scrollDirection: Axis.vertical,
        children: [
          Stack(
            children: [
              PageView(
                onPageChanged: (value) {
                  automaticScrollerDebouncer.run(() {
                    navigateTo(value == 2 ? 0 : value + 1);
                  });
                },
                controller: controller,
                children: const [
                  CarrouselLanding(
                      img: "assets/images/leader.png",
                      text: "Descubre personas con habilidades locas"),
                  CarrouselLanding(
                      img: "assets/images/team.png",
                      text: "Descubre personas con habilidades locas"),
                  CarrouselLanding(
                      img: "assets/images/people.png",
                      text: "Descubre personas con habilidades locas"),
                ],
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CarrouselIndicator(
                      controller: controller,
                    ),
                  ))
            ],
          ),
          SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                spacerXL,
                Center(
                  child: Text("Entérate de qué se cuece",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: MuiPalette.BROWN)),
                ),
                spacerXL,
                FutureBuilder(
                    future: ApiOfertas.fetchOfertas(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return spacerM;
                      }
                      if (snapshot.hasError) {
                        return const MuiErrorWidget();
                      }
                      return CardCarousel(
                          label: "Últimas ofertas laborales",
                          onVerMas: () {
                            Navigator.of(context).pushNamed(Routes.offers);
                          },
                          list: (snapshot.data as List<Oferta>)
                              .map((e) => DefaultCardModel(
                                  autor: e.autor.nombre,
                                  descripcion: e.descripcion,
                                  titulo: e.titulo,
                                  fecha: formatUnixDateToString(
                                      e.fechaPublicacion)))
                              .toList());
                    })),
                spacerXL,
                FutureBuilder(
                    future: ApiEventos.fetchEventos(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return spacerM;
                      }
                      if (snapshot.hasError) {
                        return const MuiErrorWidget();
                      }
                      return CardCarousel(
                          label: "Últimos eventos",
                          onVerMas: () {
                            Navigator.of(context).pushNamed(Routes.events);
                          },
                          list: (snapshot.data as List<Evento>)
                              .map((e) => DefaultCardModel(
                                  autor: e.autor.nombre,
                                  descripcion: e.descripcion,
                                  titulo: e.titulo,
                                  fecha: formatUnixDateToString(e.fecha)))
                              .toList());
                    })),
                spacerXL,
                FutureBuilder(
                    future: ApiColaboracion.fetchColaboraciones(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return spacerM;
                      }
                      if (snapshot.hasError) {
                        return const MuiErrorWidget();
                      }
                      return CardCarousel(
                          label: "Últimas colaboraciones",
                          onVerMas: () {
                            Navigator.of(context)
                                .pushNamed(Routes.collaboration);
                          },
                          list: (snapshot.data as List<Colaboracion>)
                              .map((e) => DefaultCardModel(
                                  autor: e.autor.nombre,
                                  descripcion: e.descripcion,
                                  titulo: e.titulo,
                                  fecha: formatUnixDateToString(
                                      e.fechaPublicacion)))
                              .toList());
                    })),
                spacerXL,
                Container(
                  width: double.infinity,
                  color: MuiPalette.BROWN,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Logo(
                        height: 30,
                      ),
                      spacerS,
                      const PrivacyFooter(),
                    ],
                  ),
                ),
                spacerM,
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CarrouselIndicator extends StatefulWidget {
  PageController controller;
  CarrouselIndicator({Key? key, required this.controller}) : super(key: key);

  @override
  State<CarrouselIndicator> createState() => _CarrouselIndicatorState();
}

class _CarrouselIndicatorState extends State<CarrouselIndicator> {
  late int page;

  @override
  void initState() {
    super.initState();
    page = 0;
    widget.controller.addListener(listenToChange);
  }

  void listenToChange() {
    setState(() {
      if (widget.controller.hasClients) {
        page = (widget.controller.page ?? 0).toInt();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(listenToChange);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedCircle(marked: page == 0),
        AnimatedCircle(marked: page == 1),
        AnimatedCircle(marked: page == 2),
      ],
    );
  }
}

class AnimatedCircle extends StatelessWidget {
  bool marked;
  AnimatedCircle({Key? key, required this.marked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
          color: marked ? MuiPalette.BROWN : MuiPalette.BACKGROUND,
          borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 16,
      height: 16,
    );
  }
}

class CardCarousel extends StatelessWidget {
  List<DefaultCardModel> list;
  String label;
  Function() onVerMas;
  CardCarousel(
      {Key? key,
      required this.list,
      required this.label,
      required this.onVerMas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              MuiButton(
                onPressed: onVerMas,
                text: "Ver más",
                variant: MuiButtonVariant.LINK,
              )
            ],
          ),
        ),
        SizedBox(
          height: defaultCardHeight + 20,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              for (var i = 0; i < list.length; i++)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MuiDefaultCard(
                      entidad: list[i],
                    ),
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
