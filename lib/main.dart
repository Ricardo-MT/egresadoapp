import 'package:egresadoapp/router/router.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  MuiRouter.configureRoutes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Egresad@',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.login,
      onGenerateRoute: MuiRouter.router.generator,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.notoSansTextTheme(),
          scaffoldBackgroundColor: const Color(0xFFEFEBDE)),
    );
  }
}
