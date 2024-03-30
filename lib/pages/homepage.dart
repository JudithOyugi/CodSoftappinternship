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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              height: 421,
              width: 400,
              child: Stack(
                children: [
                  Container(
                    height: 240,
                    width: 390,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A438C),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Text(
                      'Correct: $correctAnswers',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Text(
                      'Wrong: $wrongAnswers',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    left: 22,
                    right: 15,
                    child: Container(
                      height: 170,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 1),
                                blurRadius: 5,
                                spreadRadius: 3,
                                color: const Color(0xffA42FC1).withOpacity(.4))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          children: [
                            const SizedBox(height: 25),
                            Text(
                              'Question ${number + 1}/${responseData.length}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xffA42FC1),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(responseData.isNotEmpty &&
                                    number < responseData.length
                                ? responseData[number]['question']
                                : ''),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 210,
                    left: 140,
                    child: CircleAvatar(
                      radius: 42,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Text(
                          _secondRemaining.toString(),
                          style: const TextStyle(
                            color: Color(0xFF2A438C),
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: (responseData.isNotEmpty &&
                      responseData[number]['incorrect_answers'] != null)
                  ? shuffledOptions.map((option) {
                      return Optionspage(
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
                      );
                    }).toList()
                  : [],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2A438C),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                ),
                onPressed: () {
                  nextQuestion();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
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
      // Navigate to CompletedPage
      Navigator.push(
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
