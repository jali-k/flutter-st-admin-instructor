import 'dart:io';
import 'package:educator_app/globals.dart';
import 'package:educator_app/models/model.dart';
import 'package:educator_app/screens/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class AddVideo extends StatefulWidget {
  final void Function(Video video) callBackVideo;
  final bool isUpdate;
  const AddVideo({
    super.key,
    required this.callBackVideo,
    required this.isUpdate,
  });

  @override
  State<AddVideo> createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  final double _fieldBorderRadius = 30;
  final double _fieldBorderLineWidth = 1.5;
  final double _fieldFontSizeValue = 12;
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  String selectedLesson = '';
  final List<String> lessons = [];
  late DateTime _selectedDate;
  List<String> videoFileName = [];
  List<String> thumbNailName = [];
  List<File> videoFile = [];
  List<File> videoThumbnail = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      lessons.addAll(['Introduction to Biology', 'Chemical and cellular basis of life', 'Evolution and diversity of organisms', 'Evolution and diversity of organisms', 'Part 1-Animal form and function', 'Part 2-Animal form and function', 'Genetics, Molecular Biology and Recombinant DNA Technology', 'Environmental Biology', 'Microbiology', 'Applied Biology']);

      selectedLesson = lessons.first;
      _selectedDate = DateTime.now();

      // dateController.text = '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}';
    });
  }

  // void fetch() {
  //   setState(() {
  //     titleController.text = widget.videoDetails!.title;

  //     descriptionController.text = widget.videoDetails!.description;
  //     selectedLesson = widget.videoDetails!.lesson;
  //     dateController.text = widget.videoDetails!.date;
  //   });
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      dateController.text =
          '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}';
    }
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backGround,
        title: const Text('Upload a video'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.ligthWhite,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.black, width: 1.5)),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          'Upload the video file',
                          style: TextStyle(color: AppColors.black),
                        ),
                      ),
                      Center(
                          child: videoFile.isEmpty
                              ? IconButton(
                                  color: AppColors.blue,
                                  iconSize: 40,
                                  onPressed: () async {
                                    final picker = ImagePicker();
                                    final pickedFile = await picker.pickVideo(
                                        source: ImageSource.gallery);

                                    if (pickedFile != null) {
                                      setState(() {
                                        videoFile.add(File(pickedFile.path));
                                        videoFileName.add(pickedFile.name);
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.cloud_upload))
                              : const Icon(
                                  Icons.done_all,
                                  size: 40,
                                  color: AppColors.green,
                                )),
                    ],
                  ),
                ),
                Visibility(
                    visible: videoFileName.isNotEmpty,
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                          itemCount: videoFileName.length,
                          itemBuilder: (context, index) {
                            String name = videoFileName[index];
                            return Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: AppColors.backGround,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.black, width: 1.5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  dense: true,
                                  trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          videoFileName.removeAt(index);
                                          videoFile.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red,
                                      )),
                                  title: Text(
                                    name,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )),
                // const Gap(10),

                const Gap(20),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.ligthWhite,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: AppColors.black, width: 1.5)),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          'Upload the thumbnail',
                          style: TextStyle(color: AppColors.black),
                        ),
                      ),
                      Center(
                          child: videoThumbnail.isEmpty
                              ? IconButton(
                                  color: AppColors.blue,
                                  splashColor: AppColors.grey,
                                  focusColor: AppColors.grey,
                                  hoverColor: AppColors.grey,
                                  iconSize: 40,
                                  onPressed: () async {
                                    final picker = ImagePicker();
                                    final pickedFile = await picker.pickImage(
                                        source: ImageSource.gallery);

                                    if (pickedFile != null) {
                                      setState(() {
                                        videoThumbnail
                                            .add(File(pickedFile.path));
                                        thumbNailName.add(pickedFile.name);
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.cloud_upload))
                              : const Icon(
                                  Icons.done_all,
                                  size: 40,
                                  color: AppColors.green,
                                )),
                    ],
                  ),
                ),
                Visibility(
                    visible: thumbNailName.isNotEmpty,
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                          itemCount: thumbNailName.length,
                          itemBuilder: (context, index) {
                            String name = thumbNailName[index];
                            return Container(
                              margin: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: AppColors.backGround,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: AppColors.black, width: 1.5)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  dense: true,
                                  trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          thumbNailName.removeAt(index);
                                          videoThumbnail.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red,
                                      )),
                                  title: Text(
                                    name,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )),
                const Gap(20),
                const Text(
                  'Title',
                  style: TextStyle(color: AppColors.black),
                ),
                const Gap(10),
                TextFormField(
                  style: valueStyle,
                  controller: titleController,
                  cursorColor: cursorColor,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:  AppColors.ligthWhite,
                    labelText: 'Enter title',
                    labelStyle: const TextStyle(fontSize: 10),
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                    border: focusedBorder,
                    errorBorder: errorBorder,
                    errorStyle: errorStyle,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                ),
                const Gap(10),
                const Text(
                  'Description',
                  style: TextStyle(color: AppColors.black),
                ),
                const Gap(10),
                TextFormField(
                  style: valueStyle,
                  controller: descriptionController,
                  cursorColor: cursorColor,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:  AppColors.ligthWhite,
                    labelText: 'Enter description',
                    labelStyle: const TextStyle(fontSize: 10),
                    focusedBorder: focusedBorder,
                    enabledBorder: enabledBorder,
                    border: focusedBorder,
                    errorBorder: errorBorder,
                    errorStyle: errorStyle,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description';
                    }
                    return null;
                  },
                ),
                const Gap(10),
                const Text(
                  'Lessons',
                  style: TextStyle(color: AppColors.black),
                ),
                const Gap(10),
                SizedBox(
                  height: 60,
                  child: DropdownButtonHideUnderline(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.ligthWhite,
                          border:
                              Border.all(color: AppColors.black, width: 1.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: DropdownButton<String>(
                        padding: const EdgeInsets.only(left: 15),
                        underline: null,
                        dropdownColor: AppColors.ligthWhite,
                        value: selectedLesson,
                        style: valueStyle,
                        items: lessons.map((lesson) {
                          return DropdownMenuItem<String>(
                            value: lesson,
                            child: Text(lesson),
                          );
                        }).toList(),
                        onChanged: (subject) async {
                          setState(() {
                            selectedLesson = subject ?? '';
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                const Text(
                  'Date',
                  style: TextStyle(color: AppColors.black),
                ),
                const Gap(10),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: dateController,
                      style: valueStyle,
                      cursorColor: cursorColor,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.date_range),
                        labelText: 'Tap and pick the date',
                        // ignore: unnecessary_null_comparison
                        hintText: _selectedDate != null
                            ? '${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}'
                            : 'Select Date',
                        filled: true,
                        fillColor: AppColors.ligthWhite,
                        labelStyle: const TextStyle(fontSize: 10),
                        focusedBorder: focusedBorder,
                        enabledBorder: enabledBorder,
                        border: focusedBorder,
                        errorBorder: errorBorder,
                        errorStyle: errorStyle,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please pick the date';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const Gap(10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 35,
                    width: 60,
                    decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(29)),
                    child: TextButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (!formKey.currentState!.validate()) return;

                        if (videoFile.isEmpty || videoThumbnail.isEmpty) {
                          Globals.showSnackBar(
                              context: context,
                              message: 'Please upload the file',
                              isSuccess: false);
                        }

                        widget.callBackVideo(Video(
                            videoFile: videoFile.first,
                            thumbnail: videoThumbnail.first,
                            title: titleController.text,
                            description: descriptionController.text,
                            lesson: selectedLesson,
                            date: dateController.text,
                            isVideo: true,
                            videoFileName: videoFileName.first));
                        Navigator.of(context).pop();
                      },
                      child: const Center(
                          child: Text(
                        'Save',
                        style: TextStyle(
                          color: AppColors.ligthWhite,
                        ),
                      )),
                    ),
                  ),
                ),
                const Gap(20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
