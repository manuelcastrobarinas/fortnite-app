part of 'news_bloc.dart';

class NewsState extends Equatable {
  final NewsModel? news;
  final News? newSelected;

  const NewsState({
    this.news,
    this.newSelected
  });

  NewsState copyWith({
    NewsModel? news,
    News? newSelected,
  }) => NewsState(
    news: news ?? this.news,
    newSelected: newSelected ?? this.newSelected 
  );
  
  @override
  List<Object?> get props => [news, newSelected];
}