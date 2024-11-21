import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';
import 'package:leafolyze/core/widgets/common/custom_search_bar.dart';
import 'package:leafolyze/core/widgets/marketplace/product_card.dart';

final List<Map<String, dynamic>> diseaseProducts = [
  {
    'image': 'assets/images/black_spot.png',
    'name': 'Black Spot',
    'price': 25000,
    'diseaseId': '1',
  },
  {
    'image': 'assets/images/bacterial_spot.png',
    'name': 'Bacterial Spot',
    'price': 35000,
    'diseaseId': '2',
  },
  {
    'image': 'assets/images/early_blight.png',
    'name': 'Early Blight',
    'price': 45000,
    'diseaseId': '3',
  },
  {
    'image': 'assets/images/late_blight.png',
    'name': 'Late Blight',
    'price': 55000,
    'diseaseId': '4',
  },
  {
    'image': 'assets/images/leaf_mold.png',
    'name': 'Leaf Mold',
    'price': 65000,
    'diseaseId': '5',
  },
  {
    'image': 'assets/images/septoria_leaf.png',
    'name': 'Septoria Leaf',
    'price': 75000,
    'diseaseId': '6',
  },
  {
    'image': 'assets/images/yellow_leaf.png',
    'name': 'Yellow Leaf',
    'price': 85000,
    'diseaseId': '7',
  },
];

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
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
            backgroundColor: AppColors.backgroundColor,
            centerTitle: true,
            title: const Text(
              'Marketplace',
              style: TextStyle(
                fontSize: AppFontSize.fontSizeXXL,
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
            floating: true,
            snap: true,
            pinned: true,
            expandedHeight: 80,
          ),
          SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacingM),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    CustomSearchBar(
                      // TODO: Implement search functionality
                      onChanged: (value) {},
                      onSubmitted: (value) {},
                    ),
                    SizedBox(height: AppSpacing.spacingM),
                    Text(
                      'Penyakit Tanaman',
                      style: TextStyle(
                        fontSize: AppFontSize.fontSizeL,
                        fontWeight: AppFontWeight.semiBold,
                      ),
                    ),
                    SizedBox(height: AppSpacing.spacingM),
                  ],
                ),
              )),
          SliverPadding(
            padding: EdgeInsets.only(
              left: AppSpacing.spacingM,
              right: AppSpacing.spacingM,
              bottom: AppSpacing.spacingM,
            ),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: AppSpacing.spacingM,
                mainAxisSpacing: AppSpacing.spacingS,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final diseaseProduct = diseaseProducts[index];
                  return ProductCard(
                    id: diseaseProduct['id'],
                    imageUrl: diseaseProduct['image'],
                    name: diseaseProduct['name'],
                    price: diseaseProduct['price'],
                  );
                },
                childCount: diseaseProducts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
