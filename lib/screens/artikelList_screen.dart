import 'package:flutter/material.dart';
import 'package:leafolyze/widgets/artikel_item_card.dart';

class ArtikelListScreen extends StatelessWidget {
  const ArtikelListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: const Text(
              'Articles',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search here...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ArtikelCard(
                  imageUrl:
                      'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/222/2024/05/28/IMG-20240528-WA0105-1208872859.jpg',
                  title: 'Bacterial Spot',
                  description:
                      'Lorem ipsum dolor amet, consectetur adipiscing elit. Sodales proin luctus vestibulum.',
                );
              },
              childCount: 6, // Jumlah artikel contoh
            ),
          ),
        ],
      ),
    );
  }
}
