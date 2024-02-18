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
        // appBar: AppBar(
        //   title: Text("Papers and Instructors"),
        // ),
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
                  "Add new...",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: AppColors.black),
                ),
                const Gap(35),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const BottomBarScreen(
                                      isEntryScreen: true,
                                      isInstructorScreen: false,
                                      isAddFolderScreen: false,
                                    )));
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
                                            color: AppColors.purple,
                                            width: 1.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 75,
                                left: 45,
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            offset: const Offset(
                                              0.0,
                                              5.0,
                                            ),
                                            blurRadius: 10.0,
                                            spreadRadius: 2.0,
                                          ), //BoxShadow
                                          const BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0,
                                          ), //BoxShadow
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.ligthWhite),
                                    child: const CircleAvatar(
                                        backgroundColor: AppColors.ligthWhite,
                                        child: Icon(Icons.add)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 5,
                                top: 0,
                                child: Container(
                                  // height: 35,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(
                                          0.0,
                                          5.0,
                                        ),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      ), //BoxShadow
                                      const BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ],
                                    color: AppColors.ligthWhite,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Center(
                                      child: FittedBox(
                                    child: Text(
                                      'Add a new entity',
                                      style: TextStyle(
                                          fontSize: 12, color: AppColors.black),
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
                                      isInstructorScreen: true,
                                      isAddFolderScreen: false,
                                    )));
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
                                            color: AppColors.red, width: 2.0),
                                        bottom: BorderSide(
                                            color: AppColors.blue, width: 1.0),
                                        left: BorderSide(
                                            color: AppColors.green, width: 1.0),
                                        right: BorderSide(
                                            color: AppColors.purple,
                                            width: 1.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 75,
                                left: 45,
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            offset: const Offset(
                                              0.0,
                                              5.0,
                                            ),
                                            blurRadius: 10.0,
                                            spreadRadius: 2.0,
                                          ), //BoxShadow
                                          const BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0,
                                          ), //BoxShadow
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.ligthWhite),
                                    child: const CircleAvatar(
                                        backgroundColor: AppColors.ligthWhite,
                                        child: Icon(Icons.add)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 1,
                                top: 0,
                                child: Container(
                                  height: 35,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(
                                          0.0,
                                          5.0,
                                        ),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      ), //BoxShadow
                                      const BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ],
                                    color: AppColors.ligthWhite,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Center(
                                      child: FittedBox(
                                    child: Text(
                                      'Add a new instructor',
                                      style: TextStyle(
                                          fontSize: 12, color: AppColors.black),
                                    ),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Gap(40),
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
                                      isAddFolderScreen: true,
                                    )));
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
                                            color: AppColors.purple,
                                            width: 1.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 75,
                                left: 45,
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            offset: const Offset(
                                              0.0,
                                              5.0,
                                            ),
                                            blurRadius: 10.0,
                                            spreadRadius: 2.0,
                                          ), //BoxShadow
                                          const BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(0.0, 0.0),
                                            blurRadius: 0.0,
                                            spreadRadius: 0.0,
                                          ), //BoxShadow
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                        color: AppColors.ligthWhite),
                                    child: const CircleAvatar(
                                        backgroundColor: AppColors.ligthWhite,
                                        child: Icon(Icons.add)),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 17,
                                top: 0,
                                child: Container(
                                  // height: 35,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: const Offset(
                                          0.0,
                                          5.0,
                                        ),
                                        blurRadius: 10.0,
                                        spreadRadius: 2.0,
                                      ), //BoxShadow
                                      const BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                        spreadRadius: 0.0,
                                      ), //BoxShadow
                                    ],
                                    color: AppColors.ligthWhite,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Center(
                                      child: FittedBox(
                                    child: Text(
                                      'Add a folder',
                                      style: TextStyle(
                                          fontSize: 12, color: AppColors.black),
                                    ),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Gap(40),
                        const SizedBox(
                          height: 170,
                          width: 130,
                        )
                      ],
                    ),
                  ],
                ),

                // Stack(
                //   children: [
                //     Container(
                //       height: 170,
                //       width: 130,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
                //         border: Border.all(color: AppColors.red, width: 2.0),
                //       ),
                //     ),
                //     Container(
                //       height: 170,
                //       width: 130,
                //       decoration: BoxDecoration(
                //         border: Border(
                //           bottom: BorderSide(color: AppColors.blue, width: 1.0),
                //           left: BorderSide(color: AppColors.green, width: 1.0),
                //           right:
                //               BorderSide(color: AppColors.purple, width: 1.0),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ));
  }
}
