import 'package:flutter/material.dart';
import 'package:leafolyze/core/widgets/common/custom_search_bar.dart';
import 'package:leafolyze/core/widgets/marketplace/detailed_product_card.dart';
import 'package:leafolyze/utils/constants.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String? selectedSortOption = 'Recently Added';

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppBorderRadius.radiusS)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(
                'Sort By',
                style: TextStyle(
                  fontWeight: AppFontWeight.semiBold,
                  color: AppColors.textMutedColor,
                ),
              ),
            ),
            RadioListTile<String>(
              title: const Text('Recently Added'),
              value: 'Recently Added',
              groupValue: selectedSortOption,
              onChanged: (value) {
                setState(() {
                  selectedSortOption = value;
                });
                Navigator.pop(context);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.textColor,
            ),
            RadioListTile<String>(
              title: const Text('Price: Low to High'),
              value: 'Price: Low to High',
              groupValue: selectedSortOption,
              onChanged: (value) {
                setState(() {
                  selectedSortOption = value;
                });
                Navigator.pop(context);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.textColor,
            ),
            RadioListTile<String>(
              title: const Text('Price: High to Low'),
              value: 'Price: High to Low',
              groupValue: selectedSortOption,
              onChanged: (value) {
                setState(() {
                  selectedSortOption = value;
                });
                Navigator.pop(context);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.textColor,
            ),
            RadioListTile<String>(
              title: const Text('Top Rated'),
              value: 'Top Rated',
              groupValue: selectedSortOption,
              onChanged: (value) {
                setState(() {
                  selectedSortOption = value;
                });
                Navigator.pop(context);
              },
              controlAffinity: ListTileControlAffinity.trailing,
              activeColor: AppColors.textColor,
            ),
          ],
        );
      },
    );
  }

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
            title: Text(
              'Actigard',
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
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.spacingM,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                CustomSearchBar(
                  // TODO: Implement search functionality
                  onChanged: (value) {},
                  onSubmitted: (value) {},
                ),
                SizedBox(height: AppSpacing.spacingM),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showSortOptions(context);
                        },
                        icon: const Icon(
                          Icons.sort,
                          color: AppColors.textColor,
                          size: AppIconSize.iconS,
                        ),
                        label: Text(
                          'Sort By',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: AppFontSize.fontSizeMS,
                            fontWeight: AppFontWeight.semiBold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.spacingXS),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Implementasi "Filter"
                        },
                        icon: const Icon(
                          Icons.filter_list,
                          color: AppColors.textColor,
                          size: AppIconSize.iconS,
                        ),
                        label: const Text(
                          'Filter',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: AppFontSize.fontSizeMS,
                            fontWeight: AppFontWeight.semiBold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.spacingM,
              vertical: AppSpacing.spacingM,
            ),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.63,
                mainAxisSpacing: AppSpacing.spacingMS,
                crossAxisSpacing: AppSpacing.spacingMS,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return DetailedProductCard(
                    imageUrl:
                        'https://www.agromonti.com/wp-content/uploads/2020/08/FUNGICIDE-ACTIGARD-1.jpg', // Ganti dengan URL gambar produk
                    name: 'Actigard COYY',
                    brand: 'Actigard',
                    price: 20000,
                    storeName: 'Toko Tanaman Sehat',
                    location: 'Kota Malang',
                  );
                },
                childCount: 8, // Jumlah item contoh
              ),
            ),
          ),
        ],
      ),
    );
  }
}
