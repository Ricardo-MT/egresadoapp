import 'package:egresadoapp/providers/colaboraciones_provider.dart';
import 'package:egresadoapp/providers/eventos_provider.dart';
import 'package:egresadoapp/providers/ofertas_provider.dart';
import 'package:egresadoapp/providers/usuario_provider.dart';
import 'package:egresadoapp/router/router.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  MuiRouter.configureRoutes();
  runApp(const OverlaySupport.global(child: MyProviders()));
}

class MyProviders extends StatelessWidget {
  const MyProviders({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UsuariosProvider()),
        ChangeNotifierProvider(create: (context) => ColaboracionesProvider()),
        ChangeNotifierProvider(create: (context) => OfertasProvider()),
        ChangeNotifierProvider(create: (context) => EventosProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale("es", ""), Locale("en", "")],
      title: 'Egresad@',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.authCheck,
      onGenerateRoute: MuiRouter.router.generator,
      theme: ThemeData(
          textTheme: GoogleFonts.notoSansTextTheme(),
          appBarTheme: AppBarTheme(backgroundColor: MuiPalette.BROWN),
          scaffoldBackgroundColor: const Color(0xFFEFEBDE)),
    );
  }
}

Future<void> preconfigureApp(BuildContext context) async {
  await Future.wait([
    precacheImage(const AssetImage("assets/images/login.png"), context),
    precacheImage(const AssetImage("assets/images/register.png"), context),
    precacheImage(const AssetImage("assets/images/leader.png"), context),
    precacheImage(const AssetImage("assets/images/people.png"), context),
    precacheImage(const AssetImage("assets/images/team.png"), context),
    precacheImage(const AssetImage("assets/images/cookies.png"), context),
    precacheImage(const AssetImage("assets/images/privacidad.png"), context),
    precacheImage(const AssetImage("assets/images/terminos.png"), context),
  ]);
}
