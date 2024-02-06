import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educator_app/models/model.dart';
import 'package:educator_app/screens/instructor_screen/instructor_entry_screen.dart';
import 'package:educator_app/screens/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExistingInstructorScreen extends StatefulWidget {
  const ExistingInstructorScreen({super.key});

  @override
  State<ExistingInstructorScreen> createState() =>
      _ExistingInstructorScreenState();
}

class _ExistingInstructorScreenState extends State<ExistingInstructorScreen> {
  List<Instructor> instructor = [];
  List<DocumentSnapshot> data = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('instructor')
        .orderBy('id', descending: false)
        .get();
    setState(() {
      data.addAll(querySnapshot.docs);
      data.forEach((email) {
        instructor.add(Instructor(
            instructorId: email['instructorId'],
            email: email['email'],
            docId: ''));
      });
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(80),
            const Center(
              child: Text(
                "Manage Instructors",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: AppColors.black),
              ),
            ),
            const Gap(50),
            RichText(
                text: const TextSpan(children: [
              TextSpan(
                text: 'Available ',
                style: TextStyle(color: AppColors.black),
              ),
              TextSpan(
                text: ' Instructors',
                style: TextStyle(color: AppColors.green),
              ),
            ])),
            const Gap(10),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : instructor.isEmpty
                      ? const Center(
                          child: Text(
                            'No instructors',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.black),
                          ),
                        )
                      : ListView.builder(
                          itemCount: instructor.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  // height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.ligthWhite,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              instructor[index].email,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black),
                                            ),
                                            const Text(
                                              'email',
                                              style: TextStyle(
                                                  color: AppColors.black),
                                            )
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const InstructorEntryScreen()));
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                            color: AppColors.blue,
                                          ))
                                    ],
                                  ),
                                ),
                                const Gap(10),
                              ],
                            );
                          }),
            )
          ],
        ),
      ),
    );
  }
}
