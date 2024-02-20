import 'dart:io';

import 'package:educator_app/globals.dart';
import 'package:educator_app/screens/res/app_colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProgressPopup {
  BuildContext context;
  File? videoFile;
  File? videoThumnail;
  String videoId = '';
  String docId = '';

  ProgressPopup(this.context, this.videoFile, this.videoThumnail, this.videoId, this.docId);

  void show() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          surfaceTintColor: AppColors.ligthWhite,
          backgroundColor: AppColors.ligthWhite,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: ProcessSyncProgressWidget(
              context, videoFile, videoThumnail, videoId,docId),
        );
      },
    );
  }
}

class ProcessSyncProgressWidget extends StatefulWidget {
  final BuildContext context;
  final File? videoFile;
  final File? videoThumbnail;
  final String videoId;
   final String docId;

  const ProcessSyncProgressWidget(
      this.context, this.videoFile, this.videoThumbnail, this.videoId,this.docId,
      {Key? key})
      : super(key: key);

  @override
  State<ProcessSyncProgressWidget> createState() =>
      _ProcessSyncProgressWidgetState();
}

class _ProcessSyncProgressWidgetState extends State<ProcessSyncProgressWidget> {
  double percentage = 0;
  @override
  void initState() {
    super.initState();

    uploadThumbnail(widget.videoThumbnail);

    uploadVideo(widget.videoFile);
  }

  Future uploadThumbnail(File? videothumbnail) async {
    if (videothumbnail == null) return;

    try {
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('thumbnail/${widget.docId}')
          .child('${widget.videoId}.jpg');
      UploadTask uploadTask = firebaseStorageRef.putFile(videothumbnail!);

      await uploadTask;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future uploadVideo(File? videoFile) async {
    if (videoFile == null) return;

    try {
      // loading.show();
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('videos/${widget.docId}')
          .child('${widget.videoId}.mp4');

      UploadTask uploadTask = firebaseStorageRef.putFile(videoFile!);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        setState(() {
          percentage = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
        });

        print('Upload is $percentage% done');
        // You can update your UI with the upload progress here
      });
      await uploadTask;
      // loading.dismiss();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Globals.showSnackBar(
          context: context, isSuccess: true, message: 'Success');
      // ignore: avoid_print, use_build_context_synchronously
      Navigator.of(context).pop();
      print('Video Uploaded');
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) {
        Globals.showSnackBar(
            context: context,
            message: 'Video is being uploade. Please wait...',
            isSuccess: false);
      },
      child: Container(
        color: AppColors.ligthWhite,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                "Uploading",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              "uploaded  ${percentage.toStringAsFixed(1)}%",
              style: const TextStyle(
                color: AppColors.black,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: AppColors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
