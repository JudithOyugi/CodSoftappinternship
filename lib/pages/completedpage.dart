import 'package:flutter/material.dart';
import 'package:quiz_app/pages/homepage.dart';
import 'package:quiz_app/pages/intropage.dart';
import 'package:quiz_app/pages/reviewanswerspage.dart';

class Completedpage extends StatelessWidget {
  final int correctAnswers;
  final int wrongAnswers;
  final int totalQuestions;
  final Function() onPlayAgain;
   final List<Map<String, dynamic>> questions;
  final List<String?> userSelectedAnswers;

  const Completedpage({
    Key? key,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.totalQuestions,
    required this.onPlayAgain,
     required this.questions,
    required this.userSelectedAnswers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double percentage = (correctAnswers / totalQuestions) * 100;
    String scorePercentage = percentage.toStringAsFixed(0);

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 523,
            width: 480,
            child: Stack(
              children: [
                Container(
                  height: 340,
                  width: 410,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A438C),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: CircleAvatar(
                      radius: 85,
                      backgroundColor: Colors.white.withOpacity(.3),
                      child: CircleAvatar(
                        radius: 71,
                        backgroundColor: Colors.white.withOpacity(.4),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("Your Score",
                                    style: TextStyle(
                                      color: Color(0xFF2A438C),
                                      fontSize: 20,
                                    )),
                                RichText(
                                  text: TextSpan(
                                      text: scorePercentage,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2A438C),
                                      ),
                                      children: const [
                                        TextSpan(
                                          text: "pt",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2A438C),
                                          ),
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60,
                  left: 22,
                  right: 18,
                  child: Container(
                    height: 190,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 3,
                              color: const Color(0xFF2A438C).withOpacity(.7),
                              offset: const Offset(0, 1))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFF2A438C)),
                                          ),
                                          Text(
                                            "$percentage%",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                color: Color(0xFF2A438C)),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Text("Completed"),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFF2A438C)),
                                          ),
                                          Text(
                                            "$totalQuestions",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                color: Color(0xFF2A438C)),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Text("Total Questions"),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green),
                                          ),
                                          Text(
                                            "$correctAnswers",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                color: Colors.green),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Text("Correct"),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 48.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 15,
                                              width: 15,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              "$wrongAnswers",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20,
                                                  color: Colors.red),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Text("Wrong"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 7),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          onPlayAgain();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Homepage(),
                              ));
                              
                        },
                        child: const CircleAvatar(
                            backgroundColor: Color(
                              (0xFF2A438C),
                            ),
                            radius: 35,
                            child: Center(
                              child: Icon(
                                Icons.refresh,
                                size: 35,
                                color: Colors.white,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Play Again",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                   Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  Reviewanswerspage(questions: questions,
                                userSelectedAnswers: userSelectedAnswers,),
                              ));
                        },
                        child: const CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 42, 122, 140),
                            radius: 35,
                            child: Center(
                              child: Icon(
                                Icons.visibility_rounded,
                                size: 35,
                                color: Colors.white,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Review Answer",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 29),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Intropage(),
                              ));
                        },
                        child: const CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 164, 86, 164),
                            radius: 35,
                            child: Center(
                              child: Icon(
                                Icons.home,
                                size: 35,
                                color: Colors.white,
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
