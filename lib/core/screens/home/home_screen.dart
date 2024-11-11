import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/core/widgets/common/diagnosis_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 58),
          child: Column(
            children: [
              _buildGreetingSection(),
              SizedBox(height: 24),
              _buildWateringReminder(),
              SizedBox(height: 24),
              _buildArticleSection(
                onPressed: () {
                  context.go('/home/article');
                },
              ),
              SizedBox(height: 24),
              _buildRecentDiagnosis(),
            ],
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
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            'Good Morning!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
        padding: EdgeInsets.symmetric(vertical: 28.5, horizontal: 24),
        decoration: BoxDecoration(
          color: Color(0xFFF0F8DA),
          borderRadius: BorderRadius.circular(12),
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
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF242C0E)),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Give enough water to maximize plant growth',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF5A6D23),
                        fontWeight: FontWeight.w500),
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
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              'See all',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF5A6D23),
                fontWeight: FontWeight.w500,
              ),
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
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/ren-ran-bBiuSdck8tU-unsplash.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 240,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
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
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bacterial Spot',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: 160,
                        child: Text(
                          'Lorem ipsum odor amet, consectetuer adipiscing elit. Sodales proin luctus vestibulum',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
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
    padding: EdgeInsets.fromLTRB(8, 0, 8, 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
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
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Text(
                  'Recent Diagnosis',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Center(
                  child: Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF5A6D23),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
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
          separatorBuilder: (context, index) => SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = diagnosisItems[index];
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xFFF8FAFC),
                border: Border.all(
                  color: Color(0xFFBFC2C8).withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DiagnosisItem(
                imagePath: item['imagePath']!,
                plantName: item['plantName']!,
                diseaseName: item['diseaseName']!,
                onTap: () {
                  // Handle tap for specific item
                },
              ),
            );
          },
        ),
      ],
    ),
  );
}
