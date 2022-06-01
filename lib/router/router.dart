import 'package:egresadoapp/pages/auth/authcheck.dart';
import 'package:egresadoapp/pages/auth/login.dart';
import 'package:egresadoapp/pages/auth/register.dart';
import 'package:egresadoapp/pages/colaboraciones/colaboracion_crear.dart';
import 'package:egresadoapp/pages/colaboraciones/colaboracion_detalle.dart';
import 'package:egresadoapp/pages/colaboraciones/colaboracion_editar.dart';
import 'package:egresadoapp/pages/colaboraciones/colaboraciones.dart';
import 'package:egresadoapp/pages/eventos/evento_crear.dart';
import 'package:egresadoapp/pages/eventos/evento_detalle.dart';
import 'package:egresadoapp/pages/eventos/evento_editar.dart';
import 'package:egresadoapp/pages/eventos/eventos.dart';
import 'package:egresadoapp/pages/inicio/home.dart';
import 'package:egresadoapp/pages/ofertas/oferta_crear.dart';
import 'package:egresadoapp/pages/ofertas/oferta_detalle.dart';
import 'package:egresadoapp/pages/ofertas/oferta_editar.dart';
import 'package:egresadoapp/pages/ofertas/ofertas.dart';
import 'package:egresadoapp/pages/politica/cookies.dart';
import 'package:egresadoapp/pages/politica/privacy.dart';
import 'package:egresadoapp/pages/politica/terms.dart';
import 'package:egresadoapp/pages/usuario/usuario_detalle.dart';
import 'package:egresadoapp/pages/usuario/usuario_editar.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

final _router = FluroRouter();

class Routes {
  // ACUERDOS LEGALES Y POLÍTICA DE USO
  static String terms = "/terminos";
  static String privacy = "/privacidad";
  static String cookies = "/cookies";

  // AUTENTICACIÓN
  static String authCheck = "/";
  static String login = "/login";
  static String register = "/registro";

  // HOME
  static String home = "/inicio";

  // OFERTAS LABORALES
  static String offers = "/ofertas";
  static String offerCreate = "/crear_oferta";
  static String offerEdit = "/editar_oferta";
  static String offerDetail = "/ver_oferta:id";

  // EVENTOS
  static String events = "/eventos";
  static String eventCreate = "/crear_evento";
  static String eventEdit = "/editar_evento";
  static String eventDetail = "/ver_evento:id";

  // COLABORACIONES
  static String collaboration = "/colaboraciones";
  static String collaborationCreate = "/crear_colaboracion";
  static String collaborationEdit = "/editar_colaboracion";
  static String collaborationDetail = "/ver_colaboracion:id";

  // USUARIO
  static String userProfile = "/profile:id";
  static String userProfileEdit = "/profileEdit:id";

  // ACERCA DE
  static String about = "/conocenos";
}

class MuiRouter {
  static final FluroRouter router = _router;
  static void configureRoutes() {
    // ACUERDOS LEGALES Y POLÍTICA DE USO
    router.define(Routes.terms,
        handler: MuiHandlers._terms, transitionType: _getTransitionType());
    router.define(Routes.privacy,
        handler: MuiHandlers._privacy, transitionType: _getTransitionType());
    router.define(Routes.cookies,
        handler: MuiHandlers._cookies, transitionType: _getTransitionType());

    // AUTENTICACIÓN
    router.define(Routes.authCheck,
        handler: MuiHandlers._authCheck, transitionType: _getTransitionType());
    router.define(Routes.login,
        handler: MuiHandlers._login, transitionType: _getTransitionType());
    router.define(Routes.register,
        handler: MuiHandlers._register, transitionType: _getTransitionType());

    // HOME
    router.define(Routes.home,
        handler: MuiHandlers._home, transitionType: _getTransitionType());

    // OFERTAS LABORALES
    router.define(Routes.offers,
        handler: MuiHandlers._offers, transitionType: _getTransitionType());
    router.define(Routes.offerCreate,
        handler: MuiHandlers._offerCreate,
        transitionType: _getTransitionType());
    router.define(Routes.offerEdit,
        handler: MuiHandlers._offerEdit, transitionType: _getTransitionType());
    router.define(Routes.offerDetail,
        handler: MuiHandlers._offerDetail,
        transitionType: _getTransitionType());

    // EVENTOS
    router.define(Routes.events,
        handler: MuiHandlers._events, transitionType: _getTransitionType());
    router.define(Routes.eventCreate,
        handler: MuiHandlers._eventCreate,
        transitionType: _getTransitionType());
    router.define(Routes.eventEdit,
        handler: MuiHandlers._eventEdit, transitionType: _getTransitionType());
    router.define(Routes.eventDetail,
        handler: MuiHandlers._eventDetail,
        transitionType: _getTransitionType());

    // COLABORACIONES
    router.define(Routes.collaboration,
        handler: MuiHandlers._collaborations,
        transitionType: _getTransitionType());
    router.define(Routes.collaborationCreate,
        handler: MuiHandlers._collaborationCreate,
        transitionType: _getTransitionType());
    router.define(Routes.collaborationEdit,
        handler: MuiHandlers._collaborationEdit,
        transitionType: _getTransitionType());
    router.define(Routes.collaborationDetail,
        handler: MuiHandlers._collaborationDetail,
        transitionType: _getTransitionType());

    // USUARIO
    router.define(Routes.userProfile,
        handler: MuiHandlers._userProfile,
        transitionType: _getTransitionType());
    router.define(Routes.userProfileEdit,
        handler: MuiHandlers._userProfileEdit,
        transitionType: _getTransitionType());

    // ACERCA DE
    router.define(Routes.about,
        handler: MuiHandlers._about, transitionType: _getTransitionType());
  }
}

class MuiHandlers {
  // ACUERDOS LEGALES Y POLÍTICA DE USO
  static final Handler _terms = Handler(handlerFunc: ((context, parameters) {
    return const TermsPage();
  }));
  static final Handler _privacy = Handler(handlerFunc: ((context, parameters) {
    return const PrivacyPage();
  }));
  static final Handler _cookies = Handler(handlerFunc: ((context, parameters) {
    return const CookiesPage();
  }));

  // AUTENTICACIÓN
  static final Handler _authCheck =
      Handler(handlerFunc: ((context, parameters) {
    return const AuthCheckPage();
  }));
  static final Handler _login = Handler(handlerFunc: ((context, parameters) {
    return const LoginPage();
  }));
  static final Handler _register = Handler(handlerFunc: ((context, parameters) {
    return const RegisterPage();
  }));

  // HOME
  static final Handler _home = Handler(handlerFunc: ((context, parameters) {
    return const HomePage();
  }));

  // OFERTAS LABORALES
  static final Handler _offers = Handler(handlerFunc: ((context, parameters) {
    return const OfertasPage();
  }));
  static final Handler _offerCreate =
      Handler(handlerFunc: ((context, parameters) {
    return const OfertaCrear();
  }));
  static final Handler _offerEdit =
      Handler(handlerFunc: ((context, parameters) {
    return const OfertaEditar();
  }));
  static final Handler _offerDetail =
      Handler(handlerFunc: ((context, parameters) {
    return const OfertaDetalle();
  }));

  // EVENTOS
  static final Handler _events = Handler(handlerFunc: ((context, parameters) {
    return const EventosPage();
  }));
  static final Handler _eventCreate =
      Handler(handlerFunc: ((context, parameters) {
    return const EventoCrear();
  }));
  static final Handler _eventEdit =
      Handler(handlerFunc: ((context, parameters) {
    return const EventoEditar();
  }));
  static final Handler _eventDetail =
      Handler(handlerFunc: ((context, parameters) {
    return const EventoDetalle();
  }));

  // COLABORACIONES
  static final Handler _collaborations =
      Handler(handlerFunc: ((context, parameters) {
    return const ColaboracionesPage();
  }));
  static final Handler _collaborationCreate =
      Handler(handlerFunc: ((context, parameters) {
    return const ColaboracionCrear();
  }));
  static final Handler _collaborationEdit =
      Handler(handlerFunc: ((context, parameters) {
    return const ColaboracionEditar();
  }));
  static final Handler _collaborationDetail =
      Handler(handlerFunc: ((context, parameters) {
    return const ColaboracionDetalle();
  }));

  // USUARIO
  static final Handler _userProfile =
      Handler(handlerFunc: ((context, parameters) {
    return const UsuarioDetalle();
  }));
  static final Handler _userProfileEdit =
      Handler(handlerFunc: ((context, parameters) {
    return const UsuarioEditar();
  }));

  // ACERCA DE
  static final Handler _about = Handler(handlerFunc: ((context, parameters) {
    return Container();
  }));
}

TransitionType _getTransitionType() {
  return TransitionType.none;
}
