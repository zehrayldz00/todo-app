import 'package:flutter/material.dart';

import '../../core/api_service.dart';
import '../../core/model/task.dart';
import '../shared/styles/colors.dart';

class AddTaskView extends StatefulWidget {

  final VoidCallback onTaskAdded;

  const AddTaskView({super.key, required this.onTaskAdded});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final GlobalKey<FormState> formKey = GlobalKey(debugLabel: "formKey");
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerDetail = TextEditingController();

  String? validator(String? val) {
    if (val==null || val.isEmpty) {
      return "This area can't empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _textField(controllerName, "Task Name"),
                SizedBox(height: 20,),
                _textField(controllerDetail, "Task Detail"),
                SizedBox(height: 20,),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  onPressed: _addTask,
                  label: Text("Add"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _textField(TextEditingController controller, String label) {
    return TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: label,
                  labelStyle: TextStyle(color: white, fontFamily:"PixelifySans" ),
                  floatingLabelStyle: TextStyle(color: white),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: validator,
              );
  }
  void _addTask() async{
    if(formKey.currentState!.validate()){
      var model = Task(
        taskName: controllerName.text,
        taskDetail: controllerDetail.text,
        isCompleted: false
      );
      await ApiService.getInstance().addTasks(model);

      widget.onTaskAdded();
      Navigator.pop(context);
    }

}
}
