import 'package:egresadoapp/pages/politica/default_styled_info_text.dart';
import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MuiMarkedInfoPage(
        backgroundImage: "assets/images/terminos.png",
        markdownTextFile: "assets/markdown_files/terms.md");
  }
}
