import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fortnite_app/features/news/domain/entities/news.dart';
import 'package:fortnite_app/features/news/domain/usecases/get_news_usecase.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({required GetNewsUseCase getNews})
      : _getNews = getNews,
        super(const NewsState()) {
    on<OnGetNewsEvent>((event, emit) => emit(state.copyWith(news: event.news)));
    on<OnSetNewNoticeEvent>(
      (event, emit) => emit(state.copyWith(newSelected: event.newNotice)),
    );
  }

  final GetNewsUseCase _getNews;

  Future<NewsModel> getNews() async {
    final result = await _getNews();
    return result.fold(
      onFailure: (failure) => throw failure,
      onSuccess: (response) {
        add(OnGetNewsEvent(news: response));
        add(OnSetNewNoticeEvent(newNotice: response.news![0]));
        return response;
      },
    );
  }

  void setNewNotice({required News newNotice}) {
    add(OnSetNewNoticeEvent(newNotice: newNotice));
  }
}
