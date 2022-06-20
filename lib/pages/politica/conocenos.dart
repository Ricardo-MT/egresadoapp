import 'package:egresadoapp/pages/politica/default_styled_info_text.dart';
import 'package:flutter/material.dart';

class ConocenosPage extends StatelessWidget {
  const ConocenosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MuiMarkedInfoPage(
        backgroundImage: "assets/images/conocenos.png",
        markdownTextFile: "assets/markdown_files/conocenos.md");
  }
}
