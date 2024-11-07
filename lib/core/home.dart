import 'package:flutter/material.dart';
import 'package:leafolyze/constants/color.dart';
import 'package:leafolyze/screens/camera_screen.dart';
import 'package:leafolyze/screens/profileScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.index});

  final int? index;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _screens = [
    Center(child: Text("Home Page")),
    Center(child: Text("Favorites Page")),
    CameraScreen(),
    Center(child: Text("History Page")),
    ProfileScreen(
      name: 'Muhammad Ridlo Febrio',
      email: '2241720098@gmail.com',
      profileImageUrl:
          'https://awsimages.detik.net.id/community/media/visual/2018/03/03/39f24229-6f26-4a17-aa92-44c3bd3dae9e_43.jpeg?w=600&q=90',
    )
  ];

  late int _currentScreenIndex = widget.index ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentScreenIndex],
      bottomNavigationBar: _currentScreenIndex == 2
          ? null
          : BottomNavigationBar(
              currentIndex: _currentScreenIndex,
              onTap: _onTabSelected,
              backgroundColor: Colors.white,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_mall),
                  label: 'Market',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.camera_alt),
                  label: 'Scan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
      floatingActionButton: _currentScreenIndex == 2
          ? null
          : FloatingActionButton(
              backgroundColor: AppColors.GreenLogodanButton,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              onPressed: () => _onTabSelected(2),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onTabSelected(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CameraScreen()),
      ).then((_) {
        setState(() {
          _currentScreenIndex = 0;
        });
      });
    } else {
      setState(() {
        _currentScreenIndex = index;
      });
    }
  }
}
