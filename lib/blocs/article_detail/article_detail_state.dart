import 'package:equatable/equatable.dart';
import 'package:leafolyze/models/article.dart';

abstract class ArticleDetailState extends Equatable {
  const ArticleDetailState();

  @override
  List<Object?> get props => [];
}

class ArticleDetailInitial extends ArticleDetailState {}

class ArticleDetailLoading extends ArticleDetailState {}

class ArticleDetailLoaded extends ArticleDetailState {
  final Article article;

  const ArticleDetailLoaded(this.article);

  @override
  List<Object?> get props => [article];
}

class ArticleDetailError extends ArticleDetailState {
  final String message;

  const ArticleDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
