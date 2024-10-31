import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key, this.index});

  final int? index;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> _screens = const [
    Center(child: Text("Home Page")),
    Center(child: Text("Favorites Page")),
    Center(child: Text("Scan Page")),
    Center(child: Text("History Page")),
    Center(child: Text("Profile Page")),
  ];

  late int _currentScreenIndex;

  @override
  void initState() {
    super.initState();
    _currentScreenIndex = widget.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentScreenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentScreenIndex,
        onTap: _onTabSelected,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal, // Warna untuk ikon yang dipilih
        unselectedItemColor: Colors.grey, // Warna untuk ikon yang tidak dipilih
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal, // Warna untuk tombol tengah
        child: const Icon(Icons.camera_alt),
        onPressed: () => _onTabSelected(2),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentScreenIndex = index;
    });
  }
}
