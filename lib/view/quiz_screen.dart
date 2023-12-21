import 'package:artifita/controller/api_calls.dart';
import 'package:artifita/model/quiz_model.dart';
import 'package:artifita/model/quiz_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizProvider(),
      child: const QuizScreenBody(),
    );
  }
}

class QuizScreenBody extends StatelessWidget {
  const QuizScreenBody({super.key});
  @override
  Widget build(BuildContext context) {
    final apiController = ApiCalls(); // Initialize your controller here

    return Scaffold(
      body: FutureBuilder(
        future: apiController.getDataFromApi(),
        builder: (context, AsyncSnapshot<List<QuizModel>> snapshot) {
          final data = snapshot.data;

          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final quizBox = Hive.box<QuizModel>('QuestionBox');

            quizBox.add(data[0]);

            final q = quizBox.getAt(0);

            print(q!.question.toString());

            return QuestionWidget(data: data);
          }
        },
      ),
    );
  }
}

class QuestionWidget extends StatefulWidget {
  final List<QuizModel> data;

  QuestionWidget({Key? key, required this.data}) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int answerCount = 0;

  double counter = 0.0;

  @override
  void initState() {
    super.initState();

    // Start the function to increase the counter
    increaseCounter();
  }

  void increaseCounter() {
    Future.delayed(Duration(seconds: 1), () {
      if (counter < 0.9) {
        // Increase the counter every second up to 60 seconds (1 minute)
        setState(() {
          counter = counter + .1;
        });
        increaseCounter(); // Call the function recursively
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height * 0.1,
        ),
        LinearPercentIndicator(
          lineHeight: 30,
          isRTL: true,
          percent: counter,
          barRadius: const Radius.circular(20),
          progressColor: const Color(0xFFC353D6),
          backgroundColor: const Color(0xFF6C2677),
          center: Text(
            counter.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            widget
                .data[quizProvider.currentIndex <= 4
                    ? quizProvider.currentIndex
                    : 4]
                .question
                .toString(),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: quizProvider.currentIndex <= 4
              ? widget.data[quizProvider.currentIndex].options.length
              : 4,
          itemBuilder: (context, count) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.009,
              ),
              child: GestureDetector(
                onTap: quizProvider.isOptionsEnabled
                    ? () {
                        quizProvider.setAnswerCount(count);
                        quizProvider.setAnswer(true);
                        quizProvider.setOptionsEnabled(false);
                        if (widget.data[quizProvider.currentIndex]
                            .options[count].isCorrect) {
                          quizProvider.setCorrectOptionIndex(count);
                          answerCount = answerCount + 1;
                          print(answerCount.toString());
                        } else {
                          quizProvider.setCorrectOptionIndex(widget
                              .data[quizProvider.currentIndex <= 4
                                  ? quizProvider.currentIndex
                                  : 4]
                              .options
                              .indexWhere((option) => option.isCorrect));
                        }
                      }
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: quizProvider.answerCount == count
                        ? widget.data[quizProvider.currentIndex].options[count]
                                .isCorrect
                            ? Colors.green
                            : Colors.red
                        : (count == quizProvider.correctOptionIndex &&
                                quizProvider.answer)
                            ? Colors.green
                            : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.white),
                  ),
                  height: height * 0.06,
                  child: Padding(
                    padding: EdgeInsets.only(left: width * 0.04),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${count + 1} .  ${widget.data[quizProvider.currentIndex <= 4 ? quizProvider.currentIndex : 4].options[count].text.toString()}",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Visibility(
          visible: quizProvider.answer,
          child: ElevatedButton(
            onPressed: () {
              if (quizProvider.currentIndex == widget.data.length - 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      answerCount: answerCount,
                    ),
                  ),
                );
              } else {
                quizProvider.resetState();
                quizProvider.incrementIndex();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20,
              ),
            ),
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }
}
