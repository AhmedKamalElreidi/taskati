import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/storage/local_data.dart';
import 'package:taskati/core/utils/styles.dart';
import 'package:taskati/features/home/home.dart';
import 'package:taskati/features/upload/upload_name_photo.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      AppLocal.getData(AppLocal.IS_UPLOAD).then((value) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              (value ?? false) ? const HomeView() : const UploadView(),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/logo.json',
              height: 250,
            ),
            Text(
              'Taskati',
              style: getTitleStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'It\'s Time To Get Orginzed',
              style: getSmallTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
