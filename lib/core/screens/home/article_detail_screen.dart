import 'package:flutter/material.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Artikel Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman yang diinginkan (misalnya, DetailHalaman.dart)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ArticleDetailScreen(),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/articledetail.jpg',
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
               const SizedBox(height: 10),
              const Text(
              '2 min read',                
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Bacterical Spot',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
               const SizedBox(height: 8),
              const Text(
                'Lorem ipsum dolor amet, consectetuer adipiscing elit. Sodales proin luctus vestibulum leo fames elementum adipiscing. Laoreet tempor ex ex lobortis justo porta. Curabitur eros rutrum quisque; morbi cras vulputate dictum. Sagittis aliquet rhoncus ultrices morbi aliquet habitasse sociosqu facilisis. Augue augue himenaeos lectus sit interdum. Ut imperdiet et dis posuere viverra turpis. Vestibulum quam consectetur fringilla platea inceptos.',
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}