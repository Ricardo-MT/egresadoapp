import 'package:egresadoapp/utils/loading.dart';
import 'package:url_launcher/url_launcher_string.dart';

void platfomOpenExternally(String url) {
  try {
    // html.window.open(url, "_blank");
    launchUrlString(url);
  } catch (e) {
    LoadingHandler.showToastWithoutContext(
        "No se pudo abrir el enlace, el formato es inválido",
        isError: true);
  }
}
