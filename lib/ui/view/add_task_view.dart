import 'package:flutter/material.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  GlobalKey<FormState> formKey = GlobalKey(debugLabel: "formKey");

  String? validator(val){
    if(val!.isEmpty){
      return "This area can't empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Task Name",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                  validator: validator,
                ),
                SizedBox(height: 30,),
                TextFormField(decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Task Detail",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                  validator: validator,
                ),

                ElevatedButton.icon(
                  icon: Icon(Icons.send),
                  onPressed: () {},
                  label: Text("Add"),
                )
              ],
            ),
          ),
        ),

      ),
    );
  }
}
