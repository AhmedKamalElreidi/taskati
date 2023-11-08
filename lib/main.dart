import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/model/task_model.dart';
import 'package:taskati/core/utils/theme.dart';
import 'package:taskati/features/splash/splash_view.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //هنا انا بقولو قبل ما ترن الابليكيشن عرفلى الكلام اللى تحت

  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  await Hive.openBox<Task>('task');
  await Hive.openBox<bool>('mode');
  await Hive.openBox('user');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<bool>('mode').listenable(),
      builder: (context, value, child) {
        bool darkMode = value.get('darkMode', defaultValue: false)!;
        return MaterialApp(
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            darkTheme: darkTheme,
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            home: const SplashView());
      },
    );
  }
}
