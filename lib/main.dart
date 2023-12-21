import 'package:flutter/material.dart';
import 'package:metatube/screen/home.dart';
import 'package:metatube/screen/splash.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = WindowOptions(
    minimumSize: Size(400, 780),
    size: Size(500, 780),
    center: true,
    title: "MetaTube",
  );

  windowManager.waitUntilReadyToShow(
    windowOptions,
    ()async{
      await windowManager.show();
      await windowManager.focus();
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const Splash(),
    );
  }
}
