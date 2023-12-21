import 'package:artifita/view/start_screen.dart';
import 'package:flutter/material.dart';


class ResultScreen extends StatefulWidget {
   int answerCount;
   ResultScreen({super.key, required this.answerCount});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/congrats.png',
                        width: 180,
                      ),
                      const Text(
                        '50% score',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Quiz completed succesfully..!',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text:  TextSpan(
                          text: 'You attempt  ',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: '5 questions',
                              style: TextStyle(color: Colors.red),
                            ),
                            TextSpan(
                              text: ' and from that ',
                              style:
                              TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            TextSpan(
                              text: '${widget.answerCount} answers',
                              style:
                              TextStyle(fontSize: 16, color: Colors.green),
                            ),
                            TextSpan(
                              text: ' is correct.',
                              style:
                              TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  widget.answerCount =0;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>HomeScreen()),
                          (route) => false);
                },
                child: const Text(
                  'Try again...!',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}