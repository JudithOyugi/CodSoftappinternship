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
      appBar: AppBar(
        title: const Text('Review Answers'),
        backgroundColor: const Color(0xFF2A438C),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          final correctAnswer = question['correct_answer'];
          final userAnswer = userSelectedAnswers[index];
          final incorrectAnswers = List<String>.from(question['incorrect_answers']);
          final allOptions = [correctAnswer, ...incorrectAnswers];
          allOptions.shuffle();

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${index + 1}:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    question['question'],
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Correct Answer:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    correctAnswer,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Your Answer:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    userAnswer ?? 'No answer selected', // Display user's answer or a default message
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
