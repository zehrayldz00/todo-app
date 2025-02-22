import 'package:flutter/material.dart';
import 'package:todo_application/ui/view/home_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/",
      routes: {
        "/" : (context) => HomeView(),
      },
    );
  }
}
