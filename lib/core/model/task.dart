class Task {
  String? taskName;
  String? taskDetail;
  String? key;
  bool? isCompleted;

  Task({this.taskName, this.taskDetail, this.isCompleted});

  Task.fromJson(Map<String, dynamic> json) {
    taskName = json['taskName'];
    taskDetail = json['taskDetail'];
    isCompleted = json['isCompleted'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskName'] = this.taskName;
    data['taskDetail'] = this.taskDetail;
    data['key'] = this.key;
    data ['isCompleted'] = this.isCompleted;
    return data;
  }

}
class TaskList{
  List<Task> tasks = [];

  TaskList.fromJsonList(Map value){
    value.forEach((key,value){
      var task = Task.fromJson(value);
      task.key= key;
      tasks.add(task);
    });
  }
}