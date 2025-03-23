//import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:todo_application/ui/view/home_view.dart';

void main() => runApp(/*DevicePreview(
    enabled: true,
    tools: [
      ...DevicePreview.defaultTools,
    ],
    builder: (context) =>*/ MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "/",
      routes: {
        "/": (context) => HomeView(),
      },
    );
  }
}
