import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_clean_code_upload_file/networkManager/repository.dart';
import 'package:flutter/material.dart';

import '../helper/string_helper.dart';

import 'package:image_picker/image_picker.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool loading = false;
  File? selectImage;
  String? fileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringHelper.getMapList),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? file =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (file != null) {
                  selectImage = File(file.path);
                  fileName = file.name;
                  setState(() {});
                }
              },
              child: selectImage == null
                  ? Container(
                      height: 200,
                      margin: const EdgeInsets.only(bottom: 50),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Text("Select Image"),
                    )
                  : Container(
                      height: 200,
                      margin: const EdgeInsets.only(bottom: 50),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(selectImage!))),
                    ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (selectImage != null) {
                  setState(() {
                    loading = true;
                  });
                  FormData formData = FormData.fromMap({
                    'file': await MultipartFile.fromFile(selectImage!.path,
                        filename: fileName)
                  });
                  Repository().uploadImage(formData).then((value){
                    print('image url ==> ${value.location}');
                    loading=false;
                    setState(() {});
                  }).onError((error,stackTrace){
                    print('image url ==> ${error.toString()}');
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please pic Image')));
                }
              },
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text('upload'),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
