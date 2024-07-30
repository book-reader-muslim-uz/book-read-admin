import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/foundation.dart' as foundation;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  PlatformFile? pickedFiles;
  UploadTask? uploadTask;

  Future uploadfile() async {
    try {
      final path = 'files/${pickedFiles!.name}';
      final ref = FirebaseStorage.instance.ref().child(path);

      if (foundation.kIsWeb) {
        final uploadTask = ref.putData(pickedFiles!.bytes!);
        final snapshot = await uploadTask.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        print(urlDownload);
      } else {
        final file = io.File(pickedFiles!.path!);
        final uploadTask = ref.putFile(file);
        final snapshot = await uploadTask.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        print(urlDownload);
      }

      setState(() {
        uploadTask = null;
      });
    } catch (e) {
      print("ERROR: $e");
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return;

    // print(result);

    setState(() {
      pickedFiles = result.files.first;
    });

    // print(pickedFiles);
  }

  // double bytesToMB(List<int> bytes) {
  //   int totalBytes = bytes.length;

  //   double totalMB = totalBytes / (1024 * 1024);

  //   return totalMB;
  // }
  double bytesToSize(List<int> bytes) {
    int totalBytes = bytes.length;
    double sizeInMB = totalBytes / (1024 * 1024);

    if (sizeInMB < 1) {
      double sizeInKB = totalBytes / 1024;
      return sizeInKB; // KB
    }

    return sizeInMB; // MB
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pdf read admin'),
      ),
      body: Center(
        child: Column(
          children: [
            pickedFiles != null
                ? Text(
                    'File hajmi: ${bytesToSize(pickedFiles!.bytes!).toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 18),
                  )
                : const Text("No selected file")
            // Text(
            //   'File Size: ${pickedFiles!.size} bytes',
            //   style: const TextStyle(fontSize: 18),
            // ),
            // Optionally display the file type if needed
            // Text(
            //   'File Type: ${pickedFiles!.extension}',
            //   style: const TextStyle(fontSize: 18),
            // ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                onPressed: selectFile,
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: uploadfile,
                child: const Icon(Icons.upload),
              ),
            ],
          ),
          buildProgress()
        ],
      ),
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            double progress = data!.bytesTransferred / data.totalBytes;

            return SizedBox(
              height: 50,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  Center(
                    child: Text(
                      "${(100 * progress).roundToDouble()}",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox(height: 50);
          }
        },
      );
}
