import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educator_app/models/model.dart';
import 'package:educator_app/screens/add_folder_screen/add_folder.dart';
import 'package:educator_app/screens/res/app_colors.dart';
import 'package:flutter/material.dart';

class FolderListScreen extends StatefulWidget {
  const FolderListScreen({super.key});

  @override
  State<FolderListScreen> createState() => _FolderListScreenState();
}

class _FolderListScreenState extends State<FolderListScreen> {
  List<DocumentSnapshot> data = [];
  List<Folder> folderList = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    data.clear();
    folderList.clear();
    setState(() {
      isLoading = true;
    });
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('folders')
        .orderBy('videoUploadedDate', descending: false)
        .get();
    setState(() {
      data.addAll(querySnapshot.docs);
      for (var folder in data) {
        folderList.add(
          Folder(
            folderName: folder['folderName'],
            emailList: folder['emailList'],
            uploadedDate: folder['videoUploadedDate'], docId: folder.id,
          ),
        );
      }
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.green,
        shape: const CircleBorder(),
        onPressed: () {
          // Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddFolder(
                    isUpdate: false,
                    callBack: () {
                      fetch();
                    },
                    folderDetails: null,
                  )));
        },
        child: const Icon(
          Icons.add,
          color: AppColors.black,
        ),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.backGround,
        title: const Text('Folders'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.blue,
            ))
          : folderList.isEmpty
              ? const Center(
                  child: Text(
                    'No folders',
                    style: TextStyle(color: AppColors.black),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // crossAxisSpacing: 10.0,
                      // mainAxisSpacing: 10.0,
                    ),
                    itemCount: folderList.length, // Number of items in the grid
                    itemBuilder: (BuildContext context, int index) {
                      Folder folder = folderList[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              color: Colors.yellow,
                              splashColor: AppColors.grey,
                              focusColor: AppColors.grey,
                              hoverColor: AppColors.grey,
                              iconSize: 120,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddFolder(
                                          isUpdate: true,
                                          callBack: () {
                                            fetch();
                                          },
                                          folderDetails: folder,
                                        )));
                              },
                              icon: const Icon(Icons.folder)),
                          // const Gap(8),
                          Text(
                            folder.folderName,
                            style: const TextStyle(color: AppColors.black),
                          )
                        ],
                      );
                    },
                  ),
                ),
    );
  }
}
