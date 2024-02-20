import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Paper {
  String paperId = '';
  String paperName = '';
  bool isMcq = false;
  bool isStructure = false;
  bool isEssay = false;

  Paper(
      {required this.paperId,
      required this.paperName,
      required this.isMcq,
      required this.isStructure,
      required this.isEssay});
}

class Instructor {
  String instructorId = '';
  String email = '';
  String docId = '';

  Instructor(
      {required this.instructorId, required this.email, required this.docId});
}

class Video {
  File? videoFile;
  File? thumbnail;
  String title = '';
  String description = '';
  String lesson = '';
  String date = '';
  bool isVideo = false;
  String videoFileName = '';

  Video(
      {required this.videoFile,
      required this.thumbnail,
      required this.title,
      required this.description,
      required this.lesson,
      required this.date,
      required this.isVideo,
      required this.videoFileName});
}

class Folder {
  String folderName = '';
  List<dynamic> emailList = [];
  String docId = '';
  late Timestamp uploadedDate;

  Folder(
      {required this.folderName,
      required this.emailList,
      required this.uploadedDate,
      required this.docId
      });
}

class VideoDetail {
  String videoId = '';
  String docId = '';
  String videoPath = '';
   String videoDocId = '';
  

  VideoDetail(
      {
      required this.docId,
      required this.videoId,
      required this.videoPath,
      required this.videoDocId
      });
}
