import 'package:http/http.dart' as http;
import 'package:quiz_millionaire_flutter_test/entity/Question.dart';
import 'package:quiz_millionaire_flutter_test/service/request/AuthRequest.dart';
import 'package:quiz_millionaire_flutter_test/service/response/JwtResponse.dart';

final String apiURL = "http://192.168.0.102:8080/api/v1";

String token;

Future<int> login(String email, String password) async {
  final AuthRequest authRequest =
      new AuthRequest(email: email, password: password);
  final response = await http.post(apiURL + "/signin",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      }, body: authRequestToJson(authRequest));

  token = jwtResponseFromJson(response.body).jwtToken;

  return response.statusCode;
}

Future<List<Question>> getQuestions() async {
  final response = await http.get(apiURL + "/questions", headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  });

  if(response.statusCode == 200) {
    return questionsFromJson(response.body);
  }

  return null;
}
