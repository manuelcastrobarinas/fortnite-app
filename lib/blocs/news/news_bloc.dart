import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortnite_app/services/news/news.dart';

import '../../models/news/news.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsServices newsServices;

  NewsBloc({
    required this.newsServices
  }) : super(const NewsState()) {
    on<OnGetNewsEvent>((event, emit) => emit(state.copyWith(news: event.news)));
    on<OnSetNewNoticeEvent>((event, emit) => emit(state.copyWith(newSelected: event.newNotice)));
  }

  Future<String> getNews() async {
    final response = await newsServices.getNews();
    if(response != 'success') return response;
    add(OnGetNewsEvent(news: newsServices.newsModel!));
    if (newsServices.newsModel?.news == null || newsServices.newsModel!.news!.isEmpty) return 'No existen Noticias disponibles';
    add(OnSetNewNoticeEvent(newNotice: newsServices.newsModel!.news![0]));
    return response;
  }

  void setNewNotice({required News newNotice}) => add(OnSetNewNoticeEvent(newNotice: newNotice));
}
