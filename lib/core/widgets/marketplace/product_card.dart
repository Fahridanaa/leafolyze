import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/utils/constants.dart';
import 'package:leafolyze/utils/string_utils.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int price;
  final String id;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(AppBorderRadius.radiusS),
      color: Colors.white,
      child: Stack(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(AppBorderRadius.radiusS),
            onTap: () => context.go('/marketplace/${slugify(name)}'),
            child: Container(
              padding: EdgeInsets.all(AppSpacing.spacingMS),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppBorderRadius.radiusS),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                    color: Colors.black.withOpacity(0.08),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'product_image_$id',
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppBorderRadius.radiusXS),
                      child: Image.asset(
                        imageUrl,
                        height: MediaQuery.of(context).size.width * 0.35,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.spacingS),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: AppFontSize.fontSizeMS,
                          fontWeight: AppFontWeight.semiBold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: AppSpacing.spacingMS),
                      Text(
                        'Mulai dari Rp${price.toString()}',
                        style: TextStyle(
                          fontSize: AppFontSize.fontSizeS,
                          color: AppColors.textMutedColor,
                          fontWeight: AppFontWeight.medium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
