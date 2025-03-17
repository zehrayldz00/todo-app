import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'model/task.dart';

class ApiService {
  late String _baseUrl;

  static ApiService _instance = ApiService._privateConstructor();
  ApiService._privateConstructor() {
    _baseUrl = "https://rest-8692d-default-rtdb.firebaseio.com/";
  }

  static ApiService getInstance() {
    return _instance;
  }

  Future <Map<String, dynamic>?> getThemePreference() async{
    final response = await http.get(Uri.parse('$_baseUrl/theme.json'));
    final jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse("$_baseUrl/task.json"));

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final taskList = TaskList.fromJsonList(jsonResponse);
        return taskList.tasks;
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }

  Future<void> addTasks(Task task) async {
    final jsonBody = json.encode(task.toJson());
    final response = await http.post(Uri.parse("$_baseUrl/task.json"), body: jsonBody);

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }

  Future<void> removeTasks(String key) async {
    final response = await http.delete(Uri.parse("$_baseUrl/task/$key.json"));
    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:
        return Future.value(true);
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }

  Future<void> updateTask(Task task) async{
    final jsonBody = json.encode(task.toJson());
    final response = await http.put(
      Uri.parse("$_baseUrl/task/${task.key}.json"),
      body: jsonBody
    );
    final jsonResponse = json.decode(response.body);

    switch (response.statusCode){
      case HttpStatus.ok:
        return Future.value(true);
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
    }
    Logger().e(jsonResponse);
    return Future.error(jsonResponse);
  }

  Future <void> saveThemePreference(bool isDarkMode) async {
    final jsonBody = json.encode({'isDarkMode' : isDarkMode});
    final response = await http.put(Uri.parse('$_baseUrl/theme.json'),
      body: jsonBody,
    );

    final jsonResponse = json.decode(response.body);
    return jsonResponse;

  }
}
