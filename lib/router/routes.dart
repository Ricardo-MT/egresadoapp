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
  static String offerEdit = "/editar_oferta/:id";
  static String offerDetail = "/ver_oferta/:id";

  // EVENTOS
  static String events = "/eventos";
  static String eventCreate = "/crear_evento";
  static String eventEdit = "/editar_evento/:id";
  static String eventDetail = "/ver_evento/:id";

  // COLABORACIONES
  static String collaboration = "/colaboraciones";
  static String collaborationCreate = "/crear_colaboracion";
  static String collaborationEdit = "/editar_colaboracion/:id";
  static String collaborationDetail = "/ver_colaboracion/:id";

  // USUARIO
  static String users = "/usuarios";
  static String userProfile = "/perfil/:id";
  static String userProfileEdit = "/editar_perfil/:id";

  // ACERCA DE
  static String about = "/conocenos";
}

class NavigatorRoutes {
  // ACUERDOS LEGALES Y POLÍTICA DE USO
  static String terms = Routes.terms;
  static String privacy = Routes.privacy;
  static String cookies = Routes.cookies;

  // AUTENTICACIÓN
  static String authCheck = Routes.authCheck;
  static String login = Routes.login;
  static String register = Routes.register;

  // HOME
  static String home = Routes.home;

  // OFERTAS LABORALES
  static String offers = Routes.offers;
  static String offerCreate = Routes.offerCreate;
  static String offerEdit(id) => "/editar_oferta/$id";
  static String offerDetail(id) => "/ver_oferta/$id";

  // EVENTOS
  static String events = Routes.events;
  static String eventCreate = Routes.eventCreate;
  static String eventEdit(id) => "/editar_evento/$id";
  static String eventDetail(id) => "/ver_evento/$id";

  // COLABORACIONES
  static String collaboration = Routes.collaboration;
  static String collaborationCreate = Routes.collaborationCreate;
  static String collaborationEdit(id) => "/editar_colaboracion/$id";
  static String collaborationDetail(id) => "/ver_colaboracion/$id";

  // USUARIO
  static String users = Routes.users;
  static String userProfile(id) => "/perfil/$id";
  static String userProfileEdit(id) => "/editar_perfil/$id";

  // ACERCA DE
  static String about = Routes.about;
}
