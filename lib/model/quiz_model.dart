// To parse this JSON data, do
//
//     final quizModel = quizModelFromJson(jsonString);

import 'dart:convert';



List<QuizModel> quizModelFromJson(String str) => List<QuizModel>.from(json.decode(str).map((x) => QuizModel.fromJson(x)));

String quizModelToJson(List<QuizModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuizModel {
  String id;
  String question;
  List<Option> options;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  QuizModel({
    required this.id,
    required this.question,
    required this.options,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    id: json["_id"],
    question: json["question"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Option {
  String text;
  bool isCorrect;
  String id;

  Option({
    required this.text,
    required this.isCorrect,
    required this.id,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    text: json["text"],
    isCorrect: json["isCorrect"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "isCorrect": isCorrect,
    "_id": id,
  };
}
