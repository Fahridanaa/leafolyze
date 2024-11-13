import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/utils/constants.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        scrollBehavior: const ScrollBehavior().copyWith(
          overscroll: false,
        ),
        slivers: [
          // Sliver App Bar
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, size: AppIconSize.iconS),
              onPressed: () => context.pop(),
            ),
            pinned: true,
            floating: true,
            snap: true,
            backgroundColor: AppColors.backgroundColor,
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacingM,
              vertical: AppSpacing.spacingS,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppBorderRadius.radiusM),
                  child: Image.asset(
                    'assets/images/articledetail.jpg',
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacingM),
                const Text(
                  '2 min read',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSizeS,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                const Text(
                  'Bacterical Spot',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSizeXXL,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacingM),
                const Text(
                  'Lorem ipsum dolor amet, consectetuer adipiscing elit. Sodales proin luctus vestibulum leo fames elementum adipiscing. Laoreet tempor ex ex lobortis justo porta. Curabitur eros rutrum quisque; morbi cras vulputate dictum. Sagittis aliquet rhoncus ultrices morbi aliquet habitasse sociosqu facilisis. Augue augue himenaeos lectus sit interdum. Ut imperdiet et dis posuere viverra turpis. Vestibulum quam consectetur fringilla platea inceptos. \n\nLorem ipsum dolor amet, consectetuer adipiscing elit. Sodales proin luctus vestibulum leo fames elementum adipiscing. Laoreet tempor ex ex lobortis justo porta. Curabitur eros rutrum quisque; morbi cras vulputate dictum. Sagittis aliquet rhoncus ultrices morbi aliquet habitasse sociosqu facilisis. Augue augue himenaeos lectus sit interdum. Ut imperdiet et dis posuere viverra turpis. Vestibulum quam consectetur fringilla platea inceptos.\n\nLorem ipsum dolor amet, consectetuer adipiscing elit. Sodales proin luctus vestibulum leo fames elementum adipiscing. Laoreet tempor ex ex lobortis justo porta. Curabitur eros rutrum quisque; morbi cras vulputate dictum. Sagittis aliquet rhoncus ultrices morbi aliquet habitasse sociosqu facilisis. Augue augue himenaeos lectus sit interdum. Ut imperdiet et dis posuere viverra turpis. Vestibulum quam consectetur fringilla platea inceptos.',
                  style: TextStyle(
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
      ),
    );
  }
}
