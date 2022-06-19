import 'package:egresadoapp/pages/politica/default_styled_info_text.dart';
import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MuiMarkedInfoPage(
        backgroundImage: "assets/images/privacidad.png",
        markdownTextFile: "assets/markdown_files/privacy.md");
  }
}
