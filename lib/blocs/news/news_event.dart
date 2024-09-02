part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class OnGetNewsEvent  extends NewsEvent {
  final NewsModel news;

  const OnGetNewsEvent({
    required this.news
  });
}

class OnSetNewNoticeEvent extends NewsEvent {
  final News newNotice;

  const OnSetNewNoticeEvent({
    required this.newNotice
  });
}