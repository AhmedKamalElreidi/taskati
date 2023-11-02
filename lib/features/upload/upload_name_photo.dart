import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/colors.dart';
import 'package:taskati/core/local_data.dart';
import 'package:taskati/features/home/home.dart';

String? imagePath;
String name = '';

class UploadView extends StatefulWidget {
  const UploadView({super.key});

  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  @override
  void initState() {
    super.initState();
    AppLocal.getChached(AppLocal.imageKey).then((value) {
      setState(() {
        imagePath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                if (imagePath != null && name.isNotEmpty) {
                  //
                  AppLocal.cacheData(AppLocal.nameKey, name);
                  AppLocal.cacheBool(AppLocal.isUpload, true);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeView(),
                  ));
                } else if (imagePath == null && name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content:
                          Text('Please Upload Image and Enter Your Name')));
                } else if (imagePath == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Please Upload Image')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Please Enter Your Name')));
                }
              },
              child: Text(
                'Done',
                style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(128, 78, 91, 110)),
                child: Stack(children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey,
                    backgroundImage: (imagePath == null)
                        ? const AssetImage('assets/avatar.png')
                        : FileImage(File(imagePath!)) as ImageProvider,
                  ),
                  Positioned(
                    bottom: -15,
                    right: -10,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          showModelSheet();
                        });
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Divider(
                  color: AppColors.orangeColor,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                cursorColor: AppColors.orangeColor,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                style: TextStyle(color: AppColors.primaryColor),
                decoration: const InputDecoration(
                  hintText: 'Enter Your Name',
                  hintStyle: TextStyle(color: Colors.grey),
                  // filled: true,
                  // fillColor: Colors.grey
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showModelSheet() {
    return showModalBottomSheet(
      backgroundColor: Colors.grey,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImageFrom(ImageSource.camera);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "from camera",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  getImageFrom(ImageSource.gallery);
                },
                // uploadImage2screen(ImageSource.gallery);

                child: const Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  getImageFrom(ImageSource type) async {
    final pickedImage = await ImagePicker().pickImage(source: type);
    if (pickedImage != null) {
      AppLocal.cacheData(AppLocal.imageKey, pickedImage.path);
      setState(() {
        imagePath = pickedImage.path;
      });
    }
  }
}
