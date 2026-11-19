import 'package:fortnite_app/core/errors/exceptions.dart';
import 'package:fortnite_app/core/network/http_client.dart';

/// Traduce un status HTTP de error a [ApiException].
///
/// El cliente HTTP no lanza por status: el código viaja en [HttpResponse]
/// y cada datasource decide aquí si la respuesta es usable.
void throwIfUnsuccessful(HttpResponse response) {
  if (response.statusCode >= 200 && response.statusCode < 300) return;

  final body = response.data;
  final map = body is Map
      ? Map<String, dynamic>.from(body)
      : const <String, dynamic>{};
  final rawMessage = map['error_message'] ?? map['message'] ?? map['error'];
  final details = map['details'];

  throw ApiException(
    statusCode: response.statusCode,
    message: rawMessage?.toString() ?? '',
    code: map['code']?.toString(),
    details: details is List
        ? details.whereType<Map>().map(Map<String, dynamic>.from).toList()
        : null,
  );
}
