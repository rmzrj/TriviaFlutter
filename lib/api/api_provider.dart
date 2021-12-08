import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:texol_task/models/question.dart';



Future<List<Question>> getQuestions(String difficulty) async {
  String url = "https://opentdb.com/api.php?amount=10&category=9";
  if(difficulty != null) {
    url = "$url&difficulty=$difficulty";
  }
  http.Response res = await http.get(Uri.parse(url));
  List<Map<String, dynamic>> questions = List<Map<String,dynamic>>.from(json.decode(res.body)["results"]);
  return Question.fromData(questions);
}