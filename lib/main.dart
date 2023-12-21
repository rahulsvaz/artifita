import 'dart:io';

import 'package:artifita/controller/api_calls.dart';
import 'package:artifita/model/database/question_local_storage.dart';
import 'package:artifita/model/quiz_model.dart';
import 'package:artifita/view/colors.dart';
import 'package:artifita/view/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(QuestionAdapter());
  await Hive.openBox<QuizModel>('QuestionBox');

  

  Provider.debugCheckInvalidValueType == null;
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ApiCalls())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Palette.bgColor),
      home: const HomeScreen(),
    );
  }
}
