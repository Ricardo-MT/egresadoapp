import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NoTransitionsOnWeb extends PageTransitionsTheme {
  @override
  Widget buildTransitions<T>(
    route,
    context,
    animation,
    secondaryAnimation,
    child,
  ) {
    if (kIsWeb) {
      return child;
    }
    return super.buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}

// NavigationTargetHandler handleLandingNavigation(BuildContext context, Uri uri) {
//   final user = _auth.currentUser;
//   if (user == null) {
//     return getDefaultRoute();
//   }
//   return NavigationTargetHandler(child: const LandingPage(), route: "/card");
// }

// NavigationTargetHandler handleLoginNavigation(BuildContext context, Uri uri) {
//   return NavigationTargetHandler(child: const LoginPage(), route: "/login");
// }

// NavigationTargetHandler handleSignUpNavigation(BuildContext context, Uri uri) {
//   return NavigationTargetHandler(child: const SignUpPage(), route: "/signup");
// }

// NavigationTargetHandler handleEditCardNavigation(
//     BuildContext context, Uri uri) {
//   final user = _auth.currentUser;
//   if (user == null) {
//     return getDefaultRoute();
//   }
//   return NavigationTargetHandler(child: const EditCardPage(), route: "/edit");
// }

// NavigationTargetHandler handleMyCardNavigation(BuildContext context, Uri uri) {
//   final user = _auth.currentUser;
//   if (user == null) {
//     return getDefaultRoute();
//   }
//   return NavigationTargetHandler(child: const LandingPage(), route: "/card");
// }

// NavigationTargetHandler handleCardNavigation(BuildContext context, Uri uri) {
//   final route = uri.path;
//   final tarjetaId = uri.queryParameters['tarjetaId'];

//   String fullRoute = route;

//   if (tarjetaId != null) {
//     fullRoute += "?tarjetaId=$tarjetaId";
//     RouteSettings newSettings =
//         RouteSettings(name: fullRoute, arguments: ScreenArguments(tarjetaId));
//     return NavigationTargetHandler(
//         child: TarjetaPage(
//           id: tarjetaId,
//         ),
//         route: fullRoute,
//         arguments: newSettings.arguments);
//   }
//   return getDefaultRoute();
// }

// NavigationTargetHandler getDefaultRoute() {
//   return NavigationTargetHandler(child: const LoginPage(), route: "/login");
// }
