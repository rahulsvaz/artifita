


import 'package:artifita/model/quiz_model.dart';
import 'package:hive/hive.dart';
part 'question_local_storage.g.dart';

@HiveType(typeId: 1)
class Question{

@HiveField(0)
 List<QuizModel> localQuiz;

Question({required this.localQuiz});




}


// smtp2072082698