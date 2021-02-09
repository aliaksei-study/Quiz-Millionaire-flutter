import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_millionaire_flutter_test/entity/Category.dart';
import 'package:quiz_millionaire_flutter_test/entity/Player.dart';
import 'package:quiz_millionaire_flutter_test/entity/Question.dart';
import 'package:quiz_millionaire_flutter_test/service/request/AddQuestionRequest.dart';
import 'package:quiz_millionaire_flutter_test/service/request/AuthRequest.dart';
import 'package:quiz_millionaire_flutter_test/service/request/EditQuestionRequest.dart';
import 'package:quiz_millionaire_flutter_test/service/response/JwtResponse.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

Future<List<Category>> getCategories() async {
  final response = await http.get(apiURL + "/categories", headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  });

  if(response.statusCode == 200) {
    return categoriesFromJson(response.body);
  }

  return null;
}

Future<List<Player>> getPlayers() async {
  final response = await http.get(apiURL + "/players", headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  });

  if(response.statusCode == 200) {
    return playersFromJson(response.body);
  }

  return null;
}

Future<Question> addQuestion(AddQuestionRequest addQuestionRequest) async {
  final response = await http.post(apiURL + "/questions", headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  }, body: jsonEncode(addQuestionRequest));

  if(response.statusCode == 200) {
    return questionFromJson(response.body);
  }
  
  return null;
}

Future<Question> updateQuestion(int id, EditQuestionRequest updatedQuestion) async {
  final response = await http.put(apiURL + "/questions/" + id.toString(), headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  }, body: jsonEncode(updatedQuestion));

  if(response.statusCode == 200) {
    return questionFromJson(response.body);
  }

  return null;
}

Future<void> deleteQuestion(int id) async {
  await http.delete(apiURL + "/questions/" + id.toString(), headers: {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer $token',
  });
}

Future<void> showSpinnerDialog(
    BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [SpinKitRotatingCircle(
                color: Colors.blue,
                size: 50.0,
              )],
            ),
          ),
        );
      });
}
