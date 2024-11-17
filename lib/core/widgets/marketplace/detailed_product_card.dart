import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/utils/constants.dart';
import 'package:leafolyze/models/product.dart';

class DetailedProductCard extends StatelessWidget {
  final Product product;

  const DetailedProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
      onTap: () => context.go('/marketplace/product/detail'),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 0),
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.spacingMS),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(AppBorderRadius.radiusXS),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(AppBorderRadius.radiusXS),
                          child: Image.network(
                            product.imageUrl,
                            height: MediaQuery.of(context).size.width * 0.35,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacingMS),
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: AppFontSize.fontSizeMS,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.spacingXXXS),
                    Text(
                      product.type,
                      style: TextStyle(
                          color: AppColors.textMutedColor,
                          fontSize: AppFontSize.fontSizeXS),
                    ),
                    const SizedBox(height: AppSpacing.spacingXXS),
                    Text(
                      'Rp. ${product.price}',
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: AppFontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spacingXXS),
                    Text(
                      product.shop?.name ?? '',
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: AppFontSize.fontSizeXS),
                    ),
                    const SizedBox(height: AppSpacing.spacingXXXS),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: AppIconSize.iconXXXS,
                            color: AppColors.textMutedColor),
                        const SizedBox(width: AppSpacing.spacingXXXS),
                        Flexible(
                          child: Text(
                            product.shop?.address ?? '',
                            style: TextStyle(
                                color: AppColors.textMutedColor,
                                fontSize: AppFontSize.fontSizeXS),
                            overflow: TextOverflow.ellipsis,
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
      ),
    );
  }
}
