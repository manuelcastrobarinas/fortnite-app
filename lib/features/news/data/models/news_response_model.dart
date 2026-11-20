import 'package:fortnite_app/features/news/domain/entities/news.dart';

/// DTO de la respuesta `/news`. El datasource solo conoce este modelo;
/// el repositorio entrega la entidad [NewsModel].
class NewsResponseModel {
  const NewsResponseModel(this.feed);

  final NewsModel feed;

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) {
    return NewsResponseModel(NewsModel.fromJson(json));
  }

  /// fortnite-api.com envuelve el feed en `{status, data}` y parte Battle Royale
  /// y Salvar el mundo. La UI sigue leyendo una lista plana de [News].
  factory NewsResponseModel.fromPublicBody(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is! Map) {
      throw const FormatException('La respuesta de noticias no trae data');
    }
    final items = <News>[
      ..._motds(data['br']),
      ..._messages(data['stw']),
    ];
    return NewsResponseModel(
      NewsModel(result: true, lang: 'es', news: items),
    );
  }

  NewsModel toEntity() => feed;
}

List<News> _motds(dynamic feed) {
  if (feed is! Map) return const [];
  final date = DateTime.tryParse('${feed['date']}');
  final motds = feed['motds'];
  if (motds is! List) return const [];
  final items = <News>[];
  for (final raw in motds) {
    if (raw is! Map) continue;
    if (raw['hidden'] == true) continue;
    final title = _text(raw['title']);
    if (title.isEmpty) continue;
    items.add(
      News(
        id: _text(raw['id'], fallback: title),
        title: title,
        tabTitle: _nullable(raw['tabTitle']),
        date: date,
        body: _text(raw['body']),
        image: _nullable(raw['image']) ?? _nullable(raw['tileImage']),
      ),
    );
  }
  return items;
}

List<News> _messages(dynamic feed) {
  if (feed is! Map) return const [];
  final date = DateTime.tryParse('${feed['date']}');
  final messages = feed['messages'];
  if (messages is! List) return const [];
  final items = <News>[];
  for (var i = 0; i < messages.length; i++) {
    final raw = messages[i];
    if (raw is! Map) continue;
    final title = _text(raw['title']);
    if (title.isEmpty) continue;
    items.add(
      News(
        id: 'stw-$i',
        title: title,
        date: date,
        body: _text(raw['body']),
        image: _nullable(raw['image']),
      ),
    );
  }
  return items;
}

String _text(dynamic value, {String fallback = ''}) {
  final text = value?.toString().trim() ?? '';
  return text.isEmpty ? fallback : text;
}

String? _nullable(dynamic value) {
  final text = value?.toString().trim() ?? '';
  return text.isEmpty ? null : text;
}
