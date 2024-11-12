import 'package:flutter/material.dart';
import 'package:leafolyze/core/widgets/common/diagnosis_item.dart';
import 'package:leafolyze/core/widgets/common/custom_search_bar.dart';

final List<Map<String, String>> diagnosisData = [
  {
    'imagePath': 'assets/images/ren-ran-bBiuSdck8tU-unsplash.jpg',
    'plantName': 'Tomato',
    'diseaseName': 'Tomato Leaf Disease',
  },
];

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              'History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 28),
                  CustomSearchBar(
                    onChanged: (value) {},
                    onSubmitted: (value) {},
                  ),
                  const SizedBox(height: 16),
                  ...diagnosisData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index != diagnosisData.length - 1 ? 16.0 : 0,
                      ),
                      child: DiagnosisItem(
                        imagePath: data['imagePath']!,
                        plantName: data['plantName']!,
                        diseaseName: data['diseaseName']!,
                      ),
                    );
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
