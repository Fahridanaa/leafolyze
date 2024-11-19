import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/article/article_event.dart';
import 'package:leafolyze/blocs/article/article_state.dart';
import 'package:leafolyze/repositories/article_repository.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepository _repository;

  ArticleBloc(this._repository) : super(ArticleInitial()) {
    on<LoadArticles>(_onLoadArticles);
    on<SearchArticles>(_onSearchArticles);
  }

  Future<void> _onLoadArticles(
    LoadArticles event,
    Emitter<ArticleState> emit,
  ) async {
    emit(ArticleLoading());
    try {
      final articles = await _repository.getArticles();
      emit(ArticleLoaded(articles));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }

  Future<void> _onSearchArticles(
    SearchArticles event,
    Emitter<ArticleState> emit,
  ) async {
    emit(ArticleLoading());
    try {
      final articles = await _repository.searchArticles(event.query);
      emit(ArticleLoaded(articles));
    } catch (e) {
      emit(ArticleError(e.toString()));
    }
  }
}
