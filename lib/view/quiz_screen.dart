import 'package:artifita/controller/api_calls.dart';
import 'package:artifita/model/quiz_model.dart';
import 'package:artifita/view/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _HomePageState();
}

class _HomePageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    final apiController = Provider.of<ApiCalls>(context);

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
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return  QuestionWidget(index: index, data: data);
              },
            );
          }
        },
      ),
    );
  }
}

class QuestionWidget extends StatefulWidget {
  int index;
  final List<QuizModel> data;

  QuestionWidget({Key? key, required this.index, required this.data})
      : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int answerCount = -1;
  bool answer = false;

  bool isOptionsEnabled =
      true; // Added flag to control interaction with options
  int correctOptionIndex = -1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height * 0.1,
        ),
        LinearPercentIndicator(
          lineHeight: 30,
          percent: 0.5,
          barRadius: const Radius.circular(20),
          progressColor: const Color(0xFFC353D6),
          backgroundColor: const Color(0xFF6C2677),
          center: const Text(
            '40',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child:
          widget.index<=4?

          Text(

            widget.data[widget.index<=4?widget.index:4].question.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ): null
        ),
        SizedBox(
          height: height * 0.02,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount:widget.index<=4?
           widget.data[widget.index].options.length:4,
          itemBuilder: (context, count) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.009,
              ),
              child: GestureDetector(
                onTap: isOptionsEnabled
                    ? () {
                        setState(() {
                          answerCount = count;
                          answer = true;
                          isOptionsEnabled =
                              false; // Disable interaction with other options
                          if (widget
                              .data[widget.index<=4?widget.index:4].options[count].isCorrect) {
                            correctOptionIndex = count;
                          } else {
                            // Change color to green for the correct option
                            correctOptionIndex = widget
                                .data[widget.index<=4?widget.index:4].options
                                .indexWhere((option) => option.isCorrect);
                          }
                        });
                      }
                    : null, // Set onTap to null if options are disabled
                child: Container(
                  decoration: BoxDecoration(
                    color: answerCount == count
                        ? widget.data[widget.index<=4?widget.index:4].options[count].isCorrect
                            ? Colors.green
                            : Colors.red
                        : (count == correctOptionIndex && answer)
                            ? Colors
                                .green // Change color to green for the correct option
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
                      child:
                      

                      Text(
                        "${count + 1} .  ${widget.data[widget.index<=4? widget.index:4].options[count].text.toString()}",
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
          visible: answer,
          child: ElevatedButton(
            onPressed: () {
              if (widget.data.length == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResultScreen(),
                  ),
                );
              } else {
                setState(() {
                  answer = false;
                  isOptionsEnabled =
                      true; // Enable interaction with options for the next question
                  correctOptionIndex = -1;
                  if (widget.index != widget.data.length) {
                    widget.index += 1;
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResultScreen(),
                      ),
                    );
                  }
                  answerCount = -1;
                });
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
