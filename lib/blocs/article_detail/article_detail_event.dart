import 'package:equatable/equatable.dart';

abstract class ArticleDetailEvent extends Equatable {
  const ArticleDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadArticleDetail extends ArticleDetailEvent {
  final int id;

  const LoadArticleDetail(this.id);

  @override
  List<Object> get props => [id];
}
