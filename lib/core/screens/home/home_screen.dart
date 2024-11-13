import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/core/widgets/common/diagnosis_item.dart';
import 'package:leafolyze/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSpacing.spacingM),
            child: Column(
              children: [
                _buildGreetingSection(),
                SizedBox(height: AppSpacing.spacingL),
                _buildWateringReminder(),
                SizedBox(height: AppSpacing.spacingM),
                _buildArticleSection(
                  onPressed: () {
                    context.go('/home/article');
                  },
                ),
                SizedBox(height: AppSpacing.spacingL),
                _buildRecentDiagnosis(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildGreetingSection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, John',
            style: AppTextStyles.heading3,
          ),
          Text(
            'Good Morning!',
            style: AppTextStyles.heading2,
          ),
        ],
      ),
      CircleAvatar(
        radius: 20,
        backgroundImage: NetworkImage(
            'https://awsimages.detik.net.id/community/media/visual/2018/03/03/39f24229-6f26-4a17-aa92-44c3bd3dae9e_43.jpeg?w=600&q=90'),
      ),
    ],
  );
}

Widget _buildWateringReminder() {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        padding: EdgeInsets.all(AppSpacing.spacingL),
        decoration: BoxDecoration(
          color: AppColors.primaryColorLight,
          borderRadius: BorderRadius.circular(AppBorderRadius.radiusS),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 9),
              blurRadius: 15.3,
              color: Colors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 190,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Watering Reminder!',
                    style: AppTextStyles.headingCard,
                  ),
                  SizedBox(height: AppSpacing.spacingXXS),
                  Text(
                    'Give enough water to maximize plant growth',
                    style: AppTextStyles.contentCard,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        right: 0,
        bottom: -12,
        child: Image.asset(
          'assets/images/image-13.png',
          fit: BoxFit.cover,
        ),
      ),
    ],
  );
}

Widget _buildArticleSection({required Function() onPressed}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Explore Article',
            style: AppTextStyles.heading3,
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              'See all',
              style: AppTextStyles.actionTextStyle2,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Container(
                  width: 240,
                  margin: EdgeInsets.only(right: AppSpacing.spacingS),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppBorderRadius.radiusS),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/ren-ran-bBiuSdck8tU-unsplash.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 240,
                  margin: EdgeInsets.only(right: AppSpacing.spacingS),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppBorderRadius.radiusS),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.7],
                    ),
                  ),
                  padding: EdgeInsets.all(AppSpacing.spacingS),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bacterial Spot',
                        style: AppTextStyles.headingCard2,
                      ),
                      SizedBox(height: AppSpacing.spacingS),
                      SizedBox(
                        width: 160,
                        child: Text(
                          'Lorem ipsum odor amet, consectetuer adipiscing elit. Sodales proin luctus vestibulum',
                          style: AppTextStyles.contentCard2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ],
  );
}

Widget _buildRecentDiagnosis() {
  // Sample data
  final List<Map<String, String>> diagnosisItems = [
    {
      'imagePath': 'assets/images/ren-ran-bBiuSdck8tU-unsplash.jpg',
      'plantName': 'Tomato',
      'diseaseName': 'Bacterial Spot',
    },
    {
      'imagePath': 'assets/images/ren-ran-bBiuSdck8tU-unsplash.jpg',
      'plantName': 'Potato',
      'diseaseName': 'Early Blight',
    },
    {
      'imagePath': 'assets/images/ren-ran-bBiuSdck8tU-unsplash.jpg',
      'plantName': 'Corn',
      'diseaseName': 'Gray Leaf Spot',
    },
  ];

  // final displayedItems = diagnosisItems.take(3).toList();

  return Container(
    padding: EdgeInsets.fromLTRB(
      AppSpacing.spacingS,
      0,
      AppSpacing.spacingS,
      AppSpacing.spacingMS,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppBorderRadius.radiusM),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 0),
          blurRadius: 15,
          color: Colors.black.withOpacity(0.08),
        ),
      ],
    ),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacingXS),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  'Recent Diagnosis',
                  style: AppTextStyles.heading3,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Center(
                  child: Text('See all', style: AppTextStyles.actionTextStyle2),
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: diagnosisItems.length,
          separatorBuilder: (context, index) =>
              SizedBox(height: AppSpacing.spacingS),
          itemBuilder: (context, index) {
            final item = diagnosisItems[index];
            return DiagnosisItem(
              imagePath: item['imagePath']!,
              plantName: item['plantName']!,
              diseaseName: item['diseaseName']!,
              onTap: () {
                // Handle tap for specific item
              },
            );
          },
        ),
      ],
    ),
  );
}
