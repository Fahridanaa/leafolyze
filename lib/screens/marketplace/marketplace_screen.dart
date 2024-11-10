import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';
import 'package:leafolyze/widgets/common/custom_search_bar.dart';
import 'package:leafolyze/widgets/marketplace/product_card.dart';

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
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: const Text('Marketplace'),
            floating: true,
            snap: true,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomSearchBar(
                    // TODO: Implement search functionality
                    onChanged: (value) {},
                    onSubmitted: (value) {},
                  ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: filters.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedFilterIndex == index;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          showCheckmark: false,
                          label: Text(
                            filters[index],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            setState(() {
                              selectedFilterIndex = index;
                            });
                          },
                          backgroundColor: Colors.white,
                          selectedColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected
                                  ? Colors.transparent
                                  : Colors.black,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft, // Add this
                    child: Text(
                      'Obat Tanaman',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ProductCard(
                      id: product['id'],
                      // imageUrl: product['image'],
                      name: product['name'],
                      price: product['price'],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
