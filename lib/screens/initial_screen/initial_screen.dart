import 'package:educator_app/screens/bottomBar_screen/bottom_bar_screen.dart';
import 'package:educator_app/screens/instructor_screen/existing_instructor_screen.dart';
import 'package:educator_app/screens/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
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
                                  isEntryScreen: false,
                                  isInstructorScreen: false,
                                  isAddFolderScreen: false,
                                )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 170,
                          width: 130,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: AppColors.red, width: 1.0),
                              bottom:
                                  BorderSide(color: AppColors.blue, width: 1.0),
                              left: BorderSide(
                                  color: AppColors.green, width: 1.0),
                              right: BorderSide(
                                  color: AppColors.purple, width: 1.0),
                            ),
                            // borderRadius: BorderRadius.circular(25)
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ),
                    ),
                    const Gap(40),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const ExistingInstructorScreen()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 170,
                          width: 130,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: AppColors.red, width: 1.0),
                              bottom:
                                  BorderSide(color: AppColors.blue, width: 1.0),
                              left: BorderSide(
                                  color: AppColors.green, width: 1.0),
                              right: BorderSide(
                                  color: AppColors.purple, width: 1.0),
                            ),
                            // borderRadius: BorderRadius.circular(25)
                          ),
                          child: const Icon(Icons.file_copy),
                        ),
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
