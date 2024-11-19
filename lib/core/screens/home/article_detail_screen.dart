import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/blocs/article_detail/article_detail_bloc.dart';
import 'package:leafolyze/blocs/article_detail/article_detail_event.dart';
import 'package:leafolyze/blocs/article_detail/article_detail_state.dart';
import 'package:leafolyze/repositories/article_repository.dart';
import 'package:leafolyze/utils/constants.dart';

class ArticleDetailScreen extends StatelessWidget {
  final int id;

  const ArticleDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArticleDetailBloc(
        context.read<ArticleRepository>(),
      )..add(LoadArticleDetail(id)),
      child: Scaffold(
        body: BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
          builder: (context, state) {
            if (state is ArticleDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ArticleDetailError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<ArticleDetailBloc>()
                            .add(LoadArticleDetail(id));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is ArticleDetailLoaded) {
              final article = state.article;

              return CustomScrollView(
                shrinkWrap: true,
                scrollBehavior: const ScrollBehavior().copyWith(
                  overscroll: false,
                ),
                slivers: [
                  SliverAppBar(
                    leading: IconButton(
                      icon:
                          const Icon(Icons.arrow_back, size: AppIconSize.iconS),
                      onPressed: () => context.pop(),
                    ),
                    pinned: true,
                    floating: true,
                    snap: true,
                    backgroundColor: AppColors.backgroundColor,
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.spacingM,
                      vertical: AppSpacing.spacingS,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppBorderRadius.radiusM),
                          child: Image.network(
                            article.gambarUrl,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.spacingM),
                        Text(
                          '${article.duration} min read',
                          style: const TextStyle(
                            fontSize: AppFontSize.fontSizeS,
                            fontWeight: AppFontWeight.semiBold,
                          ),
                        ),
                        Text(
                          article.title,
                          style: const TextStyle(
                            fontSize: AppFontSize.fontSizeXXL,
                            fontWeight: AppFontWeight.semiBold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.spacingM),
                        Text(
                          article.content,
                          style: const TextStyle(
                            fontSize: AppFontSize.fontSizeS,
                            color: AppColors.textColor,
                            fontWeight: AppFontWeight.regular,
                            height: AppLineHeight.lineHeightS,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ]),
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text('No article found'));
          },
        ),
      ),
    );
  }
}
