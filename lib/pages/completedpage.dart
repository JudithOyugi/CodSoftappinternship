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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                // Score Circle
                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$scorePercentage%",
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A63AC),
                          ),
                        ),
                        Text(
                          "Score",
                          style: TextStyle(
                            fontSize: 20,
                            color: const Color(0xFF4A63AC).withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Stats Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildStatRow(
                          "Total Questions", totalQuestions.toString()),
                      const Divider(height: 30),
                      _buildStatRow(
                          "Correct Answers", correctAnswers.toString(),
                          color: Colors.green),
                      const SizedBox(height: 15),
                      _buildStatRow("Wrong Answers", wrongAnswers.toString(),
                          color: Colors.red),
                    ],
                  ),
                ),

                const Spacer(),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      icon: Icons.refresh,
                      label: "Play Again",
                      onTap: () {
                        onPlayAgain();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Homepage()),
                        );
                      },
                    ),
                    _buildActionButton(
                      icon: Icons.visibility,
                      label: "Review Answers",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Reviewanswerspage(
                              questions: questions,
                              userSelectedAnswers: userSelectedAnswers,
                            ),
                          ),
                        );
                      },
                    ),
                    _buildActionButton(
                      icon: Icons.home,
                      label: "Home",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Intropage()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: const Color(0xFF4A63AC).withOpacity(0.8),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color ?? const Color(0xFF4A63AC),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF4A63AC),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 32,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF4A63AC),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
