import 'package:egresadoapp/pages/politica/default_styled_info_text.dart';
import 'package:flutter/material.dart';

class CookiesPage extends StatelessWidget {
  const CookiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MuiMarkedInfoPage(
        backgroundImage: "assets/images/cookies.png",
        markdownTextFile: "assets/markdown_files/cookies.md");
  }
}
