import 'package:flutter/material.dart';
import 'package:leafolyze/widgets/detailed_product_card.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String? selectedSortOption = 'Recently Added';

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Sort By',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
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
              activeColor: Colors.black,
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
              activeColor: Colors.black,
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
              activeColor: Colors.black,
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
              activeColor: Colors.black,
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
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: const Text('Actigard'),
            floating: true,
            snap: true,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search here...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
          ),
          // Sort By and Filter
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showSortOptions(context);
                      },
                      icon: const Icon(Icons.sort, color: Colors.black),
                      label: const Text('Sort By',
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Implementasi "Filter"
                      },
                      icon: const Icon(Icons.filter_list, color: Colors.black),
                      label: const Text('Filter',
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Product Grid
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
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
