import 'package:flutter/material.dart';
import 'package:todo_application/ui/shared/styles/colors.dart';

import '../../core/api_service.dart';
import '../../core/model/task.dart';
import '../shared/styles/text_styles.dart';

class AddTaskView extends StatefulWidget {

  final VoidCallback onTaskAdded;
  final Task? task;
  final bool isEditing;

  const AddTaskView({super.key, required this.onTaskAdded, this.task, this.isEditing=false});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final GlobalKey<FormState> formKey = GlobalKey(debugLabel: "formKey");
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerDetail = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.isEditing && widget.task != null){
      controllerName.text = widget.task!.taskName!;
      controllerDetail.text = widget.task!.taskDetail!;
    }
  }

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
                  icon: Icon(Icons.save, color: sandy,),
                  onPressed: _saveTask,
                  label: Text(widget.isEditing ? "Save" : "Add", style: detailStyle.copyWith(fontSize: 20, color: sandy),),
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
                style: detailStyle.copyWith(fontSize: 20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: white)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: orange, width: 2)),
                  errorStyle: detailStyle.copyWith( color: error),
                  labelText: label,
                  labelStyle: detailStyle,
                  floatingLabelStyle: detailStyle.copyWith(fontSize: 20),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                validator: validator,
              );
  }
  void _saveTask() async{
    if(formKey.currentState!.validate()){
      if(widget.isEditing && widget.task != null){
        widget.task!.taskName = controllerName.text;
        widget.task!.taskDetail = controllerDetail.text;

        await ApiService.getInstance().updateTask(widget.task!);
      }
      else{
        var model = Task(
            taskName: controllerName.text,
            taskDetail: controllerDetail.text,
            isCompleted: false
        );
        await ApiService.getInstance().addTasks(model);
      }
      widget.onTaskAdded();
      Navigator.pop(context);
    }

}
}
