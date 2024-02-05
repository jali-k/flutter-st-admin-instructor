import 'package:educator_app/screens/bottomBar_screen/bottom_bar_screen.dart';
import 'package:educator_app/screens/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backGround,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(80),
                const Text(
                  "Some Topic",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: AppColors.black),
                ),
                const Gap(35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BottomBarScreen(
                                isEntryScreen: true,
                                isInstructorScreen: false)));
                      },
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              const Gap(15),
                              Container(
                                height: 170,
                                width: 130,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        color: AppColors.red, width: 1.0),
                                    bottom: BorderSide(
                                        color: AppColors.blue, width: 1.0),
                                    left: BorderSide(
                                        color: AppColors.green, width: 1.0),
                                    right: BorderSide(
                                        color: AppColors.purple, width: 1.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Positioned(
                            top: 75,
                            left: 45,
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircleAvatar(
                                  backgroundColor: AppColors.ligthWhite,
                                  child: Icon(Icons.add)),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 0,
                            child: Container(
                              height: 35,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColors.ligthWhite,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                  child: FittedBox(
                                child: Text(
                                  'Add a new entity',
                                  style: TextStyle(
                                      fontSize: 8, color: AppColors.black),
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Gap(40),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const BottomBarScreen(
                                isEntryScreen: false,
                                isInstructorScreen: true)));
                      },
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              const Gap(15),
                              Container(
                                height: 170,
                                width: 130,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        color: AppColors.red, width: 1.0),
                                    bottom: BorderSide(
                                        color: AppColors.blue, width: 1.0),
                                    left: BorderSide(
                                        color: AppColors.green, width: 1.0),
                                    right: BorderSide(
                                        color: AppColors.purple, width: 1.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Positioned(
                            top: 75,
                            left: 45,
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CircleAvatar(
                                  backgroundColor: AppColors.ligthWhite,
                                  child: Icon(Icons.add)),
                            ),
                          ),
                          Positioned(
                            left: 12,
                            top: 0,
                            child: Container(
                              height: 35,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: AppColors.ligthWhite,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                  child: FittedBox(
                                child: Text(
                                  'Add a new instructor',
                                  style: TextStyle(
                                      fontSize: 8, color: AppColors.black),
                                ),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
