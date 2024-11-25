import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/pages/completedpage.dart';
import 'package:quiz_app/pages/optionspage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
 List<Map<String, dynamic>> responseData = [];
  int number = 0;
  // ignore: unused_field
  late Timer _timer;
  int _secondRemaining = 15;

  List<String> shuffledOptions = [];

  String? selectedOption;
  int correctAnswers = 0;
  int wrongAnswers = 0;

  Future<void> api() async {
    final response =
        await http.get(Uri.parse('https://opentdb.com/api.php?amount=10'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('results')) {
        List<dynamic> results = data['results'];
        List<Map<String, dynamic>> parsedData =
            results.cast<Map<String, dynamic>>();
        setState(() {
          responseData = parsedData;
          updateShuffleOption();
        });
      }
    }
  }


  @override
  void initState() {
    super.initState();
    startQuiz();
  }

   void startQuiz() async {
    await api();
    startTimer();
  }

    @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF4A63AC), Color(0xFFE6EAF5)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  // Score Panel with Timer
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F3FA).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFFF0F3FA).withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildScoreCard('Correct', correctAnswers, const Color(0xFF228B22)),
                        _buildTimerCard(),
                        _buildScoreCard('Wrong', wrongAnswers, const Color(0xFFFF0000)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Question Card
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1F325A).withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A63AC).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            'Question ${number + 1}/${responseData.length}',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xFF2A438C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          responseData.isNotEmpty && number < responseData.length
                              ? responseData[number]['question']
                              : '',
                          style: const TextStyle(
                            fontSize: 17,
                            height: 1.5,
                            color: Color(0xFF1F325A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Options
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: (responseData.isNotEmpty &&
                                responseData[number]['incorrect_answers'] != null)
                            ? shuffledOptions.map((option) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF1F325A).withOpacity(0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Optionspage(
                                      option: option.toString(),
                                      selectedOption: selectedOption,
                                      onOptionSelected: (value) {
                                        setState(() {
                                          selectedOption = value;
                                          if (value ==
                                              responseData[number]['correct_answer']) {
                                            correctAnswers++;
                                          } else {
                                            wrongAnswers++;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }).toList()
                            : [],
                      ),
                    ),
                  ),

                  // Next Button
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A63AC),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 8,
                      ),
                      onPressed: nextQuestion,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Next Question",
                            style: TextStyle(
                              color: Color(0xFFF0F3FA),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, color: Color(0xFFF0F3FA)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildScoreCard(String label, int score, Color color) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F3FA).withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFFF0F3FA),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              score.toString(),
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildTimerCard() {
      return Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF4A63AC),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFF0F3FA).withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1F325A).withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Text(
            _secondRemaining.toString(),
            style: const TextStyle(
              color: Color(0xFFF0F3FA),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  void nextQuestion() {
    if (number < responseData.length - 1) {
      setState(() {
        number = number + 1;
        updateShuffleOption();
        _secondRemaining = 15;
      });
    } else {
      // Using pushReplacement instead of push
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Completedpage(
                  correctAnswers: correctAnswers,
                  wrongAnswers: wrongAnswers,
                  totalQuestions: responseData.length,
                  onPlayAgain: startQuiz,
                  questions: responseData,
                  userSelectedAnswers: List.generate(
                    responseData.length,
                    (index) => 'Your selected answer here', // Replace this with logic to retrieve the user's selected answer
                  ),
                )),
      );
    }
  }

  void updateShuffleOption() {
    if (responseData.length > number) {
      setState(() {
        shuffledOptions = shuffleOption([
          responseData[number]['correct_answer'],
          ...(responseData[number]['incorrect_answers'] as List)
        ]);
      });
    }
  }

  List<String> shuffleOption(List<String> option) {
    List<String> shuffledOptions = List.from(option);
    shuffledOptions.shuffle();
    return shuffledOptions;
  }



  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondRemaining > 0) {
          _secondRemaining--;
        } else {
          nextQuestion();
          _secondRemaining = 15;
          updateShuffleOption();
        }
      });
    });
  }
}
