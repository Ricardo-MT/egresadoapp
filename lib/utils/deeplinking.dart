import 'web_deeplinking.dart' if (dart.library.io) "mobile_deeplinking.dart"
    as html;

import 'package:egresadoapp/utils/loading.dart';

void openExternally(String url) {
  try {
    // html.window.open(url, "_blank");
    html.platfomOpenExternally(url);
  } catch (e) {
    print(e);
    LoadingHandler.showToastWithoutContext(
        "No se pudo abrir el enlace, el formato es inválido",
        isError: true);
  }
}
