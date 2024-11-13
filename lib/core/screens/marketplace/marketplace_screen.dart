import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';
import 'package:leafolyze/core/widgets/common/custom_search_bar.dart';
import 'package:leafolyze/core/widgets/marketplace/product_card.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  int selectedFilterIndex = 0;
  final List<String> filters = [
    'All',
    'Black Spot',
    'Bacterial Spot',
    'Early Blight',
    'Late Blight',
    'Leaf Mold',
    'Septoria Leaf',
    'Yellow Leaf',
  ];

  // Add sample product data
  final List<Map<String, dynamic>> products = [
    {
      // 'image': 'lib/assets/images/product-1.jpg',
      'name': 'Fungisida Antracol',
      'price': 25000,
      'id': '1',
    },
    {
      // 'image': 'lib/assets/images/product-2.jpg',
      'name': 'Pestisida Curacron',
      'price': 35000,
      'id': '2',
    },
    {
      // 'image': 'lib/assets/images/product-3.jpg',
      'name': 'Fungisida Score',
      'price': 45000,
      'id': '3',
    },
    // Add more products as needed
  ];

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
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filters.length,
                        itemBuilder: (context, index) {
                          final isSelected = selectedFilterIndex == index;
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: AppSpacing.spacingS),
                            child: ChoiceChip(
                              showCheckmark: false,
                              label: Text(
                                filters[index],
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: AppFontSize.fontSizeS,
                                  fontWeight: AppFontWeight.semiBold,
                                ),
                              ),
                              selected: isSelected,
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedFilterIndex = index;
                                });
                              },
                              backgroundColor: AppColors.backgroundColor,
                              selectedColor: AppColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppBorderRadius.radiusXL),
                                side: BorderSide(
                                  color: isSelected
                                      ? Colors.transparent
                                      : AppColors.borderColor,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppSpacing.spacingM),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: AppSpacing.spacingM),
                    Text(
                      'Obat Tanaman',
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
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacingM),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: AppSpacing.spacingM,
                mainAxisSpacing: AppSpacing.spacingS,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = products[index];
                  return ProductCard(
                    id: product['id'],
                    // imageUrl: product['image'],
                    name: product['name'],
                    price: product['price'],
                  );
                },
                childCount: products.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
