import 'package:flutter/material.dart';
import 'package:todo_application/core/api_service.dart';
import 'package:todo_application/core/model/task.dart';
import 'package:todo_application/ui/shared/styles/text_styles.dart';
import 'package:todo_application/ui/shared/widgets/custom_card.dart';
import 'package:todo_application/ui/view/add_task_view.dart';

import '../shared/styles/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ApiService service = ApiService.getInstance();
  List<Task> taskList = [];
  bool isClicked = false;
  Color appBarColor = nightNavy;
  Color background = darkNavy;
  Color cardColor = nightNavy;
  Image leadIcon = Image.asset('assets/images/moon.png');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              isClicked = !isClicked;

              appBarColor = isClicked ? sandy : nightNavy;
              background = isClicked ? sunShine : darkNavy;
              cardColor = isClicked ? sandy : nightNavy;

              leadIcon = isClicked
                  ? Image.asset('assets/images/sun.png')
                  : Image.asset('assets/images/moon.png');
            });
          },
          icon: leadIcon,
        ),
        backgroundColor: appBarColor,
        title: Text(
          "My Task Manager",
          style: titleStyle,
        ),
      ),
      floatingActionButton: _fabButton,
      body: FutureBuilder<List<Task>>(
          future: service.getTasks(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasData) {
                  taskList = snapshot.data!;
                  return _listView;
                }
                return Center(child: Text("ERROR"));

              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          }),
      backgroundColor: background,
    );
  }

  Widget get _listView => ListView.builder(
      itemCount: taskList.length,
      itemExtent: 140,
      shrinkWrap: true,
      itemBuilder: (context, index) => dismiss(
          CustomCard(
            title: taskList[index].taskName,
            subtitle: taskList[index].taskDetail,
            cardColor: cardColor,
          ),
          taskList[index].key));

  Widget dismiss(Widget child, String? key) {
    return Dismissible(
      child: child,
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      secondaryBackground: Center(
        child: Text("hello"),
      ),
      onDismissed: (dismissDirection) async {
        await service.removeTasks(key!);
      },
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: fabPressed,
        child: (Image.asset(
          'assets/images/add.png',
        )),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      );

  void fabPressed() {
    showModalBottomSheet(context: context, builder: (context) => bottomSheet);
  }

  Widget get bottomSheet => Container(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: Column(children: [
          Divider(
            thickness: 2,
            indent: 100,
            endIndent: 100,
            color: Colors.grey,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddTaskView()));
            },
            child: Text("Add Product"),
          )
        ]),
      );
}
