import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educator_app/models/model.dart';
import 'package:educator_app/screens/entry_screen/add_marks.dart';
import 'package:educator_app/screens/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InstructorEntryScreen extends StatefulWidget {
  const InstructorEntryScreen({super.key});

  @override
  State<InstructorEntryScreen> createState() => _InstructorEntryScreenState();
}

class _InstructorEntryScreenState extends State<InstructorEntryScreen> {
  List<DocumentSnapshot> papers = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPapers();
  }

  Future<void> fetchPapers() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('papers')
        .orderBy('id', descending: false)
        .get();
    setState(() {
      papers.addAll(querySnapshot.docs);
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Gap(80),
            const Center(
              child: Text(
                "Some Topic",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: AppColors.black),
              ),
            ),
            const Gap(50),
            Text(
              '${papers.length.toString()} new entries',
              style: const TextStyle(color: AppColors.green),
            ),
            const Gap(10),
            Expanded(
              child: Center(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : papers.isEmpty
                        ? const Center(
                            child: Text(
                              'No papers',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black),
                            ),
                          )
                        : ListView.builder(
                            itemCount: papers.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map<String, dynamic> data =
                                  papers[index].data()! as Map<String, dynamic>;
                              String paperName = data['paperName'];
                              String paperId = data['paperId'];
                              bool mcq = data['isMcq'];
                              bool structure = data['isStructured'];
                              bool essay = data['isEssay'];
                              return Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    // height: 60,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColors.ligthWhite,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data['paperName'],
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black),
                                              ),
                                              Row(
                                                children: [
                                                  Visibility(
                                                    visible: mcq,
                                                    child: const SizedBox(
                                                      height: 10,
                                                      width: 20,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            AppColors.purple,
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: structure,
                                                    child: const SizedBox(
                                                      height: 10,
                                                      width: 20,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            AppColors.green,
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: essay,
                                                    child: const SizedBox(
                                                      height: 10,
                                                      width: 20,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            AppColors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                                                          AddMarks(
                                                            paper: Paper(
                                                                paperId:
                                                                    paperId,
                                                                paperName:
                                                                    paperName,
                                                                isMcq: mcq,
                                                                isStructure:
                                                                    structure,
                                                                isEssay: essay),
                                                          )));
                                            },
                                            icon: const Icon(
                                              Icons.arrow_forward,
                                              color: AppColors.blue,
                                            ))
                                      ],
                                    ),
                                  ),
                                  const Gap(10)
                                ],
                              );
                            }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
