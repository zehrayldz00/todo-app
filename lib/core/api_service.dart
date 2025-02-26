

class ApiService {
  //late String _baseUrl;

  final ApiService _instance = ApiService._privateConstructor();
  ApiService._privateConstructor() {
    //_baseUrl = "https://rest-8692d-default-rtdb.firebaseio.com/";
  }
  //eager ile sarmalamak ne demek

  ApiService getInstance() {
    return _instance;
  }

//burada verilen hatayı çözemedim
  /*Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse("$_baseUrl/task.json"));

    final jsonResponse = json.decode(response.body);

    switch (response.statusCode) {
      case HttpStatus.ok:

        break;
      case HttpStatus.unauthorized:
        Logger().e(jsonResponse);
        break;
      default:
        return Future.error(jsonResponse);
    }
  }*/
}
