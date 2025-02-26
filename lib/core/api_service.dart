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
  //eager ile sarmalamak ne demek

  static ApiService getInstance() {
    return _instance;
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
}
