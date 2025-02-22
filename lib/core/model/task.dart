class Task {
  String? taskName;
  String? taskDetail;

  Task({this.taskName, this.taskDetail});

  Task.fromJson(Map<String, dynamic> json) {
    taskName = json['taskName'];
    taskDetail = json['taskDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['taskName'] = this.taskName;
    data['taskDetail'] = this.taskDetail;
    return data;
  }

}
class TaskList{
  List<Task> task = [];

  TaskList.fromJsonList(Map value){
    value.forEach((key,value){

    });
  }
}