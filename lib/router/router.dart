import 'package:egresadoapp/pages/auth/login.dart';
import 'package:egresadoapp/pages/auth/register.dart';
import 'package:egresadoapp/pages/politica/cookies.dart';
import 'package:egresadoapp/pages/politica/privacy.dart';
import 'package:egresadoapp/pages/politica/terms.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

final _router = FluroRouter();

class Routes {
  static String authCheck = "/";
  static String login = "/login";
  static String register = "/registro";
  static String terms = "/terminos";
  static String privacy = "/privacidad";
  static String cookies = "/cookies";
  static String home = "/inicio";
  static String events = "/eventos";
  static String collaboration = "/colaboraciones";
  static String offers = "/ofertas";
  static String about = "/conocenos";
}

class MuiRouter {
  static final FluroRouter router = _router;
  static void configureRoutes() {
    router.define(Routes.authCheck,
        handler: MuiHandlers._authCheck, transitionType: _getTransitionType());
    router.define(Routes.login,
        handler: MuiHandlers._login, transitionType: _getTransitionType());
    router.define(Routes.register,
        handler: MuiHandlers._register, transitionType: _getTransitionType());
    router.define(Routes.terms,
        handler: MuiHandlers._terms, transitionType: _getTransitionType());
    router.define(Routes.privacy,
        handler: MuiHandlers._privacy, transitionType: _getTransitionType());
    router.define(Routes.cookies,
        handler: MuiHandlers._cookies, transitionType: _getTransitionType());
    router.define(Routes.home,
        handler: MuiHandlers._home, transitionType: _getTransitionType());
    router.define(Routes.events,
        handler: MuiHandlers._events, transitionType: _getTransitionType());
    router.define(Routes.collaboration,
        handler: MuiHandlers._collaborations,
        transitionType: _getTransitionType());
    router.define(Routes.offers,
        handler: MuiHandlers._offers, transitionType: _getTransitionType());
    router.define(Routes.about,
        handler: MuiHandlers._about, transitionType: _getTransitionType());
  }
}

class MuiHandlers {
  static final Handler _authCheck =
      Handler(handlerFunc: ((context, parameters) {
    return Container();
  }));
  static final Handler _login = Handler(handlerFunc: ((context, parameters) {
    return const LoginPage();
  }));

  static final Handler _register = Handler(handlerFunc: ((context, parameters) {
    return const RegisterPage();
  }));
  static final Handler _terms = Handler(handlerFunc: ((context, parameters) {
    return const TermsPage();
  }));
  static final Handler _privacy = Handler(handlerFunc: ((context, parameters) {
    return const PrivacyPage();
  }));
  static final Handler _cookies = Handler(handlerFunc: ((context, parameters) {
    return const CookiesPage();
  }));
  static final Handler _home = Handler(handlerFunc: ((context, parameters) {
    return Container();
  }));
  static final Handler _events = Handler(handlerFunc: ((context, parameters) {
    return Container();
  }));
  static final Handler _collaborations =
      Handler(handlerFunc: ((context, parameters) {
    return Container();
  }));
  static final Handler _offers = Handler(handlerFunc: ((context, parameters) {
    return Container();
  }));
  static final Handler _about = Handler(handlerFunc: ((context, parameters) {
    return Container();
  }));
}

TransitionType _getTransitionType() {
  return TransitionType.none;
}
