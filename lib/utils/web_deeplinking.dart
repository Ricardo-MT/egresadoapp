import "dart:html" as html;
import 'package:egresadoapp/utils/loading.dart';

void platfomOpenExternally(String url) {
  try {
    html.window.open(url, "_blank");
  } catch (e) {
    print(e);
    LoadingHandler.showToastWithoutContext(
        "No se pudo abrir el enlace, el formato es inválido",
        isError: true);
  }
}
