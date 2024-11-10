import 'package:flutter/material.dart';
import 'package:leafolyze/widgets/home/article_item_card.dart';
import 'package:leafolyze/widgets/common/custom_search_bar.dart';

class ArticleListScreen extends StatelessWidget {
  const ArticleListScreen({super.key});

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
              child: CustomSearchBar(
                // TODO: Implement search functionality
                onChanged: (value) {},
                onSubmitted: (value) {},
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ArticleItemCard(
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
