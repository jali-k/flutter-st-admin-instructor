import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educator_app/globals.dart';
import 'package:educator_app/models/model.dart';
import 'package:educator_app/popups/loading_popup.dart';
import 'package:educator_app/screens/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddMarks extends StatefulWidget {
  final Paper paper;
  const AddMarks({super.key, required this.paper});

  @override
  State<AddMarks> createState() => _AddMarksState();
}

class _AddMarksState extends State<AddMarks> {
  final studentIdController = TextEditingController();
  final mcqController = TextEditingController();
  final structureController = TextEditingController();
  final essayController = TextEditingController();
  final totalMarksController = TextEditingController();
  List<TableRow> rows = [];
  List<DocumentSnapshot> marks = [];
  int addCount = 0;
  bool isLoading = false;
  int totalValidationMarks = 0;
  List<int> studentIds = [];

  @override
  void initState() {
    super.initState();
    rows.add(
      TableRow(
        children: [
          TableCell(
              child: Container(
                  height: 40,
                  color: AppColors.ligthWhite,
                  child: const Center(
                      child: FittedBox(
                    child: Text(
                      'Student id',
                      style: TextStyle(color: AppColors.black, fontSize: 10),
                    ),
                  )))),
          TableCell(
              child: Container(
                  height: 40,
                  color: widget.paper.isMcq
                      ? AppColors.ligthWhite
                      : AppColors.grey,
                  child: const Center(
                      child: FittedBox(
                    child: Text('Mcq',
                        style: TextStyle(color: AppColors.black, fontSize: 10)),
                  )))),
          TableCell(
              child: Container(
                  height: 40,
                  color: widget.paper.isStructure
                      ? AppColors.ligthWhite
                      : AppColors.grey,
                  child: const Center(
                      child: FittedBox(
                    child: Text('Structured',
                        style: TextStyle(color: AppColors.black, fontSize: 10)),
                  )))),
          TableCell(
              child: Container(
                  height: 40,
                  color: widget.paper.isEssay
                      ? AppColors.ligthWhite
                      : AppColors.grey,
                  child: const Center(
                      child: FittedBox(
                    child: Text('Essay',
                        style: TextStyle(color: AppColors.black, fontSize: 10)),
                  )))),
          TableCell(
              child: Container(
                  height: 40,
                  color: AppColors.ligthWhite,
                  child: const Center(
                      child: FittedBox(
                    child: Text(
                      'Total marks',
                      style: TextStyle(color: AppColors.black, fontSize: 10),
                    ),
                  )))),
        ],
      ),
    );
    fetchPaperMarks();
  }

  void fetchPaperMarks() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('marks')
        .where('paperId', isEqualTo: widget.paper.paperId)
        .orderBy('studentId', descending: false)
        .get();
    setState(() {
      isLoading = false;
    });
    setState(() {
      marks.addAll(querySnapshot.docs);
      if (marks.isNotEmpty) {
        marks.forEach((element) {
          Map<String, dynamic> data = element.data()! as Map<String, dynamic>;
          int? mcq = data['mcqMarks'];
          int? structure = data['structuredMarks'];
          int? essay = data['essayMarks'];
          int studentId = data['studentId'];
          int totalMarks = data['totalMarks'];
          studentIds.add(studentId);
          rows.add(
            TableRow(
              children: [
                TableCell(
                    child: Container(
                        height: 40,
                        color: AppColors.ligthWhite,
                        child: Center(
                            child: Text(
                          studentId.toString(),
                          style: const TextStyle(color: AppColors.black),
                        )))),
                TableCell(
                    child: Container(
                        height: 40,
                        color: widget.paper.isMcq
                            ? AppColors.ligthWhite
                            : AppColors.grey,
                        child: Center(
                            child: Text(mcq != null ? mcq.toString() : '',
                                style:
                                    const TextStyle(color: AppColors.black))))),
                TableCell(
                    child: Container(
                        height: 40,
                        color: widget.paper.isStructure
                            ? AppColors.ligthWhite
                            : AppColors.grey,
                        child: Center(
                            child: Text(
                                structure != null ? structure.toString() : '',
                                style:
                                    const TextStyle(color: AppColors.black))))),
                TableCell(
                    child: Container(
                        height: 40,
                        color: widget.paper.isEssay
                            ? AppColors.ligthWhite
                            : AppColors.grey,
                        child: Center(
                            child: Text(essay != null ? essay.toString() : '',
                                style:
                                    const TextStyle(color: AppColors.black))))),
                TableCell(
                    child: Container(
                        height: 40,
                        color: AppColors.ligthWhite,
                        child: Center(
                            child: Text(
                          totalMarks.toString(),
                          style: const TextStyle(color: AppColors.black),
                        )))),
              ],
            ),
          );
        });
      }
    });
  }

  Future<void> addMarks({
    required String paperId,
    required int studentId,
    required int? mcq,
    required int? structured,
    required int? essay,
    required int total,
  }) async {
    try {
      final loading = LoadingPopup(context);
      loading.show();
      await FirebaseFirestore.instance
          .collection('marks') // Reference to the collection
          .add({
        'paperId': paperId,
        'studentId': studentId,
        'mcqMarks': mcq,
        'structuredMarks': structured,
        'essayMarks': essay,
        'totalMarks': total
      });
      loading.dismiss();

      // ignore: use_build_context_synchronously
      Globals.showSnackBar(
          context: context, isSuccess: true, message: 'Success');
      setState(() {
        addCount = 0;

        rows.removeLast();
        rows.add(
          TableRow(
            children: [
              TableCell(
                  child: Container(
                      height: 40,
                      color: AppColors.ligthWhite,
                      child: Center(
                          child: Text(
                        studentIdController.text,
                        style: const TextStyle(color: AppColors.black),
                      )))),
              TableCell(
                  child: Container(
                      height: 40,
                      color: widget.paper.isMcq
                          ? AppColors.ligthWhite
                          : AppColors.grey,
                      child: Center(
                          child: Text(mcqController.text,
                              style:
                                  const TextStyle(color: AppColors.black))))),
              TableCell(
                  child: Container(
                      height: 40,
                      color: widget.paper.isStructure
                          ? AppColors.ligthWhite
                          : AppColors.grey,
                      child: Center(
                          child: Text(structureController.text,
                              style:
                                  const TextStyle(color: AppColors.black))))),
              TableCell(
                  child: Container(
                      height: 40,
                      color: widget.paper.isEssay
                          ? AppColors.ligthWhite
                          : AppColors.grey,
                      child: Center(
                          child: Text(essayController.text,
                              style:
                                  const TextStyle(color: AppColors.black))))),
              TableCell(
                  child: Container(
                      height: 40,
                      color: AppColors.ligthWhite,
                      child: Center(
                          child: Text(
                        totalMarksController.text,
                        style: const TextStyle(color: AppColors.black),
                      )))),
            ],
          ),
        );
        studentIds.add(int.parse(studentIdController.text));
        studentIdController.clear();
        mcqController.clear();
        structureController.clear();
        essayController.clear();
        totalMarksController.clear();
      });
    } catch (error) {
      // ignore: avoid_print
      print("Failed to add user: $error");
    }
  }

  void _addRow() {
    setState(() {
      if (addCount == 0) {
        rows.add(
          TableRow(
            children: [
              TableCell(
                  child: SizedBox(
                      height: 40,
                      child: Center(
                          child: TextFormField(
                        style: const TextStyle(
                            color: AppColors.black, fontSize: 12),
                        textAlign: TextAlign.center,
                        controller: studentIdController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: AppColors.ligthWhite,
                          hintStyle:
                              TextStyle(color: AppColors.black, fontSize: 12),
                          hintText: 'Enter',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.black,
                              // width: 1.5,
                            ),
                          ), // Remove the default border
                          enabledBorder: UnderlineInputBorder(
                            // Add bottom line as enabled border
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                        ),
                      )))),
              TableCell(
                  child: SizedBox(
                      height: 40,
                      child: Center(
                          child: TextFormField(
                        style: const TextStyle(
                            color: AppColors.black, fontSize: 12),
                        textAlign: TextAlign.center,
                        enabled: widget.paper.isMcq,
                        controller: mcqController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: widget.paper.isMcq
                              ? AppColors.ligthWhite
                              : AppColors.grey,
                          hintStyle: const TextStyle(
                              color: AppColors.black, fontSize: 12),
                          hintText: widget.paper.isMcq ? 'Enter' : '',
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.black,
                              // width: 1.5,
                            ),
                          ), // Remove the default border
                          enabledBorder: const UnderlineInputBorder(
                            // Add bottom line as enabled border
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                        ),
                      )))),
              TableCell(
                  child: SizedBox(
                      height: 40,
                      child: Center(
                          child: TextFormField(
                        style: const TextStyle(
                            color: AppColors.black, fontSize: 12),
                        textAlign: TextAlign.center,
                        enabled: widget.paper.isStructure,
                        controller: structureController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: widget.paper.isStructure
                              ? AppColors.ligthWhite
                              : AppColors.grey,
                          hintStyle: const TextStyle(
                              color: AppColors.black, fontSize: 12),
                          hintText: widget.paper.isStructure ? 'Enter' : '',
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.black,
                              // width: 1.5,
                            ),
                          ), // Remove the default border
                          enabledBorder: const UnderlineInputBorder(
                            // Add bottom line as enabled border
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                        ),
                      )))),
              TableCell(
                  child: SizedBox(
                      height: 40,
                      child: Center(
                          child: TextFormField(
                        style: const TextStyle(
                            color: AppColors.black, fontSize: 12),
                        textAlign: TextAlign.center,
                        enabled: widget.paper.isEssay,
                        controller: essayController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: widget.paper.isEssay
                              ? AppColors.ligthWhite
                              : AppColors.grey,
                          hintStyle: const TextStyle(
                              color: AppColors.black, fontSize: 12),
                          hintText: widget.paper.isEssay ? 'Enter' : '',
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.black,
                              // width: 1.5,
                            ),
                          ), // Remove the default border
                          enabledBorder: const UnderlineInputBorder(
                            // Add bottom line as enabled border
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                        ),
                      )))),
              TableCell(
                  child: SizedBox(
                      height: 40,
                      child: Center(
                          child: TextFormField(
                        style: const TextStyle(
                            color: AppColors.black, fontSize: 12),
                        textAlign: TextAlign.center,
                        controller: totalMarksController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: AppColors.ligthWhite,
                          hintStyle:
                              TextStyle(color: AppColors.black, fontSize: 12),
                          hintText: 'Enter',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.black,
                              // width: 1.5,
                            ),
                          ), // Remove the default border
                          enabledBorder: UnderlineInputBorder(
                            // Add bottom line as enabled border
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                        ),
                      )))),
            ],
          ),
        );
        addCount++;
      } else {
        Globals.showSnackBar(
            context: context,
            message: 'You have to add marks',
            isSuccess: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.green,
        shape: const CircleBorder(),
        onPressed: _addRow,
        child: const Icon(
          Icons.add,
          color: AppColors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(80),
              const Center(
                child: Text(
                  "Add Marks",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: AppColors.black),
                ),
              ),
              const Gap(50),
              Text(
                widget.paper.paperName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.black),
              ),
              Row(
                children: [
                  Visibility(
                    visible: widget.paper.isMcq,
                    child: const SizedBox(
                      height: 10,
                      width: 20,
                      child: CircleAvatar(
                        backgroundColor: AppColors.purple,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.paper.isStructure,
                    child: const SizedBox(
                      height: 10,
                      width: 20,
                      child: CircleAvatar(
                        backgroundColor: AppColors.green,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.paper.isEssay,
                    child: const SizedBox(
                      height: 10,
                      width: 20,
                      child: CircleAvatar(
                        backgroundColor: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(30),
              const Text(
                'Add Marks',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppColors.black),
              ),
              const Gap(10),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Table(
                      border: TableBorder.all(),
                      children: rows,
                    ),
              const Gap(40),
              Container(
                height: 35,
                width: 70,
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(25)),
                child: TextButton(
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    // if (!formKey.currentState!.validate()) return;
                    if (studentIdController.text.trim().isEmpty) {
                      Globals.showSnackBar(
                          context: context,
                          message: 'Please enter the student id',
                          isSuccess: false);
                      return;
                    }
                    if (int.tryParse(studentIdController.text.trim()) == null) {
                      Globals.showSnackBar(
                          context: context,
                          message: 'Please enter valid student id',
                          isSuccess: false);
                      return;
                    }

                    if (studentIds
                        .contains(int.parse(studentIdController.text.trim()))) {
                      Globals.showSnackBar(
                          context: context,
                          message: 'Student id is already taken',
                          isSuccess: false);
                      return;
                    }
                    if (widget.paper.isMcq &&
                        mcqController.text.trim().isEmpty) {
                      Globals.showSnackBar(
                          context: context,
                          message: 'Please enter the mcq marks',
                          isSuccess: false);
                      return;
                    }
                    if (mcqController.text.isNotEmpty) {
                      if (int.tryParse(mcqController.text.trim()) == null) {
                        Globals.showSnackBar(
                            context: context,
                            message: 'Please enter valid mcq marks',
                            isSuccess: false);
                        return;
                      }
                      if (0 > int.parse(mcqController.text.trim()) ||
                          int.parse(mcqController.text.trim()) > 100) {
                        Globals.showSnackBar(
                            context: context,
                            message: 'mcq marks should be between 0 and 100',
                            isSuccess: false);
                        return;
                      }
                    }
                    if ((widget.paper.isStructure &&
                        structureController.text.trim().isEmpty)) {
                      Globals.showSnackBar(
                          context: context,
                          message: 'Please enter the structure marks',
                          isSuccess: false);
                      return;
                    }
                    if (structureController.text.isNotEmpty) {
                      if (int.tryParse(structureController.text.trim()) ==
                          null) {
                        Globals.showSnackBar(
                            context: context,
                            message: 'Please enter valid structure marks',
                            isSuccess: false);
                        return;
                      }
                      if (0 > int.parse(structureController.text.trim()) ||
                          int.parse(structureController.text.trim()) > 100) {
                        Globals.showSnackBar(
                            context: context,
                            message:
                                'structure marks should be between 0 and 100',
                            isSuccess: false);
                        return;
                      }
                    }
                    if ((widget.paper.isEssay &&
                        essayController.text.trim().isEmpty)) {
                      Globals.showSnackBar(
                          context: context,
                          message: 'Please enter the essay marks',
                          isSuccess: false);
                      return;
                    }
                    if (essayController.text.isNotEmpty) {
                      if (int.tryParse(essayController.text.trim()) == null) {
                        Globals.showSnackBar(
                            context: context,
                            message: 'Please enter valid esaay marks',
                            isSuccess: false);
                        return;
                      }
                      if (0 > int.parse(essayController.text.trim()) ||
                          int.parse(essayController.text.trim()) > 100) {
                        Globals.showSnackBar(
                            context: context,
                            message: 'essay marks should be between 0 and 100',
                            isSuccess: false);
                        return;
                      }
                    }
                    if (totalMarksController.text.trim().isEmpty) {
                      Globals.showSnackBar(
                          context: context,
                          message: 'Please enter the total marks',
                          isSuccess: false);
                      return;
                    }
                    if (totalMarksController.text.isNotEmpty) {
                      if (int.tryParse(totalMarksController.text.trim()) ==
                          null) {
                        Globals.showSnackBar(
                            context: context,
                            message: 'Please enter valid total marks',
                            isSuccess: false);
                        return;
                      }
                      if (widget.paper.isMcq &&
                          widget.paper.isStructure &&
                          widget.paper.isEssay) {
                        if (0 > int.parse(totalMarksController.text.trim()) ||
                            int.parse(totalMarksController.text.trim()) > 300) {
                          Globals.showSnackBar(
                              context: context,
                              message:
                                  'total marks should be between 0 and 300',
                              isSuccess: false);
                          return;
                        }
                      }
                      if (widget.paper.isMcq &&
                          widget.paper.isStructure &&
                          !widget.paper.isEssay) {
                        if (0 > int.parse(totalMarksController.text.trim()) ||
                            int.parse(totalMarksController.text.trim()) > 200) {
                          Globals.showSnackBar(
                              context: context,
                              message:
                                  'total marks should be between 0 and 200',
                              isSuccess: false);
                          return;
                        }
                      }
                      if (widget.paper.isMcq &&
                          widget.paper.isEssay &&
                          !widget.paper.isStructure) {
                        if (0 > int.parse(totalMarksController.text.trim()) ||
                            int.parse(totalMarksController.text.trim()) > 200) {
                          Globals.showSnackBar(
                              context: context,
                              message:
                                  'total marks should be between 0 and 200',
                              isSuccess: false);
                          return;
                        }
                      }
                      if (widget.paper.isStructure &&
                          widget.paper.isEssay &&
                          !widget.paper.isMcq) {
                        if (0 > int.parse(totalMarksController.text.trim()) ||
                            int.parse(totalMarksController.text.trim()) > 200) {
                          Globals.showSnackBar(
                              context: context,
                              message:
                                  'total marks should be between 0 and 200',
                              isSuccess: false);
                          return;
                        }
                      }

                      if (widget.paper.isMcq &&
                          !widget.paper.isStructure &&
                          !widget.paper.isEssay) {
                        if (0 > int.parse(totalMarksController.text.trim()) ||
                            int.parse(totalMarksController.text.trim()) > 100) {
                          Globals.showSnackBar(
                              context: context,
                              message:
                                  'total marks should be between 0 and 100',
                              isSuccess: false);
                          return;
                        }
                      }
                    }
                    addMarks(
                      paperId: widget.paper.paperId,
                      studentId: int.parse(studentIdController.text.trim()),
                      mcq: mcqController.text.trim().isNotEmpty
                          ? int.parse(mcqController.text.trim())
                          : null,
                      structured: structureController.text.trim().isNotEmpty
                          ? int.parse(structureController.text.trim())
                          : null,
                      essay: essayController.text.trim().isNotEmpty
                          ? int.parse(essayController.text.trim())
                          : null,
                      total: int.parse(totalMarksController.text.trim()),
                    );
                  },
                  child: const Center(
                      child: Text(
                    'Done',
                    style: TextStyle(
                      color: AppColors.ligthWhite,
                    ),
                  )),
                ),
              ),
              const Gap(15)
            ],
          ),
        ),
      ),
    );
  }
}
