import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/core/widgets/home/article_item_card.dart';
import 'package:leafolyze/core/widgets/common/custom_search_bar.dart';
import 'package:leafolyze/utils/constants.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: CustomSearchBar(
                // TODO: Implement search functionality
                onChanged: (value) {},
                onSubmitted: (value) {},
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ArticleItemCard(
                  imageUrl:
                      'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/222/2024/05/28/IMG-20240528-WA0105-1208872859.jpg',
                  title: 'Bacterial Spot',
                  description:
                      'Lorem ipsum dolor amet, consectetur adipiscing elit. Sodales proin luctus vestibulum.',
                );
              },
              childCount: 6, // Jumlah artikel contoh
            ),
          ),
        ],
      ),
    );
  }
}
