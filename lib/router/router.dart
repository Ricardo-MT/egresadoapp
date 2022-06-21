import 'package:egresadoapp/api/endpoints/api_colaboracion.dart';
import 'package:egresadoapp/api/endpoints/api_eventos.dart';
import 'package:egresadoapp/api/endpoints/api_ofertas.dart';
import 'package:egresadoapp/api/endpoints/api_usuario.dart';
import 'package:egresadoapp/api/models/colaboracion.dart';
import 'package:egresadoapp/api/models/evento.dart';
import 'package:egresadoapp/api/models/oferta.dart';
import 'package:egresadoapp/api/models/user.dart';
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
import 'package:egresadoapp/pages/notFound.dart';
import 'package:egresadoapp/pages/ofertas/oferta_crear.dart';
import 'package:egresadoapp/pages/ofertas/oferta_detalle.dart';
import 'package:egresadoapp/pages/ofertas/oferta_editar.dart';
import 'package:egresadoapp/pages/ofertas/ofertas.dart';
import 'package:egresadoapp/pages/politica/conocenos.dart';
import 'package:egresadoapp/pages/politica/cookies.dart';
import 'package:egresadoapp/pages/politica/privacy.dart';
import 'package:egresadoapp/pages/politica/terms.dart';
import 'package:egresadoapp/pages/usuario/usuario_detalle.dart';
import 'package:egresadoapp/pages/usuario/usuario_editar.dart';
import 'package:egresadoapp/pages/usuario/usuario_editar_rol.dart';
import 'package:egresadoapp/pages/usuario/usuarios.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/permissions.dart';
import 'package:egresadoapp/widgets/errorwidget/error_widget.dart';
import 'package:egresadoapp/widgets/loading/loading.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _router = FluroRouter();

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
    router.define(Routes.users,
        handler: MuiHandlers._users, transitionType: _getTransitionType());
    router.define(Routes.userProfile,
        handler: MuiHandlers._userProfile,
        transitionType: _getTransitionType());
    router.define(Routes.userProfileEdit,
        handler: MuiHandlers._userProfileEdit,
        transitionType: _getTransitionType());
    router.define(Routes.userRolEdit,
        handler: MuiHandlers._userRolEdit,
        transitionType: _getTransitionType());

    // ACERCA DE
    router.define(Routes.about,
        handler: MuiHandlers._about, transitionType: _getTransitionType());

    router.notFoundHandler = MuiHandlers.notFound;
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
    return AuthCheckPage(
      shouldRedirect: Uri.base.path == "/",
    );
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
    // if (!puedeCrearOferta(context)) {
    //   return const Text("NO TIENES PERMISOS PARA CREAR OFERTAS");
    // }
    return const OfertaCrearPage();
  }));
  static final Handler _offerEdit =
      Handler(handlerFunc: ((context, parameters) {
    String id = parameters["id"]!.first;
    Oferta? oferta;
    bool allowed = false;
    return FutureBuilder(
        future: Future.wait([
          ApiOfertas.fetchById(id).then((value) {
            oferta = value;
          }),
          puedeEditarOferta(context).then((value) {
            allowed = value;
          })
        ]),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          if (snapshot.hasError) {
            return const MuiErrorWidget();
          }
          if (oferta == null) {
            return const NotFoundPage();
          }
          if (!allowed) {
            return const NotFoundPage();
            // return const Text(
            //     "No tienes permiso para editar esta oferta laboral");
          }
          return OfertaEditarPage(
            original: oferta!,
          );
        }));
  }));
  static final Handler _offerDetail =
      Handler(handlerFunc: ((context, parameters) {
    String id = parameters["id"]!.first;

    return FutureBuilder(
        future: ApiOfertas.fetchById(id),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          if (snapshot.hasError) {
            return const MuiErrorWidget();
          }
          if (!snapshot.hasData) {
            return const NotFoundPage();
          }
          return OfertaDetalle(
            oferta: snapshot.data as Oferta,
          );
        }));
  }));

  // EVENTOS
  static final Handler _events = Handler(handlerFunc: ((context, parameters) {
    return const EventosPage();
  }));
  static final Handler _eventCreate =
      Handler(handlerFunc: ((context, parameters) {
    // if (!puedeCrearEvento(context)) {
    //   return const Text("NO TIENES PERMISOS PARA CREAR EVENTOS");
    // }
    return const EventoCrearPage();
  }));
  static final Handler _eventEdit =
      Handler(handlerFunc: ((context, parameters) {
    String id = parameters["id"]!.first;
    Evento? evento;
    bool allowed = false;
    return FutureBuilder(
        future: Future.wait([
          ApiEventos.fetchById(id).then((value) {
            evento = value;
          }),
          puedeEditarEvento(context).then((value) {
            allowed = value;
          })
        ]),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          if (snapshot.hasError) {
            return const MuiErrorWidget();
          }
          if (evento == null) {
            return const NotFoundPage();
          }
          if (!allowed) {
            // return const Text("No tienes permiso para editar este evento");
            return const NotFoundPage();
          }
          return EventoEditarPage(
            original: evento!,
          );
        }));
  }));
  static final Handler _eventDetail =
      Handler(handlerFunc: ((context, parameters) {
    String id = parameters["id"]!.first;

    return FutureBuilder(
        future: ApiEventos.fetchById(id),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          if (snapshot.hasError) {
            return const MuiErrorWidget();
          }
          if (!snapshot.hasData) {
            return const NotFoundPage();
          }
          return EventoDetalle(
            evento: snapshot.data as Evento,
          );
        }));
  }));

  // COLABORACIONES
  static final Handler _collaborations =
      Handler(handlerFunc: ((context, parameters) {
    return const ColaboracionesPage();
  }));
  static final Handler _collaborationCreate =
      Handler(handlerFunc: ((context, parameters) {
    return const ColaboracionCrearPage();
  }));
  static final Handler _collaborationEdit =
      Handler(handlerFunc: ((context, parameters) {
    String id = parameters["id"]!.first;
    Colaboracion? colaboracion;
    bool allowed = false;
    return FutureBuilder(
        future: Future.wait([
          ApiColaboracion.fetchById(id).then((value) {
            colaboracion = value;
          }),
          puedeEditarColaboracion(context).then((value) {
            allowed = value;
          })
        ]),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          if (snapshot.hasError) {
            return const MuiErrorWidget();
          }
          if (colaboracion == null) {
            return const NotFoundPage();
          }
          if (!allowed) {
            return const NotFoundPage();
            // return const Text(
            //     "No tienes permiso para editar esta colaboración");
          }
          return ColaboracionEditarPage(
            original: colaboracion!,
          );
        }));
  }));
  static final Handler _collaborationDetail =
      Handler(handlerFunc: ((context, parameters) {
    String id = parameters["id"]!.first;

    return FutureBuilder(
        future: ApiColaboracion.fetchById(id),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          if (snapshot.hasError) {
            return const MuiErrorWidget();
          }
          if (!snapshot.hasData) {
            return const NotFoundPage();
          }
          return ColaboracionDetalle(
            colaboracion: snapshot.data as Colaboracion,
          );
        }));
  }));

  // USUARIO
  static final Handler _users = Handler(handlerFunc: ((context, parameters) {
    return const UsuariosPage();
  }));
  static final Handler _userProfile =
      Handler(handlerFunc: ((context, parameters) {
    String id = parameters["id"]!.first;

    return FutureBuilder(
        future: ApiUsuario.fetchById(id),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          if (snapshot.hasError) {
            return const MuiErrorWidget();
          }
          try {
            User user = snapshot.data as User;
            User? myUser =
                Provider.of<UsuarioProvider>(context, listen: false).user;
            if (!user.publico && (myUser == null || myUser.id != user.id)) {
              return const NotFoundPage();
            }
          } catch (e) {
            return const MuiErrorWidget();
          }
          return UsuarioDetalle(
            usuario: snapshot.data as User,
          );
        }));
  }));
  static final Handler _userProfileEdit =
      Handler(handlerFunc: ((context, parameters) {
    return const UsuarioEditar();
  }));
  static final Handler _userRolEdit =
      Handler(handlerFunc: ((context, parameters) {
    String id = parameters["id"]!.first;
    User? user;
    bool allowed = false;
    return FutureBuilder(
        future: Future.wait([
          ApiUsuario.fetchById(id).then((value) {
            user = value;
          }),
          puedeEditarRol(context).then((value) {
            allowed = value;
          })
        ]),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          }
          if (snapshot.hasError) {
            return const MuiErrorWidget();
          }
          if (user == null) {
            return const NotFoundPage();
          }
          if (!allowed) {
            return const Text(
                "No tienes permiso para editar el rol de este usuario");
          }
          return UsuarioEditarRol(
            original: user!,
          );
        }));
  }));

  // ACERCA DE
  static final Handler _about = Handler(handlerFunc: ((context, parameters) {
    return const ConocenosPage();
  }));

  // NOT FOUND
  static final Handler notFound = Handler(handlerFunc: ((context, parameters) {
    return const NotFoundPage();
  }));
}

TransitionType _getTransitionType() {
  return TransitionType.fadeIn;
}
