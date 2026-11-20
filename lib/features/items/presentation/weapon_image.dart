import 'package:flutter/widgets.dart';

/// El CDN de armas no envía CORS. En web, un [NetworkImage] normal hace fetch
/// y el navegador lo anula (status 0). Pintar con un elemento HTML sí muestra la foto.
NetworkImage weaponImage(String url) {
  return NetworkImage(
    url,
    webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
  );
}
