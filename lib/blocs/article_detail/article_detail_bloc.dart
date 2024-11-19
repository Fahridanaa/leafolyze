import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leafolyze/blocs/article_detail/article_detail_event.dart';
import 'package:leafolyze/blocs/article_detail/article_detail_state.dart';
import 'package:leafolyze/repositories/article_repository.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  final ArticleRepository _repository;

  ArticleDetailBloc(this._repository) : super(ArticleDetailInitial()) {
    on<LoadArticleDetail>(_onLoadArticleDetail);
  }

  Future<void> _onLoadArticleDetail(
    LoadArticleDetail event,
    Emitter<ArticleDetailState> emit,
  ) async {
    emit(ArticleDetailLoading());
    try {
      final article = await _repository.getArticleById(event.id);
      emit(ArticleDetailLoaded(article));
    } catch (e) {
      emit(ArticleDetailError(e.toString()));
    }
  }
}
