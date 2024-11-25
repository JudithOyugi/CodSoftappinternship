import 'package:flutter/material.dart';

class Reviewanswerspage extends StatelessWidget {
  final List<Map<String, dynamic>> questions; // List of questions with correct answers
  final List<String?> userSelectedAnswers; // List of user-selected answers

  const Reviewanswerspage({
    Key? key,
    required this.questions,
    required this.userSelectedAnswers,
  }) : super(key: key);
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
            child: Column(
              children: [
                // Custom App Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text(
                        'Review Answers',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Questions List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final question = questions[index];
                      final correctAnswer = question['correct_answer'];
                      final userAnswer = userSelectedAnswers[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Question Number Banner
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: const BoxDecoration(
                                color: Color(0xFF4A63AC),
                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              child: Text(
                                'Question ${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            // Question Content
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    question['question'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF4A63AC),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Correct Answer
                                  _buildAnswerRow(
                                    'Correct Answer:',
                                    correctAnswer,
                                    Colors.green,
                                    Icons.check_circle,
                                  ),
                                  const SizedBox(height: 12),

                                  // User Answer
                                  _buildAnswerRow(
                                    'Your Answer:',
                                    userAnswer ?? 'No answer selected',
                                    userAnswer == correctAnswer ? Colors.green : Colors.red,
                                    userAnswer == correctAnswer ? Icons.check_circle : Icons.cancel,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildAnswerRow(String label, String answer, Color color, IconData icon) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  answer,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
}