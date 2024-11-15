import 'package:flutter/material.dart';
import 'package:leafolyze/core/widgets/common/diagnosis_item.dart';
import 'package:leafolyze/core/widgets/common/custom_search_bar.dart';
import 'package:leafolyze/utils/constants.dart';

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
        shrinkWrap: true,
        scrollBehavior: const ScrollBehavior().copyWith(
          overscroll: false,
        ),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: const Text(
              'History',
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
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.spacingM),
              child: Column(
                children: [
                  CustomSearchBar(
                    onChanged: (value) {},
                    onSubmitted: (value) {},
                  ),
                  const SizedBox(height: AppSpacing.spacingM),
                  ...diagnosisData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index != diagnosisData.length - 1
                            ? AppSpacing.spacingM
                            : 0,
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
