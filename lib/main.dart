// import 'package:device_preview/device_preview.dart';
import 'package:device_preview/device_preview.dart';
import 'package:exp_trck/temp_screens.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("UserData");
  await Hive.openBox("Settings");
  await Hive.openBox("Expense");
  await Hive.openBox("Income");
  await Hive.openBox("History");

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
      backgroundColor: Colors.black12,
    ),
      // const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        fontFamily: "Montserrat",
        primarySwatch: Colors.blue,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent
      ),
      home: const Home(title: "title"),
    );
  }
}


