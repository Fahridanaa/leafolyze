import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/utils/constants.dart';

class ArticleItemCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;
  final String description;

  const ArticleItemCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/home/article/$id');
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.spacingM,
          vertical: AppSpacing.spacingS,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppBorderRadius.radiusM),
          child: Stack(
            children: [
              Image.network(
                imageUrl.isEmpty ? 'assets/images/articledetail.jpg' : imageUrl,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/articledetail.jpg',
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(AppSpacing.spacingM),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppFontSize.fontSizeL,
                          fontWeight: AppFontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: AppFontSize.fontSizeXXS,
                            fontWeight: AppFontWeight.regular,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
