import 'package:artifita/view/colors.dart';
import 'package:artifita/view/quiz_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        color:Palette.bgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.25),
            _buildLogo(),
            _buildStartQuizButton(),
            Spacer(),
            _buildPoweredBySection(),
            SizedBox(height: height * 0.06),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/logo.png',
      height: 300,
      fit: BoxFit.cover,
    );
  }

  Widget _buildStartQuizButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  QuizScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:Palette.startButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        foregroundColor:Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 20,
        ),
      ),
      child: const Text('Start Quiz'),
    );
  }

  Widget _buildPoweredBySection() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Text(
            'Powered By',
            style: TextStyle(color: Palette.grey),
          ),
          Text(
            'www.artificia.com',
            style: TextStyle(
              color: Palette.grey,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

