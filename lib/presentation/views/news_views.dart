import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/news/news_bloc.dart';
import '../../models/news/news.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        final String cleanURL = '${state.newSelected!.image!.split('.jpeg')[0]}.jpeg';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  _ImageNews(cleanURL: cleanURL),
                  const _TransparentContainerImage(),
                   _TitleScreen(),
                  _TitleDateAndDescriptionNew(news: state.newSelected!),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: _NewsSelectorSlide(newsList: state.news!.news!),
            ),
          ],
        );
      },
    );
  }
}

class _NewsSelectorSlide extends StatelessWidget {
  final List<News> newsList;

  const _NewsSelectorSlide({
    required this.newsList
  });

  @override
  Widget build(BuildContext context) {
    final NewsBloc newsBloc = BlocProvider.of<NewsBloc>(context);
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: newsList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int i) {
          final News noticias = newsList[i];  
          final String cleanURL2 = '${noticias.image!.split('.jpeg')[0]}.jpeg';
          return  GestureDetector(
            onTap: () => newsBloc.setNewNotice(newNotice: newsList[i]),
            child: Container(
              width : MediaQuery.of(context).size.width * 0.3, // Ancho de cada ítem
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  fit: BoxFit.fill,
                  placeholder: const AssetImage("assets/loading/load.gif"), 
                  image: NetworkImage(cleanURL2)
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class _TitleDateAndDescriptionNew extends StatelessWidget {
  final News news;

  const _TitleDateAndDescriptionNew({
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, //ESTO HACE QUE EL COLUMN INTENTE OCUPAR EL MINIMO ESPACIO EN VEZ DE INTENTAR OCUPAR EL MAXIMO QUE ES SU COMPORTAMIENTO POR DEFECTO
          children: [
            _Title(title: news.title),
            _DateContainer(date: news.date!),
            _Description(description: news.body),
          ],
        ),
      )
    );
  }
}

class _TitleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const TextStyle titleStyle = TextStyle(color: Colors.white, fontSize: 80);
    return  const Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Align(
        alignment: Alignment.topCenter, // Posiciona en la parte inferior
        child: Text('FORTNITE', style: titleStyle, maxLines: 1, overflow: TextOverflow.ellipsis)
      ),
    );
  }
}

class _TransparentContainerImage extends StatelessWidget {
  const _TransparentContainerImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width : double.infinity,
      decoration: const BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadiusDirectional.vertical(bottom: Radius.circular(30.0))
      ),
    );
  }
}

class _ImageNews extends StatelessWidget {
  final String cleanURL;

  const _ImageNews({
    required this.cleanURL,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
      child: Opacity(
        opacity: 0.9,
        child: SizedBox(
          height: double.infinity,
          width : double.infinity,
          child: FadeInImage(
            fit: BoxFit.fill,
            placeholder: const AssetImage("assets/loading/load.gif"), 
            image: NetworkImage(cleanURL)
          ),
        ),
      ),
    );
  }
}

class _DateContainer extends StatelessWidget {
  final DateTime date;

  const _DateContainer({
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      width : double.infinity,
      child : Align(
        alignment: Alignment.centerLeft,
        child: Text('$date', style: const TextStyle(color: Colors.white, fontSize: 18, overflow: TextOverflow.ellipsis), maxLines: 1),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;

  const _Title({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(5.0),
    width : double.infinity,
    child : Padding(
      padding: const EdgeInsets.all(5.0),
        child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 32, overflow: TextOverflow.ellipsis), maxLines: 1),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final String description;

  const _Description({
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(5.0),
    width : double.infinity,
    child : Padding(
      padding: const EdgeInsets.all(5.0),
        child: Text(description, style: const TextStyle(color: Colors.white, fontSize: 18, overflow: TextOverflow.ellipsis), maxLines: 6),
      ),
    );
  }
}