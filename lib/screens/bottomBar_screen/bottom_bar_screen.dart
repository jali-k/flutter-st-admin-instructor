import 'package:educator_app/screens/entry_screen/entry_screen.dart';
import 'package:educator_app/screens/home_screen/home_screen.dart';
import 'package:educator_app/screens/instructor_screen/instructor_screen.dart';
import 'package:educator_app/screens/res/app_colors.dart';
import 'package:flutter/material.dart';

class BottomBarScreen extends StatefulWidget {
  final bool isEntryScreen;
  final bool isInstructorScreen;
  const BottomBarScreen(
      {super.key,
      required this.isEntryScreen,
      required this.isInstructorScreen});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late int _selectedBottomNavBarItemIndex;
  final List<Widget> bottomNavBarItems = <Widget>[];

  @override
  void initState() {
    // ignore: use_build_context_synchronously

    widget.isEntryScreen
        ? _selectedBottomNavBarItemIndex = 1
        : widget.isInstructorScreen
            ? _selectedBottomNavBarItemIndex = 2
            : _selectedBottomNavBarItemIndex = 0;

    bottomNavBarItems.addAll(
        [const HomeScreen(), const EntryScreen(), const InstructorScreen()]);

    super.initState();
  }

  void _onBottomNavBarItemTapped(int index) {
    setState(() {
      _selectedBottomNavBarItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 35),
        child: Card(
          elevation: 15,
          shadowColor: Colors.black.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Set border radius
          ),
          child: Container(
            // decoration: BoxDecoration(
            //   border: Border.all(color: AppColors.purple, width: 1),
            // ),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              elevation: 1,
              backgroundColor: AppColors.ligthWhite,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.file_copy), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
              ],
              currentIndex: _selectedBottomNavBarItemIndex,
              selectedItemColor: AppColors.green,
              onTap: _onBottomNavBarItemTapped,
              unselectedItemColor: AppColors.black,
            ),
          ),
        ),
      ),
      body: Container(
          color: AppColors.ligthWhite,
          child: bottomNavBarItems[_selectedBottomNavBarItemIndex]),
    );
  }
}
