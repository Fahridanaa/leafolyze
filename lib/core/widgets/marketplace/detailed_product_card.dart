import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';

class DetailedProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String brand;
  final int price;
  final String storeName;
  final String location;

  const DetailedProductCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.brand,
    required this.price,
    required this.storeName,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          imageUrl,
                          height: MediaQuery.of(context).size.width * 0.35,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingMS),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: AppFontSize.fontSizeMS,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.spacingXXXS),
                  Text(
                    brand,
                    style: TextStyle(
                        color: AppColors.textMutedColor,
                        fontSize: AppFontSize.fontSizeXS),
                  ),
                  const SizedBox(height: AppSpacing.spacingXXS),
                  Text(
                    'Rp. $price',
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.spacingXXS),
                  Text(
                    storeName,
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
                          location,
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
    );
  }
}
