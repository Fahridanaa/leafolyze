import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';

class DiagnosisItem extends StatelessWidget {
  final String imagePath; // URL for the image
  final String plantName;
  final String diseaseName;
  final VoidCallback? onTap;

  const DiagnosisItem({
    super.key,
    required this.imagePath,
    required this.plantName,
    required this.diseaseName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.borderColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
      ),
      padding: EdgeInsets.all(AppSpacing.spacingM),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppBorderRadius.radiusXS),
              child: Image.network(
                imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.broken_image,
                  size: 100,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            SizedBox(width: AppSpacing.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plantName,
                    style: TextStyle(
                      fontSize: AppFontSize.fontSizeM,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                  ),
                  SizedBox(height: AppSpacing.spacingXS),
                  Text(
                    diseaseName,
                    style: TextStyle(
                      fontSize: AppFontSize.fontSizeS,
                      color: AppColors.textMutedColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.textMutedColor,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
