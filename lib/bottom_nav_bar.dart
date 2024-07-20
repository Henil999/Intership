import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:placement_app/screens/applied_companies/applied.dart';
import 'package:placement_app/profile/profile.dart';
import 'package:placement_app/screens/home/home_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;
  getScreen(int index, BuildContext context) {
    List<Widget> screens = [
      HomeScreen.builder(context),
      AppliedCompanies.builder(context),
      ProfilePage.builder(context),
    ];
    return screens[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getScreen(_currentIndex, context),
      bottomNavigationBar: CustomNavigationBar(
        iconSize: 30.0,
        selectedColor: Color(0xff040307),
        strokeColor: Color(0x30040307),
        unSelectedColor: Color(0xffacacac),
        backgroundColor: Colors.white,
        items: [
          CustomNavigationBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            title: const Text("Applied"),
          ),
          CustomNavigationBarItem(
            icon: const Icon(Icons.account_circle),
            title: const Text("Profile"),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
