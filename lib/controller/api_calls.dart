import 'dart:convert';

import 'package:artifita/model/quiz_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiCalls with ChangeNotifier {

  List<QuizModel> quizList = [];

  Future<List<QuizModel>> getDataFromApi() async {
    var response = await http
        .get(Uri.parse("https://nice-lime-hippo-wear.cyclic.app/api/v1/quiz"));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      for (var i in data) {
        quizList.add(QuizModel.fromJson(i));
      }
      return quizList;
    }

    return quizList;

  }
}


