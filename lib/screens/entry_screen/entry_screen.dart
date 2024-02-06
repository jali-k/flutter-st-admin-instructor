import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educator_app/globals.dart';
import 'package:educator_app/models/model.dart';
import 'package:educator_app/popups/loading_popup.dart';
import 'package:educator_app/screens/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:uuid/uuid.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final double _fieldBorderRadius = 30;
  final double _fieldBorderLineWidth = 1.5;
  final double _fieldFontSizeValue = 12;
  final formKey = GlobalKey<FormState>();
  final entryController = TextEditingController();
  bool isMCQ = false;
  bool isStructured = false;
  bool isEssay = false;
  List<DocumentSnapshot> papers = [];
  List<Paper> paperList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPapers();
  }

  Future<void> addData(
      {required String paperName,
      required bool isMcqSelected,
      required bool isStructuredSelected,
      required bool isEssaySelected}) async {
    try {
      if (!isMcqSelected && !isStructuredSelected && !isEssaySelected) {
        Globals.showSnackBar(
            context: context,
            message: 'Please select the paper category',
            isSuccess: false);
        return;
      }
      final loading = LoadingPopup(context);
      loading.show();
      String paperId = const Uuid().v1();
      await FirebaseFirestore.instance
          .collection('papers') // Reference to the collection
          .add({
        'id': paperList.length,
        'paperId': paperId,
        'paperName': paperName,
        'isMcq': isMcqSelected,
        'isStructured': isStructuredSelected,
        'isEssay': isEssaySelected,
      });
      loading.dismiss();
      setState(() {
        paperList.insert(
            0,
            Paper(
                paperId: paperId,
                paperName: paperName,
                isMcq: isMcqSelected,
                isStructure: isStructuredSelected,
                isEssay: isEssaySelected));
        entryController.clear();
        isMCQ = false;
        isStructured = false;
        isEssay = false;
      });

      // ignore: use_build_context_synchronously
      Globals.showSnackBar(
          context: context, isSuccess: true, message: 'Success');
    } catch (error) {
      // ignore: avoid_print
      print("Failed to add user: $error");
    }
  }

  Future<void> fetchPapers() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('papers')
        .orderBy('id', descending: true)
        .get();
    setState(() {
      papers.addAll(querySnapshot.docs);
      papers.forEach((data) {
        paperList.add(Paper(
            paperId: data['paperId'],
            paperName: data['paperName'],
            isMcq: data['isMcq'],
            isStructure: data['isStructured'],
            isEssay: data['isEssay']));
      });
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.black,
        width: _fieldBorderLineWidth,
      ),
      borderRadius: BorderRadius.all(Radius.circular(_fieldBorderRadius)),
    );

    final enabledBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.black,
        width: _fieldBorderLineWidth,
      ),
      borderRadius: BorderRadius.all(Radius.circular(_fieldBorderRadius)),
    );

    final valueStyle = TextStyle(
      color: AppColors.black,
      fontSize: _fieldFontSizeValue,
    );

    final errorBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.red,
        width: _fieldBorderLineWidth,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    );

    const errorStyle = TextStyle(
      color: AppColors.red,
    );

    const cursorColor = AppColors.black;
    final width = MediaQuery.of(context).size.width;
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
                "Manage Papers",
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
                text: 'Add a ',
                style: TextStyle(color: AppColors.black, fontSize: 20),
              ),
              TextSpan(
                text: 'new',
                style: TextStyle(color: AppColors.green, fontSize: 20),
              ),
              TextSpan(
                text: ' Entry',
                style: TextStyle(color: AppColors.black, fontSize: 20),
              ),
            ])),
            const Gap(10),
            Form(
              key: formKey,
              child: SizedBox(
                width: width / 2,
                child: TextFormField(
                  style: valueStyle,
                  controller: entryController,
                  cursorColor: cursorColor,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.ligthWhite,
                    labelText: 'Enter paper name',
                    labelStyle: const TextStyle(fontSize: 10),
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                    border: focusedBorder,
                    errorBorder: errorBorder,
                    errorStyle: errorStyle,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the paper name';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  elevation: 10,
                  shadowColor: AppColors.purple,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: isMCQ ? AppColors.purple : AppColors.ligthWhite,
                        border: Border.all(
                          color: AppColors.purple, // Border color
                          width: 1.0, // Border width
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isMCQ = !isMCQ;
                        });
                      },
                      child: Row(
                        children: [
                          Visibility(
                            visible: isMCQ,
                            child: const Icon(
                              Icons.check,
                              color: AppColors.ligthWhite,
                            ),
                          ),
                          const Gap(5),
                          Center(
                              child: Text(
                            'MCQ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: isMCQ
                                  ? AppColors.ligthWhite
                                  : AppColors.black,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  shadowColor: AppColors.green,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: isStructured
                            ? AppColors.green
                            : AppColors.ligthWhite,
                        border: Border.all(
                          color: AppColors.green,
                          width: 1.0, // Border width
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isStructured = !isStructured;
                        });
                      },
                      child: Row(
                        children: [
                          Visibility(
                            visible: isStructured,
                            child: const Icon(
                              Icons.check,
                              color: AppColors.ligthWhite,
                            ),
                          ),
                          const Gap(5),
                          Center(
                              child: Text(
                            'STRUCTURED',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: isStructured
                                  ? AppColors.ligthWhite
                                  : AppColors.black,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  shadowColor: AppColors.red,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: isEssay ? AppColors.red : AppColors.ligthWhite,
                        border: Border.all(
                          color: AppColors.red,
                          width: 1.0, // Border width
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isEssay = !isEssay;
                        });
                      },
                      child: Row(
                        children: [
                          Visibility(
                            visible: isEssay,
                            child: const Icon(
                              Icons.check,
                              color: AppColors.ligthWhite,
                            ),
                          ),
                          const Gap(5),
                          Center(
                              child: Text(
                            'ESSAY',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: isEssay
                                  ? AppColors.ligthWhite
                                  : AppColors.black,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 35,
                  width: 60,
                  decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(29)),
                  child: TextButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (!formKey.currentState!.validate()) return;
                      addData(
                          paperName: entryController.text.trim(),
                          isMcqSelected: isMCQ,
                          isStructuredSelected: isStructured,
                          isEssaySelected: isEssay);
                    },
                    child: const Center(
                        child: Text(
                      'Send',
                      style: TextStyle(
                        color: AppColors.ligthWhite,
                      ),
                    )),
                  ),
                ),
              ],
            ),
            const Gap(30),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: RichText(
                  text: const TextSpan(children: [
                TextSpan(
                  text: 'Entries ',
                  style: TextStyle(color: AppColors.green),
                ),
                TextSpan(
                  text: ' sent',
                  style: TextStyle(color: AppColors.black),
                ),
              ])),
            ),
            const Gap(10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : paperList.isEmpty
                        ? const Center(
                            child: Text(
                              'No papers',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black),
                            ),
                          )
                        : ListView.builder(
                            itemCount: paperList.length,
                            itemBuilder: (BuildContext context, int index) {
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          paperList[index].paperName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black),
                                        ),
                                        Gap(5),
                                        Row(
                                          children: [
                                            Visibility(
                                              visible: paperList[index].isMcq,
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
                                              visible:
                                                  paperList[index].isStructure,
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
                                              visible: paperList[index].isEssay,
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
