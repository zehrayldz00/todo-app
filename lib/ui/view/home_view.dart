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
  final ApiService service = ApiService.getInstance();
  List<Task> taskList = [];
  bool isClicked = false;

  late Color appBarColor, background, cardColor;
  late Image leadIcon;

  @override
  void initState() {
    super.initState();
    _setTheme(isClicked);
    _loadTasks();
  }

  void _setTheme(bool isDarkMode) {
    setState(() {
      appBarColor = isDarkMode ? sandy : nightNavy;
      background = isDarkMode ? sunShine : darkNavy;
      cardColor = isDarkMode ? sandy : nightNavy;

      leadIcon = isDarkMode
          ? Image.asset('assets/images/sun.png')
          : Image.asset('assets/images/moon.png');
    });
  }

  void _loadTasks() async {
    List<Task> tasks = await service.getTasks();
    setState(() {
      taskList = tasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _fabButton,
      body: taskList.isEmpty
          ? Center(
              child: Text(
                "No tasks available",
                style: titleStyle,
              ),
            )
          : _listView,
      backgroundColor: background,
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          isClicked = !isClicked;
          _setTheme(isClicked);
        },
        icon: leadIcon,
      ),
      backgroundColor: appBarColor,
      title: Text(
        "My Task Manager",
        style: titleStyle,
      ),
    );
  }

  Widget get _listView => ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) => _dismissibleCard(taskList[index]));

  Widget _dismissibleCard(Task task) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: white,
        ),
      ),
      child: CustomCard(
          title: task.taskDetail,
          subtitle: task.taskDetail,
          cardColor: cardColor),
      onDismissed: (direction) async {
        await service.removeTasks(task.key!);
        setState(() {
          taskList.remove(task);
        });
      },
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: _showBottomSheet,
        child: (Image.asset(
          'assets/images/add.png',
        )),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      );

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, //klavyenin açılmasını düzgün hale getirir.
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      clipBehavior: Clip.antiAlias,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(16),
          color: cardColor,
          child: AddTaskView(onTaskAdded: _loadTasks),
        ),
      ),
    );
  }
}
