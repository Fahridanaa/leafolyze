import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/blocs/article/article_bloc.dart';
import 'package:leafolyze/blocs/article/article_event.dart';
import 'package:leafolyze/blocs/article/article_state.dart';
import 'package:leafolyze/core/widgets/home/article_item_card.dart';
import 'package:leafolyze/core/widgets/common/custom_search_bar.dart';
import 'package:leafolyze/repositories/article_repository.dart';
import 'package:leafolyze/services/api_service.dart';
import 'package:leafolyze/utils/constants.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ArticleBloc(
              ArticleRepository(
                context.read<ApiService>(),
              ),
            )..add(LoadArticles()),
        child: Scaffold(
          body: CustomScrollView(
            shrinkWrap: true,
            scrollBehavior: const ScrollBehavior().copyWith(
              overscroll: false,
            ),
            slivers: [
              SliverAppBar(
                centerTitle: true,
                backgroundColor: AppColors.backgroundColor,
                title: const Text(
                  'Articles',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSizeXXL,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                floating: true,
                snap: true,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppSpacing.spacingM),
                  child: BlocBuilder<ArticleBloc, ArticleState>(
                    builder: (context, state) {
                      return CustomSearchBar(
                        onChanged: (value) {
                          context
                              .read<ArticleBloc>()
                              .add(SearchArticles(value));
                        },
                        onSubmitted: (value) {
                          context
                              .read<ArticleBloc>()
                              .add(SearchArticles(value));
                        },
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder<ArticleBloc, ArticleState>(
                builder: (context, state) {
                  if (state is ArticleLoading) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is ArticleError) {
                    return SliverFillRemaining(
                      child: Center(child: Text(state.message)),
                    );
                  }

                  if (state is ArticleLoaded) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final article = state.articles[index];
                          return ArticleItemCard(
                            id: article.id,
                            imageUrl: article.image?.path ?? '',
                            title: article.title,
                            description: article.content,
                          );
                        },
                        childCount: state.articles.length,
                      ),
                    );
                  }

                  return const SliverFillRemaining(
                    child: Center(child: Text('No articles found')),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
