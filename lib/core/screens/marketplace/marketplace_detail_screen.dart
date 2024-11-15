import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';

class MarketplaceDetailScreen extends StatefulWidget {
  const MarketplaceDetailScreen({super.key});

  @override
  State<MarketplaceDetailScreen> createState() =>
      _MarketplaceDetailScreenState();
}

class _MarketplaceDetailScreenState extends State<MarketplaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        scrollBehavior: const ScrollBehavior().copyWith(
          overscroll: false,
        ),
        slivers: [
          const SliverAppBar(
            centerTitle: true,
            title: Text(
              'Profile Toko',
              style: TextStyle(
                fontSize: AppFontSize.fontSizeXXL,
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
            floating: true,
            snap: true,
            pinned: true,
            backgroundColor: AppColors.backgroundColor,
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.spacingM),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: AppSpacing.spacingL),
                // Store Name
                const Text(
                  'Toko Tanaman Sehat',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSizeL,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacingM),
                // Store Image and Details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Store Image
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppBorderRadius.radiusXS),
                      child: Image.network(
                        'https://placeholder.com/150x150', // Replace with actual image
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.spacingM),
                    // Store Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Lokasi',
                            style: TextStyle(
                              color: AppColors.textMutedColor,
                              fontWeight: AppFontWeight.semiBold,
                            ),
                          ),
                          Text(
                            'Kota Malang',
                            style: TextStyle(
                              fontWeight: AppFontWeight.semiBold,
                            ),
                          ),
                          SizedBox(
                            height: AppSpacing.spacingS,
                          ),
                          Text(
                            'Jam Operasional',
                            style: TextStyle(
                              color: AppColors.textMutedColor,
                              fontWeight: AppFontWeight.semiBold,
                            ),
                          ),
                          Text(
                            '08.00 - 17.00 WIB',
                            style: TextStyle(
                              fontWeight: AppFontWeight.semiBold,
                            ),
                          ),
                          SizedBox(height: AppSpacing.spacingS),
                          Text(
                            'Tanggal Bergabung',
                            style: TextStyle(
                              color: AppColors.textMutedColor,
                              fontWeight: AppFontWeight.semiBold,
                            ),
                          ),
                          Text(
                            '1 Januari 2024',
                            style: TextStyle(
                              fontWeight: AppFontWeight.semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.spacingM),
                // Store Description
                const Text(
                  'Deskripsi Toko',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSizeM,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacingXS),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                ),
                const SizedBox(height: AppSpacing.spacingM),
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSizeM,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacingXS),
                // Google Maps
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text('Google Maps will be integrated here'),
                  ),
                ),
                const SizedBox(height: AppSpacing.spacingM),
                // Store Products
                const Text(
                  'Produk Toko',
                  style: TextStyle(
                    fontSize: AppFontSize.fontSizeM,
                    fontWeight: AppFontWeight.semiBold,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacingXS),
                // Add your product grid or list here
                GridView.builder(
                  padding: const EdgeInsets.only(bottom: AppSpacing.spacingXXL),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: AppSpacing.spacingM,
                    mainAxisSpacing: AppSpacing.spacingM,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: 4, // Example count
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text('Product Item'),
                      ),
                    );
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
