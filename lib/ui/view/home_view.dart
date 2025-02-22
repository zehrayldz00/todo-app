import 'package:flutter/material.dart';
import 'package:todo_application/ui/shared/widgets/custom_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(0xff19579C),
        title: Text("My Task Manager"),
      ),
      floatingActionButton: _fabButton,
      body: ListView.builder(
        itemCount: 3,
        itemExtent: 140,
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            CustomCard(title: "hello", subtitle: "$index"),
      ),
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      );
}
