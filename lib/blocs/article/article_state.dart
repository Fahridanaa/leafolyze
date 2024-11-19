import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/article.dart';

abstract class ArticleState extends Equatable {
  const ArticleState();

  @override
  List<Object> get props => [];
}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<Article> articles;

  const ArticleLoaded(this.articles);

  @override
  List<Object> get props => [articles];
}

class ArticleError extends ArticleState {
  final String message;

  const ArticleError(this.message);

  @override
  List<Object> get props => [message];
}
