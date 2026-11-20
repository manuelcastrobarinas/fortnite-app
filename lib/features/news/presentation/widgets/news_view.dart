import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortnite_app/app/theme/app_colors.dart';
import 'package:fortnite_app/core/widgets/scorebug.dart';
import 'package:fortnite_app/features/news/domain/entities/news.dart';
import 'package:fortnite_app/features/news/presentation/bloc/news_bloc.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        final selected = state.newSelected;
        final newsItems = state.news?.news ?? const <News>[];
        if (selected == null || newsItems.isEmpty) {
          return const Center(
            child: Text(
              'No hay noticias disponibles',
              style: TextStyle(color: kInk, fontSize: 18),
            ),
          );
        }
        final cleanURL = cleanNewsImageUrl(selected.image);
        final date = selected.date;
        final dateLabel = date == null
            ? 'Sin fecha'
            : '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Scorebug(
              section: 'NOTICIAS',
              subject: selected.title,
              channel: kChannelNews,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: 240,
                    child: cleanURL == null
                        ? Image.asset('assets/loading/vbuck.png', fit: BoxFit.contain)
                        : FadeInImage(
                            fit: BoxFit.cover,
                            placeholder: const AssetImage('assets/loading/vbuck.png'),
                            image: NetworkImage(cleanURL),
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(dateLabel, style: const TextStyle(color: kInk, fontSize: 13)),
                        const SizedBox(height: 6),
                        Text(
                          selected.body,
                          style: const TextStyle(color: kInk, fontSize: 16, height: 1.35),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 92,
                    child: _NewsSelectorSlide(newsList: newsItems, selectedId: selected.id),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _NewsSelectorSlide extends StatelessWidget {
  const _NewsSelectorSlide({
    required this.newsList,
    required this.selectedId,
  });

  final List<News> newsList;
  final String selectedId;

  @override
  Widget build(BuildContext context) {
    final newsBloc = context.read<NewsBloc>();
    return ListView.builder(
      itemCount: newsList.length,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      itemBuilder: (BuildContext context, int i) {
        final news = newsList[i];
        final cleanURL = cleanNewsImageUrl(news.image);
        final selected = news.id == selectedId;
        return GestureDetector(
          onTap: () => newsBloc.setNewNotice(newNotice: news),
          child: Container(
            width: 120,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              border: Border.all(color: selected ? kInk : kQuiet, width: selected ? 2 : 1),
            ),
            child: quietItem(
              cleanURL == null
                  ? Image.asset('assets/loading/vbuck.png', fit: BoxFit.cover)
                  : FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: const AssetImage('assets/loading/vbuck.png'),
                      image: NetworkImage(cleanURL),
                    ),
              selected: selected,
            ),
          ),
        );
      },
    );
  }
}
